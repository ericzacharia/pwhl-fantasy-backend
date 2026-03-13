"""
PWHL Data Scraper
Fetches player stats, rosters, and game data from public PWHL sources.
"""
import asyncio
import logging
from datetime import datetime, date
from typing import Optional
import aiohttp

logger = logging.getLogger(__name__)

# PWHL HockeyTech API
STATS_API_BASE = "https://lscluster.hockeytech.com/feed/index.php"
CLIENT_CODE = "pwhl"
APP_KEY = "446521baf8c38984"
LEAGUE_ID = "1"
# HockeyTech season IDs (modulekit feed): 1=2024 (inaugural), 5=2024-2025, 8=2025-2026
SEASON_ID = "8"                 # current 2025-2026 season
PREV_SEASON_ID = "5"            # previous 2024-2025 season
PREV_SEASON_LABEL = "2024-2025"
INAUGURAL_SEASON_ID = "1"       # inaugural 2024 season (Jan-May 2024)
INAUGURAL_SEASON_LABEL = "2024"

# Static color data keyed by team code from API
TEAM_COLORS = {
    "BOS": {"primary_color": "#041E42", "secondary_color": "#B9975B"},
    "MIN": {"primary_color": "#154734", "secondary_color": "#CFC493"},
    "MTL": {"primary_color": "#AF1E2D", "secondary_color": "#003DA5"},
    "NY":  {"primary_color": "#BE2BBB", "secondary_color": "#FFFFFF"},
    "OTT": {"primary_color": "#DA1A32", "secondary_color": "#000000"},
    "TOR": {"primary_color": "#00205B", "secondary_color": "#FFFFFF"},
    "SEA": {"primary_color": "#001D3E", "secondary_color": "#99D9D9"},
    "VAN": {"primary_color": "#00843D", "secondary_color": "#FFFFFF"},
}

# Maps API team code -> DB abbreviation
TEAM_CODE_MAP = {
    "BOS": "BOS", "MIN": "MIN", "MTL": "MTL",
    "NY": "NYR", "NYR": "NYR",  # NY Sirens - DB uses "NYR"
    "OTT": "OTT", "TOR": "TOR",
    "SEA": "SEA", "VAN": "VAN",
}


async def fetch_json(session: aiohttp.ClientSession, url: str, params: dict = None) -> Optional[dict]:
    try:
        async with session.get(url, params=params, timeout=aiohttp.ClientTimeout(total=60)) as resp:
            if resp.status == 200:
                return await resp.json(content_type=None)
    except Exception as e:
        logger.error(f"Error fetching {url}: {e}")
    return None


def _base_params() -> dict:
    return {
        "feed": "modulekit",
        "client_code": CLIENT_CODE,
        "lang": "en",
        "key": APP_KEY,
        "league_id": LEAGUE_ID,
    }


async def get_teams_from_api(session: aiohttp.ClientSession) -> list[dict]:
    """Fetch teams from HockeyTech API."""
    params = {**_base_params(), "view": "teamsbyseason", "season_id": SEASON_ID}
    data = await fetch_json(session, STATS_API_BASE, params)
    if data:
        return data.get("SiteKit", {}).get("Teamsbyseason", [])
    return []


async def get_player_stats_from_api(session: aiohttp.ClientSession, season_id: str = SEASON_ID) -> list[dict]:
    """Fetch skater stats from HockeyTech API."""
    params = {
        **_base_params(),
        "view": "statviewtype",
        "type": "topscorers",
        "season_id": season_id,
        "limit": "250",
        "sort": "points",
        "division_id": "-1",
        "qualified": "all",
    }
    data = await fetch_json(session, STATS_API_BASE, params)
    if data:
        return data.get("SiteKit", {}).get("Statviewtype", [])
    return []


async def get_goalie_stats_from_api(session: aiohttp.ClientSession, season_id: str = SEASON_ID) -> list[dict]:
    """Fetch goalie stats from HockeyTech API."""
    params = {
        **_base_params(),
        "view": "statviewtype",
        "type": "goalies",
        "season_id": season_id,
        "limit": "50",
        "sort": "svpct",
        "division_id": "-1",
        "qualified": "all",
    }
    data = await fetch_json(session, STATS_API_BASE, params)
    if data:
        return data.get("SiteKit", {}).get("Statviewtype", [])
    return []


