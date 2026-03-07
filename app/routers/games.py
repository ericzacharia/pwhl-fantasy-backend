from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session, joinedload
from typing import Optional
from datetime import date

from app.database import get_db
from app.models.game import Game
from app.models.team import PWHLTeam
from app.routers.deps import get_current_user
from app.models.user import User

router = APIRouter(prefix="/games", tags=["games"])


@router.get("")
def list_games(
    status: Optional[str] = Query(None, description="scheduled, live, final"),
    team_id: Optional[int] = Query(None),
    from_date: Optional[date] = Query(None),
    to_date: Optional[date] = Query(None),
    limit: int = Query(100, ge=1, le=500),
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    query = db.query(Game).options(
        joinedload(Game.home_team),
        joinedload(Game.away_team),
    )
    if status:
        query = query.filter(Game.status == status)
    if team_id:
        query = query.filter(
            (Game.home_team_id == team_id) | (Game.away_team_id == team_id)
        )
    if from_date:
        query = query.filter(Game.game_date >= from_date)
    if to_date:
        query = query.filter(Game.game_date <= to_date)

    # Scheduled: soonest first; finals: most recent first
    if status == "scheduled":
        games = query.order_by(Game.game_date.asc()).limit(limit).all()
    else:
        games = query.order_by(Game.game_date.desc()).limit(limit).all()

    return [
        {
            "id": g.id,
            "game_date": str(g.game_date),
            "game_time": g.game_time.isoformat() if g.game_time else None,
            "status": g.status,
            "home_team": g.home_team.abbreviation if g.home_team else None,
            "home_team_name": g.home_team.name if g.home_team else None,
            "home_logo_url": g.home_team.logo_url if g.home_team else None,
            "away_team": g.away_team.abbreviation if g.away_team else None,
            "away_team_name": g.away_team.name if g.away_team else None,
            "away_logo_url": g.away_team.logo_url if g.away_team else None,
            "home_score": g.home_score,
            "away_score": g.away_score,
            "period": g.period,
            "is_overtime": g.is_overtime,
            "venue": g.venue,
        }
        for g in games
    ]


@router.get("/{game_id}")
def get_game(game_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    from fastapi import HTTPException
    game = db.query(Game).options(
        joinedload(Game.home_team), joinedload(Game.away_team), joinedload(Game.player_stats)
    ).filter(Game.id == game_id).first()
    if not game:
        raise HTTPException(status_code=404, detail="Game not found")
    return {
        "id": game.id,
        "game_date": str(game.game_date),
        "status": game.status,
        "home_team": game.home_team.name if game.home_team else None,
        "away_team": game.away_team.name if game.away_team else None,
        "home_score": game.home_score,
        "away_score": game.away_score,
        "period": game.period,
        "is_overtime": game.is_overtime,
        "is_shootout": game.is_shootout,
        "venue": game.venue,
    }
