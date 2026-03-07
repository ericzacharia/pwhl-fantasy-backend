#!/usr/bin/env python3
"""PWHL Fantasy News Scraper — runs every 4 hours.
Sources:
  1. thepwhl.com/en/news (Playwright — JS-rendered)
  2. Google News RSS — PWHL search
  3. The Ice Garden RSS — women's hockey coverage
"""
import sys, asyncio, httpx, json
from bs4 import BeautifulSoup

sys.path.insert(0, "/Users/eric/Desktop/2-Career/projects/PWHLFantasy/backend")
from app.database import SessionLocal
from app.models.news import NewsArticle

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
}


GOOGLE_GENERIC_THUMBS = ["news.google.com", "J6_coFbogxhRI9iM864NL", "googleusercontent.com", "lh3.google"]

def is_generic_thumbnail(url: str) -> bool:
    return url and any(p in url for p in GOOGLE_GENERIC_THUMBS)

def normalize_date(raw: str) -> str:
    """Normalize any date string to ISO 8601 format."""
    import re
    if not raw:
        return raw
    if re.match(r'^\d{4}-\d{2}-\d{2}', raw):
        return raw  # already ISO
    try:
        from email.utils import parsedate_to_datetime
        return parsedate_to_datetime(raw).strftime('%Y-%m-%dT%H:%M:%S%z')
    except:
        try:
            from dateutil import parser as dp
            dt = dp.parse(raw)
            return dt.strftime('%Y-%m-%dT%H:%M:%S%z') if dt else raw
        except:
            return raw

TEAM_LOGOS = {
    "boston":     (1, "https://assets.leaguestat.com/pwhl/logos/1.png"),
    "fleet":      (1, "https://assets.leaguestat.com/pwhl/logos/1.png"),
    "minnesota":  (2, "https://assets.leaguestat.com/pwhl/logos/2.png"),
    "frost":      (2, "https://assets.leaguestat.com/pwhl/logos/2.png"),
    "montreal":   (3, "https://assets.leaguestat.com/pwhl/logos/3.png"),
    "montréal":   (3, "https://assets.leaguestat.com/pwhl/logos/3.png"),
    "victoire":   (3, "https://assets.leaguestat.com/pwhl/logos/3.png"),
    "new york":   (4, "https://assets.leaguestat.com/pwhl/logos/4.png"),
    "sirens":     (4, "https://assets.leaguestat.com/pwhl/logos/4.png"),
    "ottawa":     (5, "https://assets.leaguestat.com/pwhl/logos/5.png"),
    "charge":     (5, "https://assets.leaguestat.com/pwhl/logos/5.png"),
    "toronto":    (6, "https://assets.leaguestat.com/pwhl/logos/6.png"),
    "sceptres":   (6, "https://assets.leaguestat.com/pwhl/logos/6.png"),
    "seattle":    (7, "https://assets.leaguestat.com/pwhl/logos/7.png"),
    "torrent":    (7, "https://assets.leaguestat.com/pwhl/logos/7.png"),
    "vancouver":  (8, "https://assets.leaguestat.com/pwhl/logos/8.png"),
    "goldeneyes": (8, "https://assets.leaguestat.com/pwhl/logos/8.png"),
}

def detect_team_logos(title: str) -> list:
    lower = title.lower()
    seen_ids = {}
    for keyword, (team_id, logo_url) in TEAM_LOGOS.items():
        if keyword in lower and team_id not in seen_ids:
            seen_ids[team_id] = logo_url
        if len(seen_ids) >= 2:
            break
    return list(seen_ids.values())

async def fetch_og_image(client, url: str):
    try:
        resp = await client.get(url, headers=HEADERS, timeout=10.0, follow_redirects=True)
        soup = BeautifulSoup(resp.text, "lxml")
        og = soup.select_one('meta[property="og:image"]') or soup.select_one('meta[name="twitter:image"]')
        if og:
            src = og.get("content", "")
            if src and src.startswith("http"):
                return src
        img = soup.select_one("article img,[class*='hero'] img,[class*='Hero'] img")
        if img:
            src = img.get("src") or img.get("data-src") or ""
            if src.startswith("//"): src = "https:" + src
            if src.startswith("http"): return src
    except Exception as e:
        print(f"  og:image failed for {url[:60]}: {e}")
    return None