async def get_scorebar_from_api(session: aiohttp.ClientSession) -> list[dict]:
    """Fetch all season games via scorebar (schedule view returns 0 games)."""
    params = {
        **_base_params(),
        "view": "scorebar",
        "numberofdaysahead": "365",
        "numberofdaysback": "365",
    }
    data = await fetch_json(session, STATS_API_BASE, params)
    if data:
        return data.get("SiteKit", {}).get("Scorebar", [])
    return []


def _int(val, default=0) -> int:
    try:
        return int(val or default)
    except (ValueError, TypeError):
        return default


def _float(val, default=0.0) -> float:
    try:
        return float(val or default)
    except (ValueError, TypeError):
        return default


def parse_player_from_stats(raw: dict) -> dict:
    """Parse a player dict from stats API response."""
    pos = raw.get("position", "F")
    if pos not in ("F", "C", "LW", "RW", "D", "G"):
        pos = "F"

    return {
        "pwhl_player_id": str(raw.get("player_id", "")),
        "first_name": raw.get("first_name", ""),
        "last_name": raw.get("last_name", ""),
        "position": pos,
        "jersey_number": _int(raw.get("jersey_number", 0)),
        "team_abbreviation": raw.get("team_code", ""),
        "nationality": raw.get("birthcntry", ""),
        "headshot_url": raw.get("photo") or raw.get("player_image", ""),
        "shoots": raw.get("shoots") or raw.get("catches", ""),
    }


def parse_skater_stats(raw: dict) -> dict:
    return {
        "games_played": _int(raw.get("games_played")),
        "goals": _int(raw.get("goals")),
        "assists": _int(raw.get("assists")),
        "points": _int(raw.get("points")),
        "plus_minus": _int(raw.get("plus_minus")),
        "penalty_minutes": _int(raw.get("penalty_minutes")),
        "shots": _int(raw.get("shots")),
        "hits": _int(raw.get("hits")),
        "blocks": _int(raw.get("shots_blocked_by_player")),
        "faceoffs_won": _int(raw.get("faceoff_wins")),
        "faceoffs_total": _int(raw.get("faceoff_attempts")),
    }


def parse_goalie_stats(raw: dict) -> dict:
    return {
        "games_played": _int(raw.get("games_played")),
        "wins": _int(raw.get("wins")),
        "losses": _int(raw.get("losses")),
        "overtime_losses": _int(raw.get("ot_losses")),
        "saves": _int(raw.get("saves")),
        "shots_against": _int(raw.get("shots")),
        "goals_against": _int(raw.get("goals_against")),
        "shutouts": _int(raw.get("shutouts")),
        "save_percentage": _float(raw.get("save_percentage")),
        "goals_against_average": _float(raw.get("goals_against_average")),
    }


def parse_game_status(g: dict) -> str:
    status_str = g.get("GameStatusString", "").lower()
    if "final" in status_str:
        return "final"
    if "progress" in status_str or "live" in status_str or "intermission" in status_str:
        return "live"
    return "scheduled"


GAME_SUMMARY_BASE = "https://lscluster.hockeytech.com/feed/index.php"


async def get_game_summary(session: aiohttp.ClientSession, pwhl_game_id: str) -> Optional[dict]:
    """Fetch full game summary (with per-player box score) via statviewfeed."""
    params = {
        "feed": "statviewfeed",
        "view": "gameSummary",
        "game_id": pwhl_game_id,
        "key": APP_KEY,
        "client_code": CLIENT_CODE,
        "lang": "en",
    }
    try:
        async with session.get(GAME_SUMMARY_BASE, params=params,
                               timeout=aiohttp.ClientTimeout(total=60)) as resp:
            if resp.status != 200:
                return None
            text = (await resp.text()).strip()
            # Response is JSONP-wrapped: (...) — strip parens
            if text.startswith("(") and text.endswith(")"):
                text = text[1:-1]
            import json
            return json.loads(text)
    except Exception as e:
        logger.error(f"get_game_summary({pwhl_game_id}): {e}")
        return None


