"""
Daily lineup scoring service.

Rules:
1. Lineup locks at first puck drop of the day (earliest game_time for that date in ET)
2. At lock time, snapshot the current lineup for each team
3. After all games finish, score each active slot player based on that day's game stats
4. BN players score 0 regardless
5. Active players with no game that day score 0
6. Lineup carries forward if not updated before lock
"""
import datetime
import pytz
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.models.fantasy import FantasyTeam, FantasyRoster, LineupSnapshot
from app.models.pwhl import Game, Player
from app.models.player import PlayerStats
from app.services.scoring import calculate_fantasy_points_default
from app.services.league_rules import SLOT_ELIGIBILITY

ET = pytz.timezone("America/New_York")


def get_todays_games(db: Session, date: datetime.date = None):
    """Get all games for a given date (ET)."""
    if date is None:
        date = datetime.datetime.now(ET).date()
    return db.query(Game).filter(Game.game_date == date).all()


def get_lineup_lock_time(db: Session, date: datetime.date = None) -> datetime.datetime | None:
    """First puck drop for the given date — lineup locks at this time."""
    if date is None:
        date = datetime.datetime.now(ET).date()
    games = get_todays_games(db, date)
    if not games:
        return None
    times = [g.game_time for g in games if g.game_time]
    if not times:
        return None
    return min(times)


def is_lineup_locked(db: Session, date: datetime.date = None) -> bool:
    """True if the lineup lock time has passed for today."""
    lock = get_lineup_lock_time(db, date)
    if lock is None:
        return False
    now = datetime.datetime.now(ET)
    lock_et = lock.astimezone(ET) if lock.tzinfo else ET.localize(lock)
    return now >= lock_et


def snapshot_lineup(db: Session, fantasy_team_id: int, date: datetime.date = None):
    """
    Take a snapshot of the current lineup for a team on a given date.
    Called at lineup lock time (or carried forward from yesterday if unchanged).
    """
    if date is None:
        date = datetime.datetime.now(ET).date()

    # Don't re-snapshot if already done
    existing = db.query(LineupSnapshot).filter_by(
        fantasy_team_id=fantasy_team_id, snapshot_date=date
    ).first()
    if existing:
        return

    entries = db.query(FantasyRoster).filter_by(
        fantasy_team_id=fantasy_team_id, is_active=True
    ).all()

    now_utc = datetime.datetime.now(pytz.utc)
    for entry in entries:
        slot_label = entry.position_slot or "BN_unset"
        slot_type = slot_label.split("_")[0] if "_" in slot_label else "BN"
        snap = LineupSnapshot(
            fantasy_team_id=fantasy_team_id,
            snapshot_date=date,
            slot_label=slot_label,
            slot_type=slot_type,
            player_id=entry.player_id,
            fantasy_points_earned=0.0,
            locked_at=now_utc,
        )
        db.add(snap)

    db.commit()


def score_daily_lineup(db: Session, date: datetime.date = None, season: str = "2025-2026"):
    """
    Score all fantasy teams for a given game date.
    Called after all games on that date are final.
    Only active-slot players with a game that day earn points.
    """
    if date is None:
        date = datetime.datetime.now(ET).date()

    # Get teams that played today
    games = get_todays_games(db, date)
    if not games:
        return {"scored": 0, "date": str(date)}

    playing_team_ids = set()
    for g in games:
        if g.status == "final":
            playing_team_ids.add(g.home_team_id)
            playing_team_ids.add(g.away_team_id)

    # Players who played today
    playing_player_ids = set(
        p.id for p in db.query(Player).filter(Player.team_id.in_(playing_team_ids)).all()
    )

    # Snapshot all teams if not already done (carry-forward)
    all_teams = db.query(FantasyTeam).all()
    for team in all_teams:
        snapshot_lineup(db, team.id, date)

    # Score each team's snapshot
    scored_teams = 0
    for team in all_teams:
        snaps = db.query(LineupSnapshot).filter_by(
            fantasy_team_id=team.id, snapshot_date=date
        ).all()

        day_total = 0.0
        for snap in snaps:
            if snap.slot_type == "BN" or snap.player_id is None:
                snap.fantasy_points_earned = 0.0
                continue
            if snap.player_id not in playing_player_ids:
                snap.fantasy_points_earned = 0.0
                continue

            # Get player's stats for this game day
            # For now use per-game average (full per-game stats TBD)
            player = db.query(Player).filter_by(id=snap.player_id).first()
            stat = db.query(PlayerStats).filter_by(
                player_id=snap.player_id, season=season, is_season_total=True
            ).first()
            if stat and stat.games_played and stat.games_played > 0:
                # Approximate daily stats as per-game average
                gp = stat.games_played
                daily_stat = _scale_stat(stat, 1.0 / gp)
                pts = calculate_fantasy_points_default(daily_stat, player.position if player else "F")
            else:
                pts = 0.0

            snap.fantasy_points_earned = round(pts, 2)
            day_total += pts

        # Add day's points to team total
        team.total_points = (team.total_points or 0.0) + day_total
        scored_teams += 1

    db.commit()
    return {"scored": scored_teams, "date": str(date), "playing_teams": len(playing_team_ids)}


class _scale_stat:
    """Lightweight stat proxy scaled by a factor (e.g. 1/GP for daily average)."""
    def __init__(self, stat: PlayerStats, factor: float):
        self._s = stat
        self._f = factor

    def __getattr__(self, name):
        val = getattr(self._s, name, 0) or 0
        if isinstance(val, (int, float)):
            return val * self._f
        return val
