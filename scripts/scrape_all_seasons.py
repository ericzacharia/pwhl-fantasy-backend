"""
Scrape all PWHL games from HockeyTech scorebar and store in DB.
Run from backend root: python3 scripts/scrape_all_seasons.py
"""
import asyncio, sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import aiohttp
from datetime import datetime
from sqlalchemy import text
from app.database import SessionLocal
from app.models.game import Game
from app.models.team import PWHLTeam

BASE = "https://lscluster.hockeytech.com/feed/index.php"
BP = {"feed": "modulekit", "client_code": "pwhl", "lang": "en",
      "key": "446521baf8c38984", "league_id": "1"}

SEASON_MAP = {
    "1": "2024", "2": "2024-preseason",
    "3": "2024-playoffs",
    "4": "2024-25-preseason", "5": "2024-2025",
    "6": "2025-playoffs",
    "7": "2025-26-preseason", "8": "2025-2026",
}
TEAM_MAP = {"BOS":"BOS","MIN":"MIN","MTL":"MTL","NY":"NYR","NYR":"NYR",
            "OTT":"OTT","TOR":"TOR","SEA":"SEA","VAN":"VAN"}

async def run():
    db = SessionLocal()
    teams = {t.abbreviation: t for t in db.query(PWHLTeam).all()}

    async with aiohttp.ClientSession() as session:
        async with session.get(BASE, params={**BP, "view": "scorebar",
            "numberofdaysahead": "60", "numberofdaysback": "1100"},
            timeout=aiohttp.ClientTimeout(total=90)) as r:
            games = (await r.json(content_type=None)).get("SiteKit", {}).get("Scorebar", [])

    print(f"Fetched {len(games)} games from API")
    added = updated = 0

    for g in games:
        gid = str(g.get("ID", ""))
        if not gid: continue
        ss = (g.get("GameStatusString", "") or "").lower()
        status = "final" if "final" in ss else ("live" if "progress" in ss else "scheduled")
        season = SEASON_MAP.get(str(g.get("SeasonID", "8")), "2025-2026")
        ht = teams.get(TEAM_MAP.get(g.get("HomeCode", ""), ""))
        at = teams.get(TEAM_MAP.get(g.get("VisitorCode", ""), ""))
        try: gd = datetime.strptime(g.get("Date", ""), "%Y-%m-%d").date()
        except: continue

        vals = dict(season=season, game_date=gd,
                    home_team_id=ht.id if ht else None,
                    away_team_id=at.id if at else None,
                    home_score=int(g.get("HomeGoals") or 0),
                    away_score=int(g.get("VisitorGoals") or 0),
                    status=status)
        ex = db.query(Game).filter_by(pwhl_game_id=gid).first()
        if ex:
            for k, v in vals.items(): setattr(ex, k, v)
            updated += 1
        else:
            db.add(Game(pwhl_game_id=gid, **vals))
            added += 1

    db.commit()
    print(f"Done — added: {added}, updated: {updated}")

    for r in db.execute(text(
        "SELECT season, COUNT(*), SUM(CASE WHEN status='final' THEN 1 ELSE 0 END) "
        "FROM games GROUP BY season ORDER BY season"
    )).fetchall():
        print(f"  {r[0]}: {r[1]} games ({r[2]} final)")

    db.close()

if __name__ == "__main__":
    asyncio.run(run())
