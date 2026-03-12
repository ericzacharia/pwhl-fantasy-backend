"""
PWHL Stats & Trends — auto-detected storylines from recent game data.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.database import get_db

router = APIRouter(prefix="/api/v1/trends", tags=["trends"])


def _recent_games(db, n=10):
    """Last N completed game dates."""
    rows = db.execute(text("""
        SELECT DISTINCT game_date FROM games
        WHERE status = 'final'
        ORDER BY game_date DESC
        LIMIT :n
    """), {"n": n}).fetchall()
    return [r[0] for r in rows]


@router.get("")
def get_trends(db: Session = Depends(get_db), season: str = "2025-2026", last_n: int = 10):
    """Return a list of auto-detected trends for the current season."""
    trends = []

    # --- Team trends ---

    # 1. Teams with scoring droughts (≤1 goal in last N games)
    rows = db.execute(text("""
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.home_team_id = t.id THEN g.home_score ELSE g.away_score END) as total_goals,
               COUNT(*) as gp
        FROM teams t
        JOIN games g ON (g.home_team_id = t.id OR g.away_team_id = t.id)
        WHERE g.status = 'final'
          AND g.game_date >= (SELECT game_date FROM games WHERE status='final' ORDER BY game_date DESC LIMIT 1 OFFSET :offset)
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY total_goals ASC
    """), {"offset": last_n - 1}).fetchall()

    for r in rows:
        gp = r.gp or 1
        avg = (r.total_goals or 0) / gp
        if avg <= 1.2:
            trends.append({
                "id": f"drought_{r.abbreviation}",
                "category": "Team Offense",
                "title": f"{r.name} scoring drought",
                "description": f"{r.name} has averaged {avg:.1f} goals/game over their last {gp} games.",
                "severity": "warning" if avg <= 1.0 else "info",
                "team": r.abbreviation,
            })

    # 2. Teams on winning streaks (≥3)
    rows = db.execute(text("""
        WITH recent AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id = t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id = t.id AND g.away_score > g.home_score)
                        THEN 1 ELSE 0 END as won
            FROM teams t
            JOIN games g ON (g.home_team_id = t.id OR g.away_team_id = t.id)
            WHERE g.status = 'final'
            ORDER BY t.id, g.game_date DESC
        )
        SELECT id, name, abbreviation,
               SUM(won) as wins,
               COUNT(*) as gp
        FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) as rn FROM recent) r
        WHERE rn <= :n
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 3
        ORDER BY wins DESC
    """), {"n": last_n}).fetchall()

    for r in rows:
        if r.wins >= 3 and r.wins == r.gp:
            trends.append({
                "id": f"streak_{r.abbreviation}",
                "category": "Team Form",
                "title": f"{r.name} on a {r.wins}-game win streak",
                "description": f"{r.name} has won {r.wins} consecutive games.",
                "severity": "positive",
                "team": r.abbreviation,
            })
        elif r.wins >= int(r.gp * 0.7):
            trends.append({
                "id": f"form_{r.abbreviation}",
                "category": "Team Form",
                "title": f"{r.name} in strong form",
                "description": f"{r.name} has won {r.wins} of their last {r.gp} games.",
                "severity": "positive",
                "team": r.abbreviation,
            })

    # 3. Top scorers last 10 games
    rows = db.execute(text("""
        SELECT p.full_name, t.abbreviation,
               SUM(ps.goals) as goals, SUM(ps.assists) as assists,
               SUM(ps.points) as points, COUNT(*) as gp
        FROM players p
        JOIN teams t ON t.id = p.team_id
        JOIN player_stats ps ON ps.player_id = p.id
        WHERE ps.season = :season AND ps.is_season_total = false
          AND ps.game_date >= (SELECT game_date FROM games WHERE status='final' ORDER BY game_date DESC LIMIT 1 OFFSET :offset)
          AND p.position != 'G'
        GROUP BY p.id, p.full_name, t.abbreviation
        HAVING COUNT(*) >= 3
        ORDER BY points DESC
        LIMIT 3
    """), {"season": season, "offset": last_n - 1}).fetchall()

    for r in rows:
        trends.append({
            "id": f"scorer_{r.full_name.replace(' ','_')}",
            "category": "Hot Players",
            "title": f"{r.full_name} on a tear",
            "description": f"{r.full_name} ({r.abbreviation}) has {r.points} points ({r.goals}G {r.assists}A) in their last {r.gp} games.",
            "severity": "positive",
            "player": r.full_name,
            "team": r.abbreviation,
        })

    # 4. Goalie save % leaders last 10 games
    rows = db.execute(text("""
        SELECT p.full_name, t.abbreviation,
               AVG(ps.save_percentage) as avg_svp, COUNT(*) as gp
        FROM players p
        JOIN teams t ON t.id = p.team_id
        JOIN player_stats ps ON ps.player_id = p.id
        WHERE ps.season = :season AND ps.is_season_total = false
          AND ps.game_date >= (SELECT game_date FROM games WHERE status='final' ORDER BY game_date DESC LIMIT 1 OFFSET :offset)
          AND p.position = 'G'
        GROUP BY p.id, p.full_name, t.abbreviation
        HAVING COUNT(*) >= 2
        ORDER BY avg_svp DESC
        LIMIT 2
    """), {"season": season, "offset": last_n - 1}).fetchall()

    for r in rows:
        if r.avg_svp and r.avg_svp > 0.92:
            trends.append({
                "id": f"goalie_{r.full_name.replace(' ','_')}",
                "category": "Hot Goalies",
                "title": f"{r.full_name} is locked in",
                "description": f"{r.full_name} ({r.abbreviation}) has a .{int(r.avg_svp*1000):03d} SV% over their last {r.gp} starts.",
                "severity": "positive",
                "player": r.full_name,
                "team": r.abbreviation,
            })

    # 5. Close games trend (OT/SO finishes)
    row = db.execute(text("""
        SELECT COUNT(*) as ot_games,
               (SELECT COUNT(*) FROM games WHERE status='final'
                AND game_date >= (SELECT game_date FROM games WHERE status='final' ORDER BY game_date DESC LIMIT 1 OFFSET :offset)) as total
        FROM games
        WHERE status = 'final'
          AND ABS(home_score - away_score) <= 1
          AND game_date >= (SELECT game_date FROM games WHERE status='final' ORDER BY game_date DESC LIMIT 1 OFFSET :offset)
    """), {"offset": last_n - 1}).fetchone()

    if row and row.total and row.total > 0:
        pct = row.ot_games / row.total
        if pct >= 0.5:
            trends.append({
                "id": "close_games",
                "category": "League",
                "title": "PWHL games are razor close",
                "description": f"{row.ot_games} of the last {row.total} games ({int(pct*100)}%) were decided by 1 goal.",
                "severity": "info",
            })

    # Dedupe and sort by severity
    seen = set()
    unique = []
    for t in trends:
        if t["id"] not in seen:
            seen.add(t["id"])
            unique.append(t)

    order = {"warning": 0, "positive": 1, "info": 2}
    unique.sort(key=lambda x: order.get(x.get("severity", "info"), 2))

    return {"trends": unique[:15], "season": season, "last_n": last_n}
