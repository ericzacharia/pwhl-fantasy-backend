#!/usr/bin/env python3
"""Scrape historical PWHL season stats and store in player_stats."""
import sys, asyncio, aiohttp
sys.path.insert(0, "/Users/eric/Desktop/2-Career/projects/PWHLFantasy/backend")

from app.database import SessionLocal
from app.models.player import Player, PlayerStats
from app.services.scraper import (
    _base_params, STATS_API_BASE, fetch_json,
    parse_skater_stats, parse_goalie_stats, _int, _float
)

HISTORICAL_SEASONS = [
    ("5", "2023-2024"),
    # ("6", "2024-2025-pre"),  # preseason partial — skip
    ("7", "2024-2025-pre2"),  # might be same as 8, check
]

async def scrape_season(session, season_id: str, season_label: str, db):
    print(f"\n📅 Season {season_id} ({season_label})")

    # Skaters
    params = {**_base_params(), "view":"statviewtype","type":"topscorers",
              "season_id":season_id,"limit":"250","sort":"points","division_id":"-1","qualified":"all"}
    data = await fetch_json(session, STATS_API_BASE, params)
    skaters = data.get("SiteKit",{}).get("Statviewtype",[]) if data else []
    print(f"  Skaters: {len(skaters)}")

    # Goalies
    params2 = {**_base_params(), "view":"statviewtype","type":"goalies",
               "season_id":season_id,"limit":"50","sort":"svpct","division_id":"-1","qualified":"all"}
    data2 = await fetch_json(session, STATS_API_BASE, params2)
    goalies = data2.get("SiteKit",{}).get("Statviewtype",[]) if data2 else []
    print(f"  Goalies: {len(goalies)}")

    saved = 0
    for raw in skaters:
        first = raw.get("firstName") or raw.get("first_name","")
        last  = raw.get("lastName")  or raw.get("last_name","")
        # Match player by name
        player = db.query(Player).filter(
            Player.first_name.ilike(first), Player.last_name.ilike(last)
        ).first()
        if not player:
            # Try last name only
            player = db.query(Player).filter(Player.last_name.ilike(last)).first()
        if not player:
            continue

        existing = db.query(PlayerStats).filter_by(player_id=player.id, season=season_label, is_season_total=True).first()
        goals   = _int(raw.get("goals"))
        assists = _int(raw.get("assists"))
        points  = _int(raw.get("points"))
        pim     = _int(raw.get("pim"))
        pm      = _int(raw.get("plusMinus") or raw.get("plus_minus"))
        sog     = _int(raw.get("shots") or raw.get("shotsOnGoal"))
        gp      = _int(raw.get("gamesPlayed") or raw.get("games_played"))
        fp      = float(goals * 6 + assists * 4 + points * 2 + pm * 2)

        if existing:
            existing.goals=goals; existing.assists=assists; existing.points=points
            existing.penalty_minutes=pim; existing.plus_minus=pm; existing.shots_on_goal=sog
            existing.games_played=gp; existing.fantasy_points=fp
        else:
            db.add(PlayerStats(
                player_id=player.id, season=season_label, is_season_total=True,
                goals=goals, assists=assists, points=points,
                penalty_minutes=pim, plus_minus=pm, shots=sog,
                games_played=gp, fantasy_points=fp
            ))
        saved += 1

    for raw in goalies:
        first = raw.get("firstName") or raw.get("first_name","")
        last  = raw.get("lastName")  or raw.get("last_name","")
        player = db.query(Player).filter(
            Player.first_name.ilike(first), Player.last_name.ilike(last)
        ).first()
        if not player:
            player = db.query(Player).filter(Player.last_name.ilike(last), Player.position == "G").first()
        if not player:
            continue

        existing = db.query(PlayerStats).filter_by(player_id=player.id, season=season_label, is_season_total=True).first()
        gp   = _int(raw.get("gamesPlayed") or raw.get("games_played"))
        wins = _int(raw.get("wins"))
        losses = _int(raw.get("losses"))
        gaa  = _float(raw.get("goalsAgainstAverage") or raw.get("gaa"))
        svp  = _float(raw.get("savePct") or raw.get("savePercentage") or raw.get("svpct"))
        so   = _int(raw.get("shutouts"))
        fp   = float(wins * 5 + so * 3)

        if existing:
            existing.wins=wins; existing.losses=losses; existing.goals_against_average=gaa
            existing.save_percentage=svp; existing.shutouts=so; existing.games_played=gp; existing.fantasy_points=fp
        else:
            db.add(PlayerStats(
                player_id=player.id, season=season_label, is_season_total=True,
                games_played=gp, wins=wins, losses=losses,
                goals_against_average=gaa, save_percentage=svp, shutouts=so,
                fantasy_points=fp
            ))
        saved += 1

    db.commit()
    print(f"  ✅ {saved} players saved for {season_label}")

async def main():
    db = SessionLocal()
    async with aiohttp.ClientSession() as session:
        for sid, label in HISTORICAL_SEASONS:
            await scrape_season(session, sid, label, db)
    db.close()
    print("\n🏒 Done!")

if __name__ == "__main__":
    asyncio.run(main())