async def scrape_pwhl_official() -> list:
    try:
        from playwright.async_api import async_playwright
        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            page = await browser.new_page()
            await page.goto("https://www.thepwhl.com/en/news", wait_until="networkidle", timeout=20000)
            try:
                await page.wait_for_selector("a[href*='/news/']", timeout=10000)
            except:
                pass
            articles = []
            seen = set()
            for link in await page.query_selector_all("a[href*='/news/']"):
                href = await link.get_attribute("href") or ""
                if not href.startswith("http"): href = "https://www.thepwhl.com" + href
                if href in seen or href == "https://www.thepwhl.com/en/news": continue
                seen.add(href)
                title_el = await link.query_selector("h1,h2,h3,h4,[class*='title'],[class*='headline']")
                title = ((await title_el.inner_text()).strip() if title_el else (await link.inner_text()).strip())
                img_el = await link.query_selector("img")
                img_src = ((await img_el.get_attribute("src") or "") if img_el else "")
                if img_src.startswith("//"): img_src = "https:" + img_src
                if title and len(title) > 10:
                    # Try to grab date from time[datetime] on the page
                    time_el = await link.query_selector("time[datetime]")
                    date_val = (await time_el.get_attribute("datetime")) if time_el else None
                    articles.append({"title": title, "url": href, "thumbnail": img_src or None, "date": date_val, "source": "PWHL"})
            await browser.close()
            print(f"  [thepwhl.com] {len(articles)} articles")
            return articles[:30]
    except Exception as e:
        print(f"  [thepwhl.com] error: {e}")
        return []

async def scrape_google_news_rss(client) -> list:
    try:
        url = "https://news.google.com/rss/search?q=PWHL+hockey+women&hl=en-US&gl=US&ceid=US:en"
        resp = await client.get(url, headers=HEADERS, timeout=15)
        soup = BeautifulSoup(resp.text, "lxml-xml")
        articles = []
        for item in soup.find_all("item")[:60]:
            title = (item.find("title").text if item.find("title") else "").strip()
            link  = (item.find("link").text if item.find("link") else "").strip()
            pub   = normalize_date((item.find("pubDate").text if item.find("pubDate") else "").strip())
            if not title or not link or len(title) < 10: continue
            if "pwhl" not in title.lower() and "women" not in title.lower(): continue
            articles.append({"title": title, "url": link, "thumbnail": None, "date": pub, "source": "Google News"})
        print(f"  [Google News RSS] {len(articles)} articles")
        return articles
    except Exception as e:
        print(f"  [Google News RSS] error: {e}")
        return []

async def scrape_ice_garden_rss(client) -> list:
    try:
        resp = await client.get("https://theicegarden.com/feed", headers=HEADERS, timeout=15)
        soup = BeautifulSoup(resp.text, "lxml-xml")
        articles = []
        pwhl_keywords = ["pwhl","fleet","frost","victoire","sirens","charge","sceptres","torrent","goldeneyes"]
        for item in soup.find_all("item")[:30]:
            title = (item.find("title").text if item.find("title") else "").strip()
            link  = (item.find("link").text if item.find("link") else "").strip()
            pub   = normalize_date((item.find("pubDate").text if item.find("pubDate") else "").strip())
            if not title or not link: continue
            if not any(k in title.lower() for k in pwhl_keywords): continue
            media = item.find("media:content") or item.find("enclosure")
            thumb = media.get("url") if media else None
            articles.append({"title": title, "url": link, "thumbnail": thumb, "date": pub, "source": "The Ice Garden"})
        print(f"  [The Ice Garden] {len(articles)} PWHL articles")
        return articles
    except Exception as e:
        print(f"  [The Ice Garden] error: {e}")
        return []

async def main():
    print("Hockey News Scraper starting...")
    async with httpx.AsyncClient(timeout=20.0, follow_redirects=True) as client:
        pwhl_articles, gnews_articles, ig_articles = await asyncio.gather(
            scrape_pwhl_official(),
            scrape_google_news_rss(client),
            scrape_ice_garden_rss(client),
        )

    all_articles = pwhl_articles + gnews_articles + ig_articles
    seen_urls = {}
    for art in all_articles:
        if art["url"] not in seen_urls:
            seen_urls[art["url"]] = art
    unique = list(seen_urls.values())
    print(f"  Total unique articles: {len(unique)}")

    db = SessionLocal()
    saved = 0
    async with httpx.AsyncClient(timeout=15.0, follow_redirects=True) as client:
        for art in unique:
            existing = db.query(NewsArticle).filter_by(url=art["url"]).first()
            if existing and existing.thumbnail:
                if not existing.team_logos:
                    logos = detect_team_logos(art["title"])
                    existing.team_logos = json.dumps(logos) if logos else None
                    db.commit()
                continue
            thumbnail = art.get("thumbnail")
            if not thumbnail:
                thumbnail = await fetch_og_image(client, art["url"])
            logos = detect_team_logos(art["title"])
            if existing:
                existing.thumbnail = thumbnail
                existing.team_logos = json.dumps(logos) if logos else None
                existing.title = art["title"]
                existing.date_str = art.get("date")
            else:
                db.add(NewsArticle(
                    title=art["title"], url=art["url"],
                    thumbnail=thumbnail,
                    team_logos=json.dumps(logos) if logos else None,
                    date_str=art.get("date"),
                ))
            saved += 1
            print(f"  + {art['source']} | {art['title'][:60]}")
    db.commit()
    db.close()
    print(f"Done — {saved} new/updated articles (total in DB will show on next app load)")

if __name__ == "__main__":
    asyncio.run(main())
    # After scraping, enrich any missing thumbnails
    from enrich_thumbnails import enrich
    asyncio.run(enrich(limit=50))