def parse_skater_game_stats(stats: dict) -> dict:
    """Parse skater stats dict from gameSummary response (camelCase keys)."""
    return {
        "goals": _int(stats.get("goals")),
        "assists": _int(stats.get("assists")),
        "points": _int(stats.get("points")),
        "plus_minus": _int(stats.get("plusMinus")),
        "penalty_minutes": _int(stats.get("penaltyMinutes")),
        "shots": _int(stats.get("shots")),
        "hits": _int(stats.get("hits")),
        "blocks": _int(stats.get("blockedShots")),
        "faceoffs_won": _int(stats.get("faceoffWins")),
        "faceoffs_total": _int(stats.get("faceoffAttempts")),
        "games_played": 1,
    }


def parse_goalie_game_stats(stats: dict, is_ot: bool = False, is_so: bool = False) -> dict:
    """Parse goalie stats dict from gameSummary response (camelCase keys)."""
    shots = _int(stats.get("shotsAgainst"))
    saves = _int(stats.get("saves"))
    ga = _int(stats.get("goalsAgainst"))
    sv_pct = saves / shots if shots > 0 else 0.0
    # Shutout: goalie played and allowed 0 goals (simplified — box score doesn't give W/L directly)
    shutout = 1 if saves > 0 and ga == 0 else 0
    return {
        "shots_against": shots,
        "saves": saves,
        "goals_against": ga,
        "shutouts": shutout,
        "save_percentage": round(sv_pct, 4),
        "games_played": 1,
    }


async def run_pergame_scrape(db) -> dict:
    """
    Scrape per-game player stats for all final games this season.
    Uses statviewfeed/gameSummary (one call per game, returns all players).
    Skips games already fully scraped. Idempotent.
    """
    from app.models.player import Player, PlayerStats
    from app.models.game import Game

    results = {"games_processed": 0, "rows_inserted": 0, "errors": []}

    # Build player lookup: pwhl_player_id (str) -> Player
    players_by_api_id: dict[str, Player] = {
        str(p.pwhl_player_id): p
        for p in db.query(Player).filter(Player.pwhl_player_id.isnot(None)).all()
    }

    # Only scrape final games for this season
    games = (
        db.query(Game)
        .filter(Game.status == "final", Game.season == "2025-2026")
        .order_by(Game.game_date.asc())
        .all()
    )
    logger.info(f"Per-game scrape: {len(games)} final games to process")

    async with aiohttp.ClientSession() as session:
        batch_size = 5  # 5 concurrent game fetches
        for batch_start in range(0, len(games), batch_size):
            batch = games[batch_start:batch_start + batch_size]
            summaries = await asyncio.gather(
                *[get_game_summary(session, g.pwhl_game_id) for g in batch]
            )

            for game, summary in zip(batch, summaries):
                if not summary:
                    results["errors"].append(f"No summary for game {game.pwhl_game_id}")
                    continue

                try:
                    is_ot = bool(game.is_overtime)
                    is_so = bool(game.is_shootout)

                    for side in ("homeTeam", "visitingTeam"):
                        team_data = summary.get(side, {})

                        for skater in team_data.get("skaters", []):
                            info = skater.get("info", {})
                            api_pid = str(info.get("id", ""))
                            player = players_by_api_id.get(api_pid)
                            if not player:
                                continue

                            existing = db.query(PlayerStats).filter_by(
                                player_id=player.id, game_id=game.id, is_season_total=False
                            ).first()
                            if existing:
                                continue

                            stat_data = parse_skater_game_stats(skater.get("stats", {}))
                            db.add(PlayerStats(
                                player_id=player.id,
                                season="2025-2026",
                                game_id=game.id,
                                is_season_total=False,
                                fantasy_points=None,
                                **stat_data,
                            ))
                            results["rows_inserted"] += 1

                        for goalie in team_data.get("goalies", []):
                            info = goalie.get("info", {})
                            api_pid = str(info.get("id", ""))
                            player = players_by_api_id.get(api_pid)
                            if not player:
                                continue

                            existing = db.query(PlayerStats).filter_by(
                                player_id=player.id, game_id=game.id, is_season_total=False
                            ).first()
                            if existing:
                                continue

                            stat_data = parse_goalie_game_stats(
                                goalie.get("stats", {}), is_ot, is_so
                            )
                            db.add(PlayerStats(
                                player_id=player.id,
                                season="2025-2026",
                                game_id=game.id,
                                is_season_total=False,
                                fantasy_points=None,
                                **stat_data,
                            ))
                            results["rows_inserted"] += 1

                    results["games_processed"] += 1

                except Exception as e:
                    results["errors"].append(f"Game {game.pwhl_game_id}: {e}")
                    logger.error(f"Per-game scrape error for game {game.pwhl_game_id}: {e}", exc_info=True)

            db.commit()
            await asyncio.sleep(0.2)

    logger.info(f"Per-game scrape complete: {results}")
    return results


