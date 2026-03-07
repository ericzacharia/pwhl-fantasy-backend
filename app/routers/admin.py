from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.routers.deps import get_current_user
from app.models.user import User

router = APIRouter(prefix="/admin", tags=["admin"])


@router.post("/scrape")
async def trigger_scrape(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    """Manually trigger a data scrape (admin action)."""
    from app.services.scraper import run_full_scrape
    results = await run_full_scrape(db)
    return {"message": "Scrape completed", "results": results}


@router.post("/recalculate-fantasy-points")
def recalculate_all_fantasy_points(db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    """Recalculate fantasy points for all player stats."""
    from app.models.player import Player, PlayerStats
    from app.services.scoring import calculate_fantasy_points_default

    stats = db.query(PlayerStats).join(Player).all()
    updated = 0
    for stat in stats:
        stat.fantasy_points = calculate_fantasy_points_default(stat, stat.player.position)
        updated += 1
    db.commit()
    return {"message": f"Updated {updated} stat records"}


@router.get("/stats-summary")
def stats_summary(db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    from app.models.player import Player, PlayerStats
    from app.models.league import League
    from app.models.user import User as UserModel

    return {
        "players": db.query(Player).count(),
        "stats_records": db.query(PlayerStats).count(),
        "users": db.query(UserModel).count(),
        "leagues": db.query(League).count(),
    }
