from app.models.player import PlayerStats
from app.models.league import ScoringSettings


def calculate_fantasy_points(stats: PlayerStats, scoring: ScoringSettings, position: str) -> float:
    """Calculate fantasy points for a player's stats using league scoring settings."""
    pts = 0.0

    if position == "G":
        pts += stats.wins * scoring.goalie_win_pts
        pts += stats.saves * scoring.goalie_save_pts
        pts += stats.goals_against * scoring.goals_against_pts
        pts += stats.shutouts * scoring.shutout_pts
        pts += stats.losses * scoring.goalie_loss_pts
        otl_pts = getattr(scoring, 'overtime_loss_pts', 0.0)
        pts += (stats.overtime_losses or 0) * otl_pts
    else:
        pts += stats.goals * scoring.goal_pts
        pts += stats.assists * scoring.assist_pts
        pts += stats.plus_minus * scoring.plus_minus_pts
        pts += stats.penalty_minutes * scoring.pim_pts
        pts += stats.shots * scoring.shot_pts
        pts += stats.hits * scoring.hit_pts
        pts += stats.blocks * scoring.block_pts

    return round(pts, 2)


def calculate_fantasy_points_default(stats: PlayerStats, position: str) -> float:
    """Calculate using default scoring settings."""

    class DefaultScoring:
        goal_pts = 2.0
        assist_pts = 1.0
        plus_minus_pts = 0.5
        pim_pts = -0.5
        shot_pts = 0.1
        hit_pts = 0.0
        block_pts = 0.0
        goalie_win_pts = 4.0
        goalie_save_pts = 0.2
        goals_against_pts = -2.0
        shutout_pts = 3.0
        goalie_loss_pts = 0.0
        overtime_loss_pts = 1.0

    return calculate_fantasy_points(stats, DefaultScoring(), position)


def recalculate_team_points(fantasy_team_id: int, db) -> float:
    """Recalculate total fantasy points for a team."""
    from sqlalchemy import func
    from app.models.fantasy import FantasyRoster
    from app.models.player import Player, PlayerStats

    total = (
        db.query(func.sum(PlayerStats.fantasy_points))
        .join(Player, Player.id == PlayerStats.player_id)
        .join(FantasyRoster, FantasyRoster.player_id == Player.id)
        .filter(
            FantasyRoster.fantasy_team_id == fantasy_team_id,
            FantasyRoster.is_active == True,
            PlayerStats.is_season_total == True,
        )
        .scalar()
    )
    return total or 0.0
