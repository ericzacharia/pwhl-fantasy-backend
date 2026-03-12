"""
PWHL Stats & Trends — auto-detected storylines.
Uses a ranking model: most trends ALWAYS fire (best/worst/leader in category).
Threshold-only trends are clearly marked.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.database import get_db

router = APIRouter(prefix="/trends", tags=["trends"])


# ── helpers ────────────────────────────────────────────────────────────────────

def _q(db, sql: str, params: dict = None):
    return db.execute(text(sql), params or {}).fetchall()

def _q1(db, sql: str, params: dict = None):
    return db.execute(text(sql), params or {}).fetchone()

def _add(trends: list, id_: str, category: str, title: str, desc: str,
         severity: str = "info", team: str = None, player: str = None):
    trends.append({
        "id": id_,
        "category": category,
        "title": title,
        "description": desc,
        "severity": severity,
        **({"team": team} if team else {}),
        **({"player": player} if player else {}),
    })


# ── endpoint ───────────────────────────────────────────────────────────────────

@router.get("")
def get_trends(db: Session = Depends(get_db), season: str = "2025-2026", last_n: int = 10):
    """Return ranked PWHL trends. Most fire unconditionally (ranking leaders)."""
    trends = []
    offset = last_n - 1  # for "last N games" subqueries

    # ── TEAM TRENDS (from games table) ────────────────────────────────────────

    # 1. Best goal differential (season) — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.home_team_id=t.id THEN g.home_score ELSE g.away_score END) as gf,
               SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END) as ga,
               COUNT(*) as gp
        FROM pwhl_teams t
        JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY (SUM(CASE WHEN g.home_team_id=t.id THEN g.home_score ELSE g.away_score END)
                 -SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        diff = (r.gf or 0) - (r.ga or 0)
        sign = "+" if diff >= 0 else ""
        _add(trends, f"gd_{r.abbreviation}", "Standings",
             f"{r.name} lead the PWHL in goal differential",
             f"{r.name} have a {sign}{diff} goal differential this season ({r.gf} GF, {r.ga} GA in {r.gp} games).",
             "positive", team=r.abbreviation)

    # 2. Worst goal differential — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.home_team_id=t.id THEN g.home_score ELSE g.away_score END) as gf,
               SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END) as ga,
               COUNT(*) as gp
        FROM pwhl_teams t
        JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY (SUM(CASE WHEN g.home_team_id=t.id THEN g.home_score ELSE g.away_score END)
                 -SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END)) ASC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        diff = (r.gf or 0) - (r.ga or 0)
        _add(trends, f"worst_gd_{r.abbreviation}", "Standings",
             f"{r.name} have the PWHL's worst goal differential",
             f"{r.name} sit at {diff} goal differential this season ({r.gf} GF, {r.ga} GA in {r.gp} games) — last in the league.",
             "warning", team=r.abbreviation)

    # 3. Best home record — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.home_score > g.away_score THEN 1 ELSE 0 END) as hw,
               COUNT(*) as hgp
        FROM pwhl_teams t
        JOIN games g ON g.home_team_id=t.id
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        HAVING COUNT(*) >= 5
        ORDER BY (SUM(CASE WHEN g.home_score > g.away_score THEN 1 ELSE 0 END)::float / COUNT(*)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        pct = round(r.hw / r.hgp * 100)
        _add(trends, f"home_{r.abbreviation}", "Home/Away",
             f"{r.name} are the PWHL's best home team",
             f"{r.name} are {r.hw}-{r.hgp - r.hw} at home this season ({pct}% win rate) — the best home record in the league.",
             "positive", team=r.abbreviation)

    # 4. Best road record — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.away_score > g.home_score THEN 1 ELSE 0 END) as aw,
               COUNT(*) as agp
        FROM pwhl_teams t
        JOIN games g ON g.away_team_id=t.id
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        HAVING COUNT(*) >= 5
        ORDER BY (SUM(CASE WHEN g.away_score > g.home_score THEN 1 ELSE 0 END)::float / COUNT(*)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        pct = round(r.aw / r.agp * 100)
        _add(trends, f"road_{r.abbreviation}", "Home/Away",
             f"{r.name} are the PWHL's best road team",
             f"{r.name} are {r.aw}-{r.agp - r.aw} away from home ({pct}% win rate) — nobody travels better.",
             "positive", team=r.abbreviation)

    # 5. Tightest defense (fewest GA/game) — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END) as ga,
               COUNT(*) as gp
        FROM pwhl_teams t
        JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY (SUM(CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END)::float / COUNT(*)) ASC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        avg = round(r.ga / r.gp, 2)
        _add(trends, f"def_{r.abbreviation}", "Team Defense",
             f"{r.name} have the PWHL's stingiest defense",
             f"{r.name} allow just {avg} goals per game this season — the lowest mark in the league.",
             "positive", team=r.abbreviation)

    # 6. Blowout specialists (most wins by 3+ goals) — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN (g.home_team_id=t.id AND g.home_score - g.away_score >= 3)
                            OR (g.away_team_id=t.id AND g.away_score - g.home_score >= 3)
                        THEN 1 ELSE 0 END) as blowouts,
               COUNT(*) as gp
        FROM pwhl_teams t
        JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY blowouts DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        if r.blowouts >= 2:
            pct = round(r.blowouts / r.gp * 100)
            _add(trends, f"blowout_{r.abbreviation}", "Team Dominance",
                 f"{r.name} win ugly — by a lot",
                 f"{r.name} have won by 3+ goals {r.blowouts} times this season ({pct}% of games) — more than any other team.",
                 "positive", team=r.abbreviation)

    # 7. Best last-5-games point % — always fires
    rows = _q(db, """
        WITH last5 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                        THEN 2
                        WHEN g.is_overtime OR g.is_shootout THEN 1
                        ELSE 0 END as pts
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) as rn
            FROM last5
        )
        SELECT id, name, abbreviation,
               SUM(pts) as earned, COUNT(*)*2 as possible, COUNT(*) as gp
        FROM ranked WHERE rn <= 5
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 5
        ORDER BY (SUM(pts)::float / (COUNT(*)*2)) DESC
        LIMIT 1
    """)
    for r in rows:
        pct = round(r.earned / r.possible * 100)
        _add(trends, f"form5_{r.abbreviation}", "Recent Form",
             f"{r.name} are the hottest team in the PWHL right now",
             f"{r.name} have earned {r.earned} of a possible {r.possible} points in their last {r.gp} games ({pct}% point rate).",
             "positive", team=r.abbreviation)

    # 8. Worst last-5-games — always fires
    rows = _q(db, """
        WITH last5 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                        THEN 2
                        WHEN g.is_overtime OR g.is_shootout THEN 1
                        ELSE 0 END as pts
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) as rn
            FROM last5
        )
        SELECT id, name, abbreviation,
               SUM(pts) as earned, COUNT(*)*2 as possible, COUNT(*) as gp
        FROM ranked WHERE rn <= 5
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 5
        ORDER BY (SUM(pts)::float / (COUNT(*)*2)) ASC
        LIMIT 1
    """)
    for r in rows:
        pct = round(r.earned / r.possible * 100)
        _add(trends, f"cold5_{r.abbreviation}", "Recent Form",
             f"{r.name} are in a dangerous slump",
             f"{r.name} have managed just {r.earned} of a possible {r.possible} points in their last {r.gp} games ({pct}% point rate) — the worst in the league.",
             "warning", team=r.abbreviation)

    # 9. OT record leader — threshold (≥3 OT games)
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(CASE WHEN (g.is_overtime OR g.is_shootout)
                         AND ((g.home_team_id=t.id AND g.home_score > g.away_score)
                              OR (g.away_team_id=t.id AND g.away_score > g.home_score))
                        THEN 1 ELSE 0 END) as ot_wins,
               SUM(CASE WHEN g.is_overtime OR g.is_shootout THEN 1 ELSE 0 END) as ot_gp
        FROM pwhl_teams t
        JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
        WHERE g.status='final' AND g.season=:s
        GROUP BY t.id, t.name, t.abbreviation
        HAVING SUM(CASE WHEN g.is_overtime OR g.is_shootout THEN 1 ELSE 0 END) >= 3
        ORDER BY ot_wins DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"ot_{r.abbreviation}", "Clutch Play",
             f"{r.name} thrive when games go to overtime",
             f"{r.name} have won {r.ot_wins} of their {r.ot_gp} overtime or shootout games this season — the best clutch record in the PWHL.",
             "positive", team=r.abbreviation)

    # 10. Faceoff dominance (team aggregate) — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(ps.faceoffs_won) as fo_won,
               SUM(ps.faceoffs_total) as fo_total
        FROM pwhl_teams t
        JOIN players p ON p.pwhl_team_id=t.id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND ps.faceoffs_total > 0
        GROUP BY t.id, t.name, t.abbreviation
        HAVING SUM(ps.faceoffs_total) >= 100
        ORDER BY (SUM(ps.faceoffs_won)::float / SUM(ps.faceoffs_total)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        pct = round(r.fo_won / r.fo_total * 100, 1)
        _add(trends, f"fo_{r.abbreviation}", "Special Teams",
             f"{r.name} are dominating the faceoff circle",
             f"{r.name} are winning {pct}% of faceoffs this season ({r.fo_won}/{r.fo_total}) — the best in the PWHL.",
             "positive", team=r.abbreviation)

    # ── PLAYER TRENDS (season totals) ─────────────────────────────────────────

    # 11. Points per game leader — always fires (min 10 GP)
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.points, ps.games_played,
               ROUND((ps.points::float / ps.games_played)::numeric, 2) as ppg
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.games_played >= 10
        ORDER BY (ps.points::float / ps.games_played) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"ppg_{r.name.replace(' ','_')}", "Hot Players",
             f"{r.name} leads the PWHL in points per game",
             f"{r.name} ({r.abbreviation}) is producing at a {r.ppg} points-per-game clip this season ({r.points} pts in {r.games_played} GP) — the best rate in the league.",
             "positive", player=r.name, team=r.abbreviation)

    # 12. Best shooting % — always fires (min 20 shots)
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.goals, ps.shots,
               ROUND((ps.goals::float / ps.shots * 100)::numeric, 1) as sh_pct
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.shots >= 20 AND ps.goals > 0
        ORDER BY (ps.goals::float / ps.shots) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"shpct_{r.name.replace(' ','_')}", "Shooting",
             f"{r.name} has the deadliest shot in the PWHL",
             f"{r.name} ({r.abbreviation}) is converting {r.sh_pct}% of shots into goals this season ({r.goals} goals on {r.shots} shots) — the highest shooting percentage in the league.",
             "positive", player=r.name, team=r.abbreviation)

    # 13. Most pass-first player (highest assist:goal ratio, min 5G) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.goals, ps.assists, ps.points
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.goals >= 5 AND ps.assists > ps.goals
        ORDER BY (ps.assists::float / ps.goals) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        ratio = round(r.assists / r.goals, 1)
        _add(trends, f"passer_{r.name.replace(' ','_')}", "Playmaking",
             f"{r.name} is the PWHL's premier playmaker",
             f"{r.name} ({r.abbreviation}) has {r.assists} assists to just {r.goals} goals this season — a {ratio}:1 assist-to-goal ratio that leads all qualified forwards.",
             "positive", player=r.name, team=r.abbreviation)

    # 14. Best faceoff specialist (individual, min 50 attempts) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.faceoffs_won, ps.faceoffs_total,
               ROUND((ps.faceoffs_won::float / ps.faceoffs_total * 100)::numeric, 1) as fo_pct
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND ps.faceoffs_total >= 50
        ORDER BY (ps.faceoffs_won::float / ps.faceoffs_total) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"fo_player_{r.name.replace(' ','_')}", "Special Teams",
             f"{r.name} is the PWHL's best faceoff specialist",
             f"{r.name} ({r.abbreviation}) is winning {r.fo_pct}% of faceoffs this season ({r.faceoffs_won}/{r.faceoffs_total}) — the highest individual faceoff rate in the league.",
             "positive", player=r.name, team=r.abbreviation)

    # 15. Defensive specialist (blocks leader) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.blocks, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.blocks IS NOT NULL AND ps.blocks > 0
        ORDER BY ps.blocks DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        bpg = round(r.blocks / r.games_played, 1)
        _add(trends, f"blocks_{r.name.replace(' ','_')}", "Defense",
             f"{r.name} is throwing her body in front of everything",
             f"{r.name} ({r.abbreviation}) leads the PWHL with {r.blocks} blocked shots this season ({bpg}/game) — the league's premier shot-blocker.",
             "info", player=r.name, team=r.abbreviation)

    # 16. Workhorse goalie (most saves faced / most starts) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.saves, ps.shots_against, ps.games_played, ps.wins
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position='G' AND ps.games_played >= 5
        ORDER BY ps.saves DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        spg = round(r.shots_against / r.games_played, 1) if r.games_played else 0
        _add(trends, f"workhorse_{r.name.replace(' ','_')}", "Goaltending",
             f"{r.name} is carrying the heaviest workload of any PWHL goalie",
             f"{r.name} ({r.abbreviation}) has faced {r.shots_against} shots this season ({spg}/game) — more than any other goalie — and made {r.saves} saves.",
             "info", player=r.name, team=r.abbreviation)

    # 17. Best GAA goalie (min 5 GP) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.goals_against_average, ps.games_played, ps.wins, ps.shutouts
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position='G' AND ps.games_played >= 5
          AND ps.goals_against_average IS NOT NULL AND ps.goals_against_average > 0
        ORDER BY ps.goals_against_average ASC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"gaa_{r.name.replace(' ','_')}", "Goaltending",
             f"{r.name} has the PWHL's best goals-against average",
             f"{r.name} ({r.abbreviation}) leads the PWHL with a {r.goals_against_average:.2f} GAA this season ({r.wins} wins, {r.shutouts} shutouts in {r.games_played} starts).",
             "positive", player=r.name, team=r.abbreviation)

    # 18. Fantasy points leader — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.fantasy_points, ps.games_played, p.position
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND ps.fantasy_points IS NOT NULL AND ps.games_played >= 10
        ORDER BY ps.fantasy_points DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        fpg = round(r.fantasy_points / r.games_played, 1)
        _add(trends, f"fp_{r.name.replace(' ','_')}", "Fantasy",
             f"{r.name} is the PWHL's top fantasy asset",
             f"{r.name} ({r.abbreviation}) leads all PWHL players in fantasy points this season with {r.fantasy_points:.0f} total ({fpg}/game).",
             "positive", player=r.name, team=r.abbreviation)

    # 19. Most penalty minutes (team discipline issue) — always fires
    rows = _q(db, """
        SELECT t.name, t.abbreviation,
               SUM(ps.penalty_minutes) as pim,
               COUNT(DISTINCT p.id) as skaters
        FROM pwhl_teams t
        JOIN players p ON p.pwhl_team_id=t.id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true AND p.position != 'G'
        GROUP BY t.id, t.name, t.abbreviation
        ORDER BY SUM(ps.penalty_minutes) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"pim_{r.abbreviation}", "Discipline",
             f"{r.name} are the PWHL's most penalized team",
             f"{r.name} have racked up {r.pim} penalty minutes this season — more than any other team in the league.",
             "warning", team=r.abbreviation)

    # 20. Goal scoring leaders (top scorer, season total) — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.goals, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G'
        ORDER BY ps.goals DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"goals_{r.name.replace(' ','_')}", "Scoring",
             f"{r.name} leads the PWHL in goals",
             f"{r.name} ({r.abbreviation}) has {r.goals} goals this season in {r.games_played} games — the most of any player in the league.",
             "positive", player=r.name, team=r.abbreviation)

    # 21. Assist leader — always fires
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.assists, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G'
        ORDER BY ps.assists DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"assists_{r.name.replace(' ','_')}", "Playmaking",
             f"{r.name} leads the PWHL in assists",
             f"{r.name} ({r.abbreviation}) has dished out {r.assists} assists this season in {r.games_played} games — no one sets up teammates better.",
             "positive", player=r.name, team=r.abbreviation)

    # 22. Shots on goal leader — always fires (min 10 GP)
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.shots, ps.goals, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.games_played >= 10
          AND ps.shots IS NOT NULL
        ORDER BY ps.shots DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        spg = round(r.shots / r.games_played, 1)
        _add(trends, f"shots_{r.name.replace(' ','_')}", "Shooting",
             f"{r.name} generates more shots than anyone in the PWHL",
             f"{r.name} ({r.abbreviation}) leads the league with {r.shots} shots this season ({spg}/game), converting {r.goals} into goals.",
             "info", player=r.name, team=r.abbreviation)

    # 23. Best +/- player — always fires (min 10 GP)
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.plus_minus, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.games_played >= 10
          AND ps.plus_minus IS NOT NULL
        ORDER BY ps.plus_minus DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        sign = "+" if r.plus_minus >= 0 else ""
        _add(trends, f"pm_{r.name.replace(' ','_')}", "Two-Way Play",
             f"{r.name} dominates the two-way game",
             f"{r.name} ({r.abbreviation}) leads the PWHL with a {sign}{r.plus_minus} plus/minus rating this season in {r.games_played} games.",
             "positive", player=r.name, team=r.abbreviation)

    # 24. Hit leader — always fires (if data exists)
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.hits, ps.games_played
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.hits IS NOT NULL AND ps.hits > 0
        ORDER BY ps.hits DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        hpg = round(r.hits / r.games_played, 1)
        _add(trends, f"hits_{r.name.replace(' ','_')}", "Physical Play",
             f"{r.name} is the most physical player in the PWHL",
             f"{r.name} ({r.abbreviation}) leads the league with {r.hits} hits this season ({hpg}/game) — opponents feel her presence every shift.",
             "info", player=r.name, team=r.abbreviation)

    # ── ROLLING PLAYER TRENDS (per-game rows, last 5 / 10 games) ─────────────
    # These queries return nothing until run_pergame_scrape has been run.
    # Guard pattern: for r in rows / if row: same as threshold trends below.

    # R1. Hottest skater — most points in last 5 games (min 5 GP)
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   COALESCE(ps.goals, 0) + COALESCE(ps.assists, 0) AS pts,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.pts) AS pts, COUNT(*) AS gp
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 5 AND p.position != 'G'
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 5
        ORDER BY SUM(r.pts) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"rolling_pts5_{r.name.replace(' ','_')}", "Hot Players",
             f"{r.name} is the PWHL's hottest skater right now",
             f"{r.name} ({r.abbreviation}) has racked up {r.pts} points over her last {r.gp} games — nobody is hotter right now.",
             "positive", player=r.name, team=r.abbreviation)

    # R2. Last-10 points leader (min 8 GP)
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   COALESCE(ps.goals, 0) + COALESCE(ps.assists, 0) AS pts,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.pts) AS pts, COUNT(*) AS gp
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 10 AND p.position != 'G'
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY SUM(r.pts) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"rolling_pts10_{r.name.replace(' ','_')}", "Hot Players",
             f"{r.name} is on fire over the last 10 games",
             f"{r.name} ({r.abbreviation}) has posted {r.pts} points in her last {r.gp} games — the best stretch performance in the PWHL.",
             "positive", player=r.name, team=r.abbreviation)

    # R3. Goals leader last 5 games (min 5 GP, min 2 goals)
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   COALESCE(ps.goals, 0) AS goals,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.goals) AS goals, COUNT(*) AS gp
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 5 AND p.position != 'G'
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 5 AND SUM(r.goals) >= 2
        ORDER BY SUM(r.goals) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"rolling_goals5_{r.name.replace(' ','_')}", "Hot Players",
             f"{r.name} has been impossible to stop lately",
             f"{r.name} ({r.abbreviation}) has scored {r.goals} goals in her last {r.gp} games — she is impossible to stop right now.",
             "positive", player=r.name, team=r.abbreviation)

    # R4. Best shooting % last 10 games (min 8 GP, min 5 shots)
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   COALESCE(ps.goals, 0) AS goals,
                   COALESCE(ps.shots, 0) AS shots,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.goals) AS goals, SUM(r.shots) AS shots, COUNT(*) AS gp,
               ROUND((SUM(r.goals)::float / NULLIF(SUM(r.shots), 0) * 100)::numeric, 1) AS sh_pct
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 10 AND p.position != 'G'
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 8 AND SUM(r.shots) >= 5
        ORDER BY (SUM(r.goals)::float / NULLIF(SUM(r.shots), 0)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        if r.sh_pct is not None:
            _add(trends, f"rolling_shpct10_{r.name.replace(' ','_')}", "Shooting",
                 f"{r.name}'s shot has been a weapon over the last 10 games",
                 f"{r.name} ({r.abbreviation}) is converting {r.sh_pct}% of shots over her last {r.gp} games ({r.goals} goals on {r.shots} shots) — the hottest shooting percentage in the PWHL.",
                 "positive", player=r.name, team=r.abbreviation)

    # R5. Best SV% last 5 starts (min 4 GP, goalie only, min 0.920)
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   COALESCE(ps.saves, 0) AS saves,
                   COALESCE(ps.shots_against, 0) AS shots_against,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.saves) AS saves, SUM(r.shots_against) AS shots_against, COUNT(*) AS gp,
               ROUND((SUM(r.saves)::float / NULLIF(SUM(r.shots_against), 0))::numeric, 3) AS sv_pct
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 5 AND p.position = 'G'
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 4
          AND SUM(r.shots_against) > 0
          AND (SUM(r.saves)::float / NULLIF(SUM(r.shots_against), 0)) >= 0.920
        ORDER BY (SUM(r.saves)::float / NULLIF(SUM(r.shots_against), 0)) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        if r.sv_pct is not None:
            sv_display = f".{int(round(float(r.sv_pct), 3) * 1000):03d}"
            _add(trends, f"rolling_svpct5_{r.name.replace(' ','_')}", "Goaltending",
                 f"{r.name} has been a brick wall this week",
                 f"{r.name} ({r.abbreviation}) has a {sv_display} SV% over her last {r.gp} starts ({r.saves} saves on {r.shots_against} shots) — the hottest goalie in the PWHL.",
                 "positive", player=r.name, team=r.abbreviation)

    # R6. Best fantasy pickup — most fantasy_points last 10 games (min 8 GP)
    # Note: per-game fantasy_points are NULL until explicitly populated; this
    # trend silently produces nothing until that data exists.
    rows = _q(db, """
        WITH ranked AS (
            SELECT ps.player_id,
                   ps.fantasy_points AS fp,
                   ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY g.game_date DESC) AS rn
            FROM player_stats ps
            JOIN games g ON g.id = ps.game_id
            WHERE ps.is_season_total = false AND ps.season = :s
              AND ps.fantasy_points IS NOT NULL
        )
        SELECT p.first_name||' '||p.last_name AS name, t.abbreviation,
               SUM(r.fp) AS fp, COUNT(*) AS gp
        FROM ranked r
        JOIN players p ON p.id = r.player_id
        JOIN pwhl_teams t ON t.id = p.pwhl_team_id
        WHERE r.rn <= 10
        GROUP BY p.id, p.first_name, p.last_name, t.abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY SUM(r.fp) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        fpg = round(r.fp / r.gp, 1) if r.gp else 0
        _add(trends, f"rolling_fp10_{r.name.replace(' ','_')}", "Fantasy",
             f"{r.name} is the best fantasy pickup right now",
             f"{r.name} ({r.abbreviation}) has accumulated {r.fp:.0f} fantasy points over her last {r.gp} games ({fpg}/game) — the best recent fantasy producer in the PWHL.",
             "positive", player=r.name, team=r.abbreviation)

    # ── ROLLING TEAM TRENDS (last 10 / 25 games from games table) ────────────

    # T1. Best point % last 10 games
    rows = _q(db, """
        WITH last10 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                        THEN 2
                        WHEN g.is_overtime OR g.is_shootout THEN 1
                        ELSE 0 END AS pts
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) AS rn
            FROM last10
        )
        SELECT id, name, abbreviation,
               SUM(pts) AS earned, COUNT(*)*2 AS possible, COUNT(*) AS gp
        FROM ranked WHERE rn <= 10
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY (SUM(pts)::float / (COUNT(*)*2)) DESC
        LIMIT 1
    """)
    for r in rows:
        pct = round(r.earned / r.possible * 100)
        _add(trends, f"form10_{r.abbreviation}", "Recent Form",
             f"{r.name} have been dominant over the last 10 games",
             f"{r.name} have earned {r.earned} of a possible {r.possible} points in their last {r.gp} games ({pct}% point rate) — the best 10-game stretch in the PWHL.",
             "positive", team=r.abbreviation)

    # T2. Best point % last 25 games
    rows = _q(db, """
        WITH last25 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                        THEN 2
                        WHEN g.is_overtime OR g.is_shootout THEN 1
                        ELSE 0 END AS pts
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) AS rn
            FROM last25
        )
        SELECT id, name, abbreviation,
               SUM(pts) AS earned, COUNT(*)*2 AS possible, COUNT(*) AS gp
        FROM ranked WHERE rn <= 25
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 20
        ORDER BY (SUM(pts)::float / (COUNT(*)*2)) DESC
        LIMIT 1
    """)
    for r in rows:
        pct = round(r.earned / r.possible * 100)
        _add(trends, f"form25_{r.abbreviation}", "Recent Form",
             f"{r.name} have been the most consistent team over the last 25 games",
             f"{r.name} have earned {r.earned} of a possible {r.possible} points in their last {r.gp} games ({pct}% point rate) — the best extended run in the PWHL.",
             "positive", team=r.abbreviation)

    # T3. Worst point % last 10 games
    rows = _q(db, """
        WITH last10 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                             OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                        THEN 2
                        WHEN g.is_overtime OR g.is_shootout THEN 1
                        ELSE 0 END AS pts
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) AS rn
            FROM last10
        )
        SELECT id, name, abbreviation,
               SUM(pts) AS earned, COUNT(*)*2 AS possible, COUNT(*) AS gp
        FROM ranked WHERE rn <= 10
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY (SUM(pts)::float / (COUNT(*)*2)) ASC
        LIMIT 1
    """)
    for r in rows:
        pct = round(r.earned / r.possible * 100)
        _add(trends, f"cold10_{r.abbreviation}", "Recent Form",
             f"{r.name} are struggling badly over the last 10 games",
             f"{r.name} have managed just {r.earned} of a possible {r.possible} points in their last {r.gp} games ({pct}% point rate) — the worst 10-game stretch in the league.",
             "warning", team=r.abbreviation)

    # T4. Most goals scored last 10 games
    rows = _q(db, """
        WITH last10 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN g.home_team_id=t.id THEN g.home_score ELSE g.away_score END AS gf
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) AS rn
            FROM last10
        )
        SELECT id, name, abbreviation,
               SUM(gf) AS goals, COUNT(*) AS gp
        FROM ranked WHERE rn <= 10
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY SUM(gf) DESC
        LIMIT 1
    """)
    for r in rows:
        gpg = round(r.goals / r.gp, 1)
        _add(trends, f"goals10_{r.abbreviation}", "Team Dominance",
             f"{r.name} have the most explosive offense over the last 10 games",
             f"{r.name} have scored {r.goals} goals in their last {r.gp} games ({gpg}/game) — the most prolific offense in the PWHL over this stretch.",
             "positive", team=r.abbreviation)

    # T5. Fewest goals allowed last 10 games
    rows = _q(db, """
        WITH last10 AS (
            SELECT t.id, t.name, t.abbreviation,
                   g.game_date,
                   CASE WHEN g.home_team_id=t.id THEN g.away_score ELSE g.home_score END AS ga
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final'
        ),
        ranked AS (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY game_date DESC) AS rn
            FROM last10
        )
        SELECT id, name, abbreviation,
               SUM(ga) AS goals_against, COUNT(*) AS gp
        FROM ranked WHERE rn <= 10
        GROUP BY id, name, abbreviation
        HAVING COUNT(*) >= 8
        ORDER BY SUM(ga) ASC
        LIMIT 1
    """)
    for r in rows:
        gapg = round(r.goals_against / r.gp, 2)
        _add(trends, f"def10_{r.abbreviation}", "Team Defense",
             f"{r.name} have the best defense over the last 10 games",
             f"{r.name} have allowed just {r.goals_against} goals in their last {r.gp} games ({gapg}/game) — the tightest defensive stretch in the PWHL.",
             "positive", team=r.abbreviation)

    # ── INTERESTING STORIES (anomaly detection) ───────────────────────────────

    # 25. Lone Wolf — top scorer on the team with worst record
    row = _q1(db, """
        WITH team_records AS (
            SELECT t.id, t.name, t.abbreviation,
                   SUM(CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                                 OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                            THEN 1 ELSE 0 END)::float / COUNT(*) as win_pct
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final' AND g.season=:s
            GROUP BY t.id, t.name, t.abbreviation
        ),
        worst_team AS (
            SELECT id, name, abbreviation FROM team_records ORDER BY win_pct ASC LIMIT 1
        )
        SELECT p.first_name||' '||p.last_name as pname, wt.name as tname, wt.abbreviation,
               ps.points, ps.goals, ps.assists, ps.games_played
        FROM worst_team wt
        JOIN players p ON p.pwhl_team_id=wt.id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true AND p.position != 'G'
          AND ps.games_played >= 10
        ORDER BY ps.points DESC
        LIMIT 1
    """, {"s": season})
    if row and row.points >= 8:
        _add(trends, f"lonewolf_{row.abbreviation}",
             "Interesting Stories",
             f"{row.pname} is shining alone on a struggling {row.tname}",
             f"{row.pname} leads {row.tname} with {row.points} points ({row.goals}G {row.assists}A) in {row.games_played} games — a standout performer on the league's most challenged team.",
             "info", player=row.pname, team=row.abbreviation)

    # 26. Record pace — player on pace for 30+ points if season were 26 games
    rows = _q(db, """
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.points, ps.goals, ps.games_played,
               ROUND((ps.points::float / ps.games_played * 26)::numeric, 0) as pace_26
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position != 'G' AND ps.games_played BETWEEN 8 AND 20
        ORDER BY (ps.points::float / ps.games_played) DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        if r.pace_26 >= 28:
            _add(trends, f"pace_{r.name.replace(' ','_')}",
                 "Interesting Stories",
                 f"{r.name} is on a record-setting scoring pace",
                 f"At {r.points} points in {r.games_played} games, {r.name} ({r.abbreviation}) is on pace for {int(r.pace_26)} points over a full 26-game season — a historic rate for the PWHL.",
                 "positive", player=r.name, team=r.abbreviation)

    # 27. Double threat — player top 3 in both goals AND assists
    rows = _q(db, """
        WITH goal_rank AS (
            SELECT player_id, goals,
                   RANK() OVER (ORDER BY goals DESC) as g_rank
            FROM player_stats WHERE season=:s AND is_season_total=true
        ),
        assist_rank AS (
            SELECT player_id, assists,
                   RANK() OVER (ORDER BY assists DESC) as a_rank
            FROM player_stats WHERE season=:s AND is_season_total=true
        )
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               gr.goals, ar.assists, gr.g_rank, ar.a_rank
        FROM goal_rank gr
        JOIN assist_rank ar ON ar.player_id=gr.player_id
        JOIN players p ON p.id=gr.player_id
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        WHERE gr.g_rank <= 5 AND ar.a_rank <= 5 AND p.position != 'G'
        ORDER BY (gr.g_rank + ar.a_rank) ASC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"doublethreat_{r.name.replace(' ','_')}",
             "Interesting Stories",
             f"{r.name} is terrorizing defenses as both a scorer and a playmaker",
             f"{r.name} ({r.abbreviation}) ranks top 5 in the PWHL in both goals ({r.goals}, #{r.g_rank}) and assists ({r.assists}, #{r.a_rank}) — a complete offensive threat that defenses can't solve.",
             "positive", player=r.name, team=r.abbreviation)

    # 28. Elite goalie on bad team (high SV% + high shots against)
    rows = _q(db, """
        WITH team_records AS (
            SELECT t.id,
                   SUM(CASE WHEN (g.home_team_id=t.id AND g.home_score > g.away_score)
                                 OR (g.away_team_id=t.id AND g.away_score > g.home_score)
                            THEN 1 ELSE 0 END)::float / COUNT(*) as win_pct
            FROM pwhl_teams t
            JOIN games g ON (g.home_team_id=t.id OR g.away_team_id=t.id)
            WHERE g.status='final' AND g.season=:s
            GROUP BY t.id
        )
        SELECT p.first_name||' '||p.last_name as name, t.name as tname, t.abbreviation,
               ps.save_percentage, ps.shots_against, ps.games_played, ps.wins,
               ROUND(tr.win_pct * 100)::int as team_win_pct
        FROM players p
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        JOIN player_stats ps ON ps.player_id=p.id
        JOIN team_records tr ON tr.id=t.id
        WHERE ps.season=:s AND ps.is_season_total=true
          AND p.position='G' AND ps.games_played >= 5
          AND ps.save_percentage >= 0.920 AND tr.win_pct <= 0.45
        ORDER BY ps.save_percentage DESC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        _add(trends, f"robbinggoalie_{r.name.replace(' ','_')}",
             "Interesting Stories",
             f"{r.name} is stealing points for a team that needs every save",
             f"{r.name} is posting a .{int(r.save_percentage*1000):03d} SV% for {r.tname} — an elite performance propping up a team winning just {r.team_win_pct}% of their games.",
             "info", player=r.name, team=r.abbreviation)

    # 29. Cleanest superstar — high points with lowest PIM among top-10 scorers
    rows = _q(db, """
        WITH top_scorers AS (
            SELECT player_id FROM player_stats
            WHERE season=:s AND is_season_total=true
            ORDER BY points DESC LIMIT 10
        )
        SELECT p.first_name||' '||p.last_name as name, t.abbreviation,
               ps.points, ps.penalty_minutes, ps.games_played
        FROM top_scorers ts
        JOIN player_stats ps ON ps.player_id=ts.player_id
        JOIN players p ON p.id=ts.player_id
        JOIN pwhl_teams t ON t.id=p.pwhl_team_id
        WHERE ps.season=:s AND ps.is_season_total=true AND p.position != 'G'
        ORDER BY ps.penalty_minutes ASC
        LIMIT 1
    """, {"s": season})
    for r in rows:
        if r.penalty_minutes <= 4:
            _add(trends, f"clean_{r.name.replace(' ','_')}",
                 "Interesting Stories",
                 f"{r.name} dominates the scoresheet without taking a single cheap penalty",
                 f"{r.name} ({r.abbreviation}) is among the PWHL's top scorers with {r.points} points — and has taken just {r.penalty_minutes} penalty minutes all season. Elite production, zero baggage.",
                 "positive", player=r.name, team=r.abbreviation)

    # Dedupe and shuffle for variety (sort by category then randomize within)
    seen = set()
    unique = []
    for t in trends:
        if t["id"] not in seen:
            seen.add(t["id"])
            unique.append(t)

    # Sort: warnings first (most newsworthy), then positives, then info
    order = {"warning": 0, "positive": 1, "info": 2}
    unique.sort(key=lambda x: order.get(x.get("severity", "info"), 2))

    return {"trends": unique[:20], "season": season, "last_n": last_n}
