"""
Thumbnail enrichment — for articles missing real thumbnails,
decode Google News redirect URLs, then fetch og:image from the actual article.
"""
import asyncio, sys
sys.path.insert(0, '.')
import httpx
from bs4 import BeautifulSoup
from app.database import SessionLocal
from app.models.news import NewsArticle
from googlenewsdecoder import new_decoderv1

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
}
GOOGLE_PATTERNS = ["news.google.com", "J6_coFbogxhRI9iM864NL"]

def is_bad_thumb(url: str | None) -> bool:
    return not url or any(p in url for p in GOOGLE_PATTERNS)

def resolve_url(url: str) -> str:
    """If Google News URL, decode to real article URL."""
    if "news.google.com" in url:
        try:
            result = new_decoderv1(url)
            if result.get("status") and result.get("decoded_url"):
                return result["decoded_url"]
        except: pass
    return url

async def fetch_real_thumb(client: httpx.AsyncClient, article_url: str) -> str | None:
    real_url = resolve_url(article_url)
    try:
        r = await client.get(real_url, headers=HEADERS, timeout=12, follow_redirects=True)
        soup = BeautifulSoup(r.text, "lxml")
        for sel in ['meta[property="og:image"]', 'meta[name="twitter:image"]']:
            tag = soup.select_one(sel)
            if tag and tag.get("content"):
                img = tag["content"]
                if img.startswith("http") and not is_bad_thumb(img):
                    return img
    except: pass
    return None

async def enrich(limit: int = 200):
    db = SessionLocal()
    articles = (
        db.query(NewsArticle)
        .filter(
            (NewsArticle.thumbnail == None) |
            (NewsArticle.thumbnail.like("%news.google.com%")) |
            (NewsArticle.thumbnail.like("%J6_coFbogxhRI9iM864NL%"))
        )
        .order_by(NewsArticle.date_str.desc())
        .limit(limit)
        .all()
    )
    print(f"Articles needing thumbnail enrichment: {len(articles)}")

    enriched = 0
    async with httpx.AsyncClient(follow_redirects=True, timeout=15) as client:
        for i in range(0, len(articles), 8):
            batch = articles[i:i+8]
            thumbs = await asyncio.gather(*[fetch_real_thumb(client, a.url) for a in batch])
            for a, thumb in zip(batch, thumbs):
                if thumb:
                    a.thumbnail = thumb
                    enriched += 1
            db.commit()
            if i % 32 == 0 and i > 0:
                print(f"  {enriched}/{len(articles)} enriched...")

    db.close()
    print(f"✅ Enriched {enriched}/{len(articles)} thumbnails")
    return enriched

if __name__ == "__main__":
    asyncio.run(enrich())