async def run_full_scrape(db) -> dict:
    """Run a full scrape and update the database."""
    from app.models.team import PWHLTeam
    from app.models.player import Player, PlayerStats
    from app.models.game import Game

    results = {"teams": 0, "players": 0, "stats": 0, "games": 0, "errors": []}

    async with aiohttp.ClientSession() as session:
        # --- Teams ---
        try:
            api_teams = await get_teams_from_api(session)
            for t in api_teams:
                code = t.get("code", "")
                db_abbr = TEAM_CODE_MAP.get(code, code)
                colors = TEAM_COLORS.get(code, {})
                logo_url = t.get("team_logo_url", "")

                existing = db.query(PWHLTeam).filter_by(abbreviation=db_abbr).first()
                if not existing:
                    team = PWHLTeam(
                        name=t.get("name", ""),
                        city=t.get("city", ""),
                        abbreviation=db_abbr,
                        logo_url=logo_url,
                        primary_color=colors.get("primary_color"),
                        secondary_color=colors.get("secondary_color"),
                    )
                    db.add(team)
                    results["teams"] += 1
                else:
                    # Update logo and colors if missing
                    if logo_url and not existing.logo_url:
                        existing.logo_url = logo_url
                    if colors.get("primary_color") and not existing.primary_color:
                        existing.primary_color = colors["primary_color"]
                    if colors.get("secondary_color") and not existing.secondary_color:
                        existing.secondary_color = colors["secondary_color"]
                    results["teams"] += 1
            db.commit()
        except Exception as e:
            results["errors"].append(f"Teams scrape: {e}")
            logger.error(f"Teams scrape error: {e}", exc_info=True)

        teams_by_abbr = {t.abbreviation: t for t in db.query(PWHLTeam).all()}

        def get_team(code: str):
            mapped = TEAM_CODE_MAP.get(code, code)
            return teams_by_abbr.get(mapped)

        # --- Skater stats ---
        try:
            skater_data = await get_player_stats_from_api(session)
            for raw in skater_data:
                player_info = parse_player_from_stats(raw)
                player_stats = parse_skater_stats(raw)

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()

                team_abbr = player_info.pop("team_abbreviation", "")
                pwhl_team = get_team(team_abbr)

                if not player:
                    player = Player(**player_info, pwhl_team_id=pwhl_team.id if pwhl_team else None)
                    db.add(player)
                else:
                    for k, v in player_info.items():
                        setattr(player, k, v)
                    if pwhl_team:
                        player.pwhl_team_id = pwhl_team.id
                results["players"] += 1

                db.flush()

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season="2025-2026", is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(
                        player_id=player.id,
                        season="2025-2026",
                        is_season_total=True,
                        **player_stats,
                    )
                    db.add(stat)
                else:
                    for k, v in player_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, player.position)
                results["stats"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Skater scrape: {e}")
            logger.error(f"Skater scrape error: {e}", exc_info=True)

        # --- Goalie stats ---
        try:
            goalie_data = await get_goalie_stats_from_api(session)
            for raw in goalie_data:
                player_info = parse_player_from_stats(raw)
                player_info["position"] = "G"
                goalie_stats = parse_goalie_stats(raw)

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()

                team_abbr = player_info.pop("team_abbreviation", "")
                pwhl_team = get_team(team_abbr)

                if not player:
                    player = Player(**player_info, pwhl_team_id=pwhl_team.id if pwhl_team else None)
                    db.add(player)
                    results["players"] += 1
                else:
                    player.position = "G"
                    if pwhl_team:
                        player.pwhl_team_id = pwhl_team.id

                db.flush()

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season="2025-2026", is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(
                        player_id=player.id,
                        season="2025-2026",
                        is_season_total=True,
                        **goalie_stats,
                    )
                    db.add(stat)
                else:
                    for k, v in goalie_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, "G")
                results["stats"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Goalie scrape: {e}")
            logger.error(f"Goalie scrape error: {e}", exc_info=True)

        # --- Games (via scorebar) ---
        try:
            scorebar = await get_scorebar_from_api(session)
            for g in scorebar:
                game_id = str(g.get("ID", ""))
                if not game_id:
                    continue

                home_code = g.get("HomeCode", "")
                away_code = g.get("VisitorCode", "")
                home_team = get_team(home_code)
                away_team = get_team(away_code)

                raw_date = g.get("Date", "")
                try:
                    game_date = datetime.strptime(raw_date, "%Y-%m-%d").date()
                except Exception:
                    continue

                raw_iso = g.get("GameDateISO8601", "")
                game_time = None
                if raw_iso:
                    try:
                        # Parse ISO8601 with offset e.g. "2026-01-25T15:00:00-05:00"
                        game_time = datetime.fromisoformat(raw_iso)
                    except Exception:
                        pass

                status = parse_game_status(g)
                period_str = g.get("Period", "0")
                period = _int(period_str) if period_str else None
                game_clock = g.get("GameClock", "")

                # Detect OT/SO from period name
                period_name = g.get("PeriodNameShort", "")
                is_overtime = period_name in ("OT", "4")
                is_shootout = period_name in ("SO", "5")

                existing = db.query(Game).filter_by(pwhl_game_id=game_id).first()
                if not existing:
                    game = Game(
                        pwhl_game_id=game_id,
                        season="2025-2026",
                        game_date=game_date,
                        game_time=game_time,
                        home_team_id=home_team.id if home_team else None,
                        away_team_id=away_team.id if away_team else None,
                        home_score=_int(g.get("HomeGoals", 0)),
                        away_score=_int(g.get("VisitorGoals", 0)),
                        status=status,
                        period=period,
                        time_remaining=game_clock,
                        is_overtime=is_overtime,
                        is_shootout=is_shootout,
                        venue=g.get("venue_name", ""),
                    )
                    db.add(game)
                else:
                    existing.status = status
                    existing.season = "2025-2026"   # correct any mis-tagged rows
                    existing.home_score = _int(g.get("HomeGoals", 0))
                    existing.away_score = _int(g.get("VisitorGoals", 0))
                    existing.period = period
                    existing.time_remaining = game_clock
                    existing.is_overtime = is_overtime
                    existing.is_shootout = is_shootout
                    if game_time:
                        existing.game_time = game_time
                results["games"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Games scrape: {e}")
            logger.error(f"Games scrape error: {e}", exc_info=True)

    return results


async def run_prev_season_scrape(db) -> dict:
    """
    Scrape 2024-25 season totals using season_id=5 (modulekit feed).
    Only updates player_stats rows; does not touch teams or games.
    """
    from app.models.player import Player, PlayerStats
    import sqlalchemy

    results = {"skaters": 0, "goalies": 0, "errors": []}
    season_label = PREV_SEASON_LABEL

    async with aiohttp.ClientSession() as session:
        teams_raw = db.execute(sqlalchemy.text("SELECT id, abbreviation FROM pwhl_teams")).fetchall()
        teams_by_abbr = {row[1]: row[0] for row in teams_raw}

        def get_team_id(code: str):
            mapped = TEAM_CODE_MAP.get(code, code)
            return teams_by_abbr.get(mapped)

        # --- 2024-25 Skaters ---
        try:
            skater_data = await get_player_stats_from_api(session, season_id=PREV_SEASON_ID)
            logger.info(f"Prev season skaters: {len(skater_data)} rows from API")
            for raw in skater_data:
                player_info = parse_player_from_stats(raw)
                player_stats = parse_skater_stats(raw)
                team_abbr = player_info.pop("team_abbreviation", "")

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()
                if not player:
                    player = Player(**player_info, pwhl_team_id=get_team_id(team_abbr))
                    db.add(player)
                    db.flush()

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season=season_label, is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(player_id=player.id, season=season_label,
                                       is_season_total=True, **player_stats)
                    db.add(stat)
                else:
                    for k, v in player_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, player.position)
                results["skaters"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Prev season skaters: {e}")
            logger.error(f"Prev season skater error: {e}", exc_info=True)

        # --- 2024-25 Goalies ---
        try:
            goalie_data = await get_goalie_stats_from_api(session, season_id=PREV_SEASON_ID)
            logger.info(f"Prev season goalies: {len(goalie_data)} rows from API")
            for raw in goalie_data:
                player_info = parse_player_from_stats(raw)
                player_info["position"] = "G"
                goalie_stats = parse_goalie_stats(raw)
                team_abbr = player_info.pop("team_abbreviation", "")

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()
                if not player:
                    player = Player(**player_info, pwhl_team_id=get_team_id(team_abbr))
                    db.add(player)
                    db.flush()
                else:
                    player.position = "G"

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season=season_label, is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(player_id=player.id, season=season_label,
                                       is_season_total=True, **goalie_stats)
                    db.add(stat)
                else:
                    for k, v in goalie_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, "G")
                results["goalies"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Prev season goalies: {e}")
            logger.error(f"Prev season goalie error: {e}", exc_info=True)

    logger.info(f"Prev season scrape complete: {results}")
    return results


async def run_inaugural_season_scrape(db) -> dict:
    """
    Scrape 2024 inaugural season totals using season_id=1 (modulekit feed).
    Stores stats with season label '2024'.
    """
    from app.models.player import Player, PlayerStats
    import sqlalchemy

    results = {"skaters": 0, "goalies": 0, "errors": []}
    season_label = INAUGURAL_SEASON_LABEL

    async with aiohttp.ClientSession() as session:
        teams_raw = db.execute(sqlalchemy.text("SELECT id, abbreviation FROM pwhl_teams")).fetchall()
        teams_by_abbr = {row[1]: row[0] for row in teams_raw}

        def get_team_id(code: str):
            mapped = TEAM_CODE_MAP.get(code, code)
            return teams_by_abbr.get(mapped)

        # --- 2024 Inaugural Skaters ---
        try:
            skater_data = await get_player_stats_from_api(session, season_id=INAUGURAL_SEASON_ID)
            logger.info(f"Inaugural season skaters: {len(skater_data)} rows from API")
            for raw in skater_data:
                player_info = parse_player_from_stats(raw)
                player_stats = parse_skater_stats(raw)
                team_abbr = player_info.pop("team_abbreviation", "")

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()
                if not player:
                    player = Player(**player_info, pwhl_team_id=get_team_id(team_abbr))
                    db.add(player)
                    db.flush()

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season=season_label, is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(player_id=player.id, season=season_label,
                                       is_season_total=True, **player_stats)
                    db.add(stat)
                else:
                    for k, v in player_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, player.position)
                results["skaters"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Inaugural skaters: {e}")
            logger.error(f"Inaugural skater error: {e}", exc_info=True)

        # --- 2024 Inaugural Goalies ---
        try:
            goalie_data = await get_goalie_stats_from_api(session, season_id=INAUGURAL_SEASON_ID)
            logger.info(f"Inaugural season goalies: {len(goalie_data)} rows from API")
            for raw in goalie_data:
                player_info = parse_player_from_stats(raw)
                player_info["position"] = "G"
                goalie_stats = parse_goalie_stats(raw)
                team_abbr = player_info.pop("team_abbreviation", "")

                player = db.query(Player).filter_by(
                    pwhl_player_id=player_info["pwhl_player_id"]
                ).first()
                if not player:
                    player = Player(**player_info, pwhl_team_id=get_team_id(team_abbr))
                    db.add(player)
                    db.flush()
                else:
                    player.position = "G"

                stat = db.query(PlayerStats).filter_by(
                    player_id=player.id, season=season_label, is_season_total=True
                ).first()
                if not stat:
                    stat = PlayerStats(player_id=player.id, season=season_label,
                                       is_season_total=True, **goalie_stats)
                    db.add(stat)
                else:
                    for k, v in goalie_stats.items():
                        setattr(stat, k, v)

                from app.services.scoring import calculate_fantasy_points_default
                stat.fantasy_points = calculate_fantasy_points_default(stat, "G")
                results["goalies"] += 1

            db.commit()
        except Exception as e:
            results["errors"].append(f"Inaugural goalies: {e}")
            logger.error(f"Inaugural goalie error: {e}", exc_info=True)

    logger.info(f"Inaugural season scrape complete: {results}")
    return results
