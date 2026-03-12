from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import or_, desc
from typing import Optional

from app.database import get_db
from app.models.player import Player, PlayerStats
from app.models.team import PWHLTeam
from app.schemas.player import PlayerResponse, PlayerListResponse, PlayerStatsResponse, PWHLTeamResponse
from app.routers.deps import get_current_user
from app.models.user import User

router = APIRouter(prefix="/players", tags=["players"])


def player_to_response(player: Player, season: str = "2025-2026") -> PlayerResponse:
    season_stat = next(
        (s for s in player.stats if s.season == season and s.is_season_total), None
    )
    return PlayerResponse(
        id=player.id,
        pwhl_player_id=player.pwhl_player_id,
        first_name=player.first_name,
        last_name=player.last_name,
        position=player.position,
        jersey_number=player.jersey_number,
        pwhl_team_id=player.pwhl_team_id,
        team_abbreviation=player.pwhl_team.abbreviation if player.pwhl_team else None,
        team_logo_url=player.pwhl_team.logo_url if player.pwhl_team else None,
        nationality=player.nationality,
        birthdate=str(player.birthdate) if player.birthdate else None,
        height_cm=player.height_cm,
        weight_kg=player.weight_kg,
        shoots=player.shoots,
        headshot_url=player.headshot_url,
        is_active=player.is_active,
        season_stats=PlayerStatsResponse.model_validate(season_stat) if season_stat else None,
        fantasy_value=season_stat.fantasy_points if season_stat else 0.0,
    )


@router.get("/seasons")
def get_seasons(db: Session = Depends(get_db)):
    """Return available seasons that have player stats."""
    from sqlalchemy import text as sql_text
    result = db.execute(sql_text(
        "SELECT DISTINCT season FROM player_stats WHERE is_season_total = TRUE ORDER BY season DESC"
    )).fetchall()
    return [r[0] for r in result]



@router.get("/{player_id}/news")
def get_player_news(player_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    """Return news articles that mention this player by name."""
    import json as _json
    player = db.query(Player).filter(Player.id == player_id).first()
    if not player:
        raise HTTPException(status_code=404, detail="Player not found")

    from app.models.news import NewsArticle
    articles = db.query(NewsArticle).all()

    # Search for first name, last name, or full name in title (case-insensitive)
    search_terms = [player.last_name.lower()]
    if player.first_name:
        search_terms.append(player.first_name.lower())

    matched = []
    for a in articles:
        title_lower = a.title.lower()
        if any(term in title_lower for term in search_terms):
            matched.append({
                "title": a.title,
                "url": a.url,
                "thumbnail": a.thumbnail or a.fallback_image,
                "team_logos": _json.loads(a.team_logos) if a.team_logos else [],
                "date": a.date_str,
            })

    return matched

@router.get("", response_model=PlayerListResponse)
def list_players(
    q: Optional[str] = Query(None, description="Search by name"),
    position: Optional[str] = Query(None, description="Filter by position: C,LW,RW,D,G"),
    team_id: Optional[int] = Query(None),
    sort_by: str = Query("fantasy_value", description="Sort by: fantasy_value, points, goals, name"),
    page: int = Query(1, ge=1),
    page_size: int = Query(50, ge=1, le=500),
    season: str = Query("2025-2026"),
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    query = db.query(Player).options(
        joinedload(Player.stats),
        joinedload(Player.pwhl_team),
    ).filter(Player.is_active == True)

    if q:
        search = f"%{q}%"
        query = query.filter(
            or_(Player.first_name.ilike(search), Player.last_name.ilike(search))
        )
    if position:
        query = query.filter(Player.position.in_(position.upper().split(",")))
    if team_id:
        query = query.filter(Player.pwhl_team_id == team_id)

    total = query.count()
    players = query.offset((page - 1) * page_size).limit(page_size).all()

    responses = [player_to_response(p, season=season) for p in players]
    # Filter out players with no stats for the selected season
    responses = [r for r in responses if r.season_stats is not None]

    if sort_by == "fantasy_value":
        responses.sort(key=lambda x: x.fantasy_value or 0, reverse=True)
    elif sort_by == "name":
        responses.sort(key=lambda x: x.last_name)
    elif sort_by == "goals":
        responses.sort(key=lambda x: x.season_stats.goals if x.season_stats else 0, reverse=True)
    elif sort_by == "assists":
        responses.sort(key=lambda x: x.season_stats.assists if x.season_stats else 0, reverse=True)
    elif sort_by == "points":
        responses.sort(key=lambda x: x.season_stats.points if x.season_stats else 0, reverse=True)
    elif sort_by == "wins":
        responses.sort(key=lambda x: x.season_stats.wins if x.season_stats else 0, reverse=True)
    elif sort_by == "gaa":
        responses.sort(key=lambda x: x.season_stats.goals_against_average if x.season_stats else 99.0)
    elif sort_by == "save_pct":
        responses.sort(key=lambda x: x.season_stats.save_percentage if x.season_stats else 0, reverse=True)

    return PlayerListResponse(players=responses, total=total, page=page, page_size=page_size)


@router.get("/{player_id}", response_model=PlayerResponse)
def get_player(player_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    player = db.query(Player).options(joinedload(Player.stats), joinedload(Player.pwhl_team)).filter(Player.id == player_id).first()
    if not player:
        raise HTTPException(status_code=404, detail="Player not found")
    return player_to_response(player)


@router.get("/{player_id}/stats", response_model=list[PlayerStatsResponse])
def get_player_stats(player_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    stats = db.query(PlayerStats).filter(
        PlayerStats.player_id == player_id
    ).order_by(desc(PlayerStats.created_at)).all()
    return stats


@router.get("/teams/all", response_model=list[PWHLTeamResponse])
def list_teams(db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    return db.query(PWHLTeam).all()
