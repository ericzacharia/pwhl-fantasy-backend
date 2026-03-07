"""
PWHL Fantasy league rules — fixed roster config and dynamic max team size.
"""
from sqlalchemy import text
from app.database import SessionLocal

ROSTER_SLOTS = {"F": 6, "D": 3, "G": 1, "UTIL": 1, "BN": 2}
TOTAL_ROSTER_SLOTS = sum(ROSTER_SLOTS.values())  # 13
DRAFT_ROUNDS = TOTAL_ROSTER_SLOTS
MIN_WAIVER_POOL = 20

def get_max_teams(season: str) -> int:
    db = SessionLocal()
    try:
        result = db.execute(
            text("SELECT COUNT(DISTINCT player_id) FROM player_stats WHERE season=:s AND games_played>0"),
            {"s": season}
        )
        draftable = result.scalar() or 0
        return max(2, int((draftable - MIN_WAIVER_POOL) // DRAFT_ROUNDS))
    finally:
        db.close()

def get_league_rules(season: str) -> dict:
    return {
        "roster_slots": ROSTER_SLOTS,
        "total_roster_slots": TOTAL_ROSTER_SLOTS,
        "draft_rounds": DRAFT_ROUNDS,
        "max_teams": get_max_teams(season),
        "min_teams": 2,
        "scoring": {
            "skater": {"goals": 3.0, "assists": 2.0, "plus_minus": 1.0,
                       "shots": 0.3, "penalty_minutes": -0.5},
            "goalie": {"wins": 5.0, "saves": 0.2, "goals_against": -1.0, "shutouts": 3.0}
        }
    }
