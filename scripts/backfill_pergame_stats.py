#!/usr/bin/env python3
"""Backfill per-game player stats for all players in the current season.

Usage:
    python scripts/backfill_pergame_stats.py
"""
import asyncio
import sys
import os

# Allow running from the repo root
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.database import SessionLocal
from app.services.scraper import run_pergame_scrape


async def main():
    print("Starting per-game stats backfill...")
    db = SessionLocal()
    try:
        results = await run_pergame_scrape(db)
        print("Backfill complete:")
        print(f"  Games processed   : {results['games_processed']}")
        print(f"  Rows inserted     : {results['rows_inserted']}")
        if results["errors"]:
            print(f"  Errors ({len(results['errors'])}):")
            for err in results["errors"]:
                print(f"    - {err}")
        else:
            print("  No errors.")
    finally:
        db.close()


if __name__ == "__main__":
    asyncio.run(main())
