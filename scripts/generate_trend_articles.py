#!/usr/bin/env python3
"""
generate_trend_articles.py

Fetches PWHL trends, uses Claude Opus to write short news articles,
and inserts them into news_articles with rotating author personas.

Run: python3 scripts/generate_trend_articles.py
Cron: 0 6 * * * (6 AM UTC / 2 AM ET nightly)

Requires: ANTHROPIC_API_KEY env var
"""
import os, sys, hashlib, datetime, json, requests, anthropic

sys.path.insert(0, "/app")

from app.database import SessionLocal
from app.models.news import NewsArticle

API_BASE = os.getenv("PWHL_API_BASE", "http://localhost:8080/api/v1")
ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY")
THUMBNAIL_URL = "https://unsupervisedbias.com/ub-trend-thumbnail.jpg"
DICEBEAR_BASE = "https://api.dicebear.com/9.x/avataaars/png?size=96"

# ── Author personas ────────────────────────────────────────────────────────────
AUTHORS = [
    {
        "name": "Maya Okafor",
        "title": "Senior Hockey Analyst",
        "categories": ["Standings", "Team Dominance", "Team Defense", "Discipline", "Interesting Stories"],
        "bio": "Maya covers team dynamics and standings with a focus on tactics and systemic trends in women's hockey.",
        "voice": "analytical and direct, grounding every stat in tactical context",
        "avatar": f"{DICEBEAR_BASE}&seed=MayaOkafor&backgroundColor=b6e3f4&skinColor=ae5d29",
    },
    {
        "name": "Sarah Chen",
        "title": "Advanced Metrics Writer",
        "categories": ["Shooting", "Two-Way Play", "Fantasy", "Special Teams"],
        "bio": "Sarah specializes in advanced statistics and data-driven storytelling in women's hockey.",
        "voice": "precise and data-focused, weaving numbers naturally into compelling narratives",
        "avatar": f"{DICEBEAR_BASE}&seed=SarahChen&backgroundColor=ffd5dc&skinColor=f8d25c",
    },
    {
        "name": "Jen Kowalski",
        "title": "Player Features Writer",
        "categories": ["Hot Players", "Scoring", "Playmaking", "Interesting Stories"],
        "bio": "Jen focuses on the human stories behind the statistics — careers, journeys, and breakthrough moments.",
        "voice": "narrative and personal, connecting stats to the player's journey and competitive drive",
        "avatar": f"{DICEBEAR_BASE}&seed=JenKowalski&backgroundColor=c0aede&skinColor=fdbcb4",
    },
    {
        "name": "Priya Sharma",
        "title": "Goaltending & Defense Correspondent",
        "categories": ["Goaltending", "Defense", "Physical Play"],
        "bio": "Priya is the go-to authority on goaltending mechanics, shot-blocking, and defensive systems.",
        "voice": "technical and insightful, with deep expertise in what happens at the defensive end of the ice",
        "avatar": f"{DICEBEAR_BASE}&seed=PriyaSharma&backgroundColor=d1f4cc&skinColor=ae5d29",
    },
    {
        "name": "Alexis Rivera",
        "title": "Fantasy Hockey Editor",
        "categories": ["Fantasy", "Scoring", "Shooting"],
        "bio": "Alexis covers the fantasy angle on every PWHL storyline, with an eye for value picks and breakout potential.",
        "voice": "upbeat and fantasy-focused, always connecting the narrative to what it means for your lineup",
        "avatar": f"{DICEBEAR_BASE}&seed=AlexisRivera&backgroundColor=ffdfbf&skinColor=edb98a",
    },
    {
        "name": "Danielle Tremblay",
        "title": "Form & Special Teams Analyst",
        "categories": ["Recent Form", "Home/Away", "Clutch Play", "Special Teams", "Interesting Stories"],
        "bio": "Danielle brings a French-Canadian hockey perspective to form analysis, momentum shifts, and special teams.",
        "voice": "passionate and contextual, celebrating the drama and culture of women's hockey",
        "avatar": f"{DICEBEAR_BASE}&seed=DanielleTremblay&backgroundColor=f4e0fb&skinColor=fdbcb4",
    },
]

_author_index = 0  # fallback rotation index

def assign_author(trend: dict) -> dict:
    """Pick the most relevant author for a trend category."""
    category = trend.get("category", "")
    for author in AUTHORS:
        if category in author["categories"]:
            return author
    # Fallback: rotate
    global _author_index
    author = AUTHORS[_author_index % len(AUTHORS)]
    _author_index += 1
    return author


def fetch_trends(last_n: int = 10) -> list[dict]:
    resp = requests.get(f"{API_BASE}/trends", params={"last_n": last_n}, timeout=10)
    resp.raise_for_status()
    return resp.json().get("trends", [])


def generate_article(trend: dict, author: dict, client: anthropic.Anthropic) -> tuple[str, str]:
    """Returns (headline, article_body_with_author_footer)."""
    player_context = ""
    if trend.get("player"):
        player_context = f"""
If you know any publicly known biographical facts about {trend['player']} — such as their nationality,
Olympic history, home city, career milestones, personal background, or any off-ice context that relates
to this story — weave it in naturally. Don't invent facts; only include things you know to be true."""

    prompt = f"""You are {author['name']}, {author['title']} at UnsupervisedBias, a data-driven PWHL analytics outlet.
Your writing style: {author['voice']}.

Write a short, punchy PWHL news article based on this trend.
Be specific with the stats. Write like a confident beat reporter — no fluff, no "data shows" phrasing.
{player_context}

Trend category: {trend['category']}
Trend: {trend['description']}

Output in this exact format:
HEADLINE: <vivid, specific headline — not generic>
BODY: <2-4 sentence article. Include any relevant biographical/personal context you know about the player or team.>"""

    response = client.messages.create(
        model="claude-opus-4-5-20251101",
        max_tokens=250,
        messages=[{"role": "user", "content": prompt}],
    )
    text = response.content[0].text.strip()

    headline = trend["title"]
    body = text
    for line in text.split("\n"):
        if line.startswith("HEADLINE:"):
            headline = line.replace("HEADLINE:", "").strip()
        elif line.startswith("BODY:"):
            body = line.replace("BODY:", "").strip()

    # Append author signature
    full_body = (
        f"{body}\n\n"
        f"— {author['name']}, {author['title']} · UnsupervisedBias"
    )
    return headline, full_body


def stable_url(trend_id: str, date: str) -> str:
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
        print("No trends today.")
        return

    db = SessionLocal()
    inserted = 0
    try:
        for trend in trends:
            url = stable_url(trend["id"], today)
            if db.query(NewsArticle).filter_by(url=url).first():
                print(f"  Skipping: {trend['title']}")
                continue

            author = assign_author(trend)
            print(f"  [{author['name']}] Generating: {trend['title']}")
            try:
                title, body = generate_article(trend, author, client)
            except Exception as e:
                print(f"  LLM error: {e}")
                continue

            db.add(NewsArticle(
                title=title,
                url=url,
                summary=body,
                date_str=today,
                thumbnail=THUMBNAIL_URL,
                fallback_image=THUMBNAIL_URL,
                player_image_url=author["avatar"],  # author headshot
            ))
            inserted += 1

        db.commit()
        print(f"Inserted {inserted} new trend articles.")
    finally:
        db.close()


if __name__ == "__main__":
    run()
