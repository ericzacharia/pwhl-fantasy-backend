"""
PWHL Fantasy league rules — fixed roster config and dynamic max team size.

Active lineup (7 starters):
  F, F, F  — Forward (maps to C/LW/RW)
  D, D     — Defenseman
  G        — Goalie
  UTIL     — Any F or D

Bench: 6 spots
Total: 13 slots, 13 draft rounds
"""
from sqlalchemy import text
from app.database import SessionLocal

# Named slots in order
ACTIVE_SLOTS = ["F", "F", "F", "D", "D", "G", "UTIL"]
BENCH_SLOTS  = ["BN", "BN", "BN", "BN", "BN", "BN"]
ALL_SLOTS    = ACTIVE_SLOTS + BENCH_SLOTS  # 13 total

# Which positions are valid for each slot type
SLOT_ELIGIBILITY = {
    "F":    {"F"},
    "D":    {"D"},
    "G":    {"G"},
    "UTIL": {"F", "D"},
    "BN":   {"F", "D", "G"},
}

ROSTER_SLOTS = {"F": 3, "D": 2, "G": 1, "UTIL": 1, "BN": 6}
TOTAL_ROSTER_SLOTS = sum(ROSTER_SLOTS.values())  # 13
DRAFT_ROUNDS = TOTAL_ROSTER_SLOTS
MIN_WAIVER_POOL = 20


def is_slot_eligible(slot_type: str, player_position: str) -> bool:
    """Can a player of this position fill this slot type?"""
    return player_position.upper() in SLOT_ELIGIBILITY.get(slot_type, set())


def validate_lineup(slot_assignments: dict, player_positions: dict) -> list:
    """
    Validate a proposed lineup assignment.
    slot_assignments: {"F_0": player_id, "D_0": player_id, ...}
    player_positions: {player_id: "F"/"D"/"G"}
    Returns list of error strings (empty = valid).
    """
    errors = []
    for slot_label, player_id in slot_assignments.items():
        if player_id is None:
            continue
        slot_type = slot_label.split("_")[0]
        pos = player_positions.get(player_id, "").upper()
        if not is_slot_eligible(slot_type, pos):
            errors.append(f"Player {player_id} ({pos}) cannot fill {slot_type} slot")
    return errors


def get_max_teams(season: str) -> int:
    db = SessionLocal()
    try:
        result = db.execute(
            text("SELECT COUNT(DISTINCT player_id) FROM player_stats WHERE season=:s AND games_played>0"),
            {"s": season}
        )
        draftable = result.scalar() or 0
        return min(13, max(2, int((draftable - MIN_WAIVER_POOL) // DRAFT_ROUNDS)))
    finally:
        db.close()


def get_league_rules(season: str) -> dict:
    return {
        "roster_slots": ROSTER_SLOTS,
        "active_slots": ACTIVE_SLOTS,
        "bench_slots": BENCH_SLOTS,
        "slot_eligibility": {k: list(v) for k, v in SLOT_ELIGIBILITY.items()},
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
