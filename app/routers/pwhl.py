import json
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from datetime import date, timedelta
import httpx
from bs4 import BeautifulSoup

from app.database import get_db
from app.models.news import NewsArticle
from app.models.player import Player
from app.models.team import PWHLTeam
from app.models.game import Game
from app.routers.deps import get_current_user
from app.models.user import User

router = APIRouter(prefix="/pwhl", tags=["pwhl"])


@router.get("/standings")
def get_standings(
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
    season: str = "2025-2026",
):
    teams = db.query(PWHLTeam).all()
    games = db.query(Game).filter(Game.status == "final", Game.season == season).all()

    standings = {}
    for team in teams:
        standings[team.id] = {
            "id": team.id,
            "name": team.name,
            "city": team.city,
            "abbreviation": team.abbreviation,
            "logo_url": team.logo_url,
            "primary_color": team.primary_color,
            "secondary_color": team.secondary_color,
            "gp": 0, "w": 0, "l": 0, "otl": 0, "pts": 0, "gf": 0, "ga": 0,
        }

    for game in games:
        if game.home_team_id not in standings or game.away_team_id not in standings:
            continue

        home = standings[game.home_team_id]
        away = standings[game.away_team_id]

        home["gp"] += 1
        away["gp"] += 1
        home["gf"] += game.home_score
        home["ga"] += game.away_score
        away["gf"] += game.away_score
        away["ga"] += game.home_score

        is_ot = game.is_overtime or game.is_shootout

        if game.home_score > game.away_score:
            home["w"] += 1
            home["pts"] += 2
            if is_ot:
                away["otl"] += 1
                away["pts"] += 1
            else:
                away["l"] += 1
        else:
            away["w"] += 1
            away["pts"] += 2
            if is_ot:
                home["otl"] += 1
                home["pts"] += 1
            else:
                home["l"] += 1

    result = sorted(
        standings.values(),
        key=lambda x: (-x["pts"], -x["w"], -(x["gf"] - x["ga"]))
    )
    return result


@router.get("/teams/{team_id}/roster")
def get_team_roster(
    team_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    team = db.query(PWHLTeam).filter(PWHLTeam.id == team_id).first()
    if not team:
        raise HTTPException(status_code=404, detail="Team not found")

    players = db.query(Player).options(
        joinedload(Player.stats),
        joinedload(Player.pwhl_team),
    ).filter(
        Player.pwhl_team_id == team_id,
        Player.is_active == True,
    ).all()

    from app.routers.players import player_to_response
    return [player_to_response(p) for p in players]


@router.get("/games/upcoming")
def get_upcoming_games(
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    today = date.today()
    in_14_days = today + timedelta(days=14)

    games = db.query(Game).options(
        joinedload(Game.home_team),
        joinedload(Game.away_team),
    ).filter(
        Game.status == "scheduled",
        Game.game_date >= today,
        Game.game_date <= in_14_days,
    ).order_by(Game.game_date).all()

    return [
        {
            "id": g.id,
            "game_date": str(g.game_date),
            "status": g.status,
            "home_team": g.home_team.abbreviation if g.home_team else None,
            "home_team_name": g.home_team.name if g.home_team else None,
            "home_team_city": g.home_team.city if g.home_team else None,
            "home_logo_url": g.home_team.logo_url if g.home_team else None,
            "away_team": g.away_team.abbreviation if g.away_team else None,
            "away_team_name": g.away_team.name if g.away_team else None,
            "away_team_city": g.away_team.city if g.away_team else None,
            "away_logo_url": g.away_team.logo_url if g.away_team else None,
            "home_score": g.home_score,
            "away_score": g.away_score,
            "venue": g.venue,
        }
        for g in games
    ]


@router.get("/articles")
async def get_ai_articles(
    page: int = 1,
    page_size: int = 20,
    db: Session = Depends(get_db)
):
    """Return AI-generated PWHL trend articles (public, no auth required)."""
    offset = (page - 1) * page_size
    total = db.query(NewsArticle).filter(
        NewsArticle.url.like("%unsupervisedbias.com/trends/%")
    ).count()
    articles = (
        db.query(NewsArticle)
        .filter(NewsArticle.url.like("%unsupervisedbias.com/trends/%"))
        .order_by(NewsArticle.date_str.desc(), NewsArticle.scraped_at.desc())
        .offset(offset)
        .limit(page_size)
        .all()
    )
    return {
        "total": total,
        "page": page,
        "page_size": page_size,
        "articles": [
            {
                "id": a.id,
                "title": a.title,
                "url": a.url,
                "summary": a.summary,
                "thumbnail": a.thumbnail or a.fallback_image,
                "date": a.date_str,
            }
            for a in articles
        ],
    }


@router.get("/news")
async def get_news(db: Session = Depends(get_db)):
    """Serve news from DB cache (populated by scrape_news.py every 4h)."""
    articles = db.query(NewsArticle).order_by(NewsArticle.date_str.desc(), NewsArticle.scraped_at.desc()).limit(40).all()

    # Sanitize — never serve Google thumbnails to the app
    GOOGLE_PATTERNS = ["news.google.com", "J6_coFbogxhRI9iM864NL", "googleusercontent.com", "lh3.google"]
    for a in articles:
        if a.thumbnail and any(p in a.thumbnail for p in GOOGLE_PATTERNS):
            a.thumbnail = None
    if articles:
        return [
            {
                "title": a.title,
                "url": a.url,
                "thumbnail": a.thumbnail or a.fallback_image,
                "team_logos": json.loads(a.team_logos) if a.team_logos else [],
                "player_image_url": a.player_image_url,
                "date": a.date_str,
            }
            for a in articles
        ]
    # Cold start: scrape live if DB is empty
    return []
