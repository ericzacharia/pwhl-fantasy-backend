#!/usr/bin/env python3
"""
generate_trend_articles.py

Fetches current PWHL trends, uses OpenAI to write short news articles,
and inserts them into news_articles table authored by UnsupervisedBias.

Run: python3 scripts/generate_trend_articles.py
Cron: 0 2 * * * (2 AM ET nightly, after games finish)

Requires: OPENAI_API_KEY env var (add to docker-compose.yml or .env)
"""
import os
import sys
import hashlib
import datetime
import requests
import anthropic

# Add parent to path so we can import app modules
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from app.database import SessionLocal
from app.models.news import NewsArticle

API_BASE = os.getenv("PWHL_API_BASE", "http://localhost:8080/api/v1")
ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY")
AUTHOR = "UnsupervisedBias"
SOURCE = "unsupervisedbias.com"


def fetch_trends(last_n: int = 10) -> list[dict]:
    resp = requests.get(f"{API_BASE}/trends", params={"last_n": last_n}, timeout=10)
    resp.raise_for_status()
    return resp.json().get("trends", [])


def generate_article(trend: dict, client: OpenAI) -> tuple[str, str]:
    """Returns (title, article_body) for a trend."""
    prompt = f"""You are a sports reporter for UnsupervisedBias, a data-driven PWHL analytics outlet.
Write a short, punchy 2-4 sentence news article based on the following PWHL trend.
Be specific, use the stats provided, and write in the style of a beat reporter.
Do not use phrases like "data shows" or "according to statistics" — just state the facts naturally.

Trend category: {trend['category']}
Trend title: {trend['title']}
Details: {trend['description']}

Output ONLY the article body — no headline, no byline."""

    response = client.messages.create(
        model="claude-haiku-4-5",
        max_tokens=150,
        messages=[{"role": "user", "content": prompt}],
    )
    body = response.content[0].text.strip()
    return trend["title"], body


def stable_url(trend_id: str, date: str) -> str:
    """Generate a stable fake URL so the unique constraint doesn't block re-runs on new dates."""
    slug = hashlib.md5(f"{trend_id}:{date}".encode()).hexdigest()[:12]
    return f"https://unsupervisedbias.com/trends/{date}/{slug}"


def run():
    if not ANTHROPIC_API_KEY:
        print("ERROR: ANTHROPIC_API_KEY not set")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=ANTHROPIC_API_KEY)
    today = datetime.date.today().isoformat()

    print(f"Fetching trends for {today}...")
    trends = fetch_trends(last_n=10)
    print(f"Found {len(trends)} trends")

    if not trends:
        print("No trends to write about today.")
        return

    db = SessionLocal()
    inserted = 0
    try:
        for trend in trends:
            url = stable_url(trend["id"], today)

            # Skip if already generated today
            existing = db.query(NewsArticle).filter_by(url=url).first()
            if existing:
                print(f"  Skipping (exists): {trend['title']}")
                continue

            print(f"  Generating: {trend['title']}")
            try:
                title, body = generate_article(trend, client)
            except Exception as e:
                print(f"  LLM error for {trend['id']}: {e}")
                continue

            article = NewsArticle(
                title=title,
                url=url,
                summary=body,
                date_str=today,
                # Use UB logo as thumbnail placeholder
                thumbnail="https://unsupervisedbias.com/UB.png",
                fallback_image="https://unsupervisedbias.com/UB.png",
            )
            db.add(article)
            inserted += 1

        db.commit()
        print(f"Inserted {inserted} new trend articles.")
    finally:
        db.close()


if __name__ == "__main__":
    run()
