from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
import logging

from app.database import engine, Base
from app.config import settings
from app.routers import trends as trends_router
from app.routers import analytics as analytics_router
from app.routers import fantasy as fantasy_router
from app.routers import auth, players, leagues, games, admin, pwhl

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Create all tables on startup
    Base.metadata.create_all(bind=engine)
    logger.info("Database tables created/verified")

    # Start background scheduler
    from apscheduler.schedulers.asyncio import AsyncIOScheduler
    from app.database import SessionLocal
    from app.services.scraper import run_full_scrape, run_pergame_scrape
    import asyncio

    scheduler = AsyncIOScheduler()

    async def scheduled_scrape():
        db = SessionLocal()
        try:
            logger.info("Running scheduled PWHL data scrape...")
            results = await run_full_scrape(db)
            logger.info(f"Scrape completed: {results}")
            logger.info("Running per-game stats scrape...")
            pg_results = await run_pergame_scrape(db)
            logger.info(f"Per-game scrape completed: {pg_results}")
        except Exception as e:
            logger.error(f"Scheduled scrape failed: {e}")
        finally:
            db.close()

    # Run scrape daily at 6 AM UTC
    scheduler.add_job(scheduled_scrape, "cron", hour=6, minute=0)
    scheduler.start()

    yield

    scheduler.shutdown()



import time, json as _json
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request as StarletteRequest

class RequestLogMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: StarletteRequest, call_next):
        start = time.time()
        response = await call_next(request)
        duration_ms = int((time.time() - start) * 1000)
        # Log to analytics table in background (best-effort)
        path = request.url.path
        if path.startswith("/api/") and path != "/api/v1/analytics/event":
            try:
                from app.database import SessionLocal as _SL
                from app.models.analytics import AnalyticsEvent as _AE
                _db = _SL()
                _db.add(_AE(
                    event_type="api_call",
                    endpoint=f"{request.method} {path}",
                    ip_address=request.client.host if request.client else None,
                    user_agent=request.headers.get("user-agent"),
                    properties=_json.dumps({"status": response.status_code, "duration_ms": duration_ms}),
                ))
                _db.commit()
                _db.close()
            except:
                pass
        return response

app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="PWHL Fantasy Hockey API - Professional Women's Hockey League",
    lifespan=lifespan,
)
app.add_middleware(RequestLogMiddleware)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/v1")
app.include_router(players.router, prefix="/api/v1")
app.include_router(leagues.router, prefix="/api/v1")
app.include_router(games.router, prefix="/api/v1")
app.include_router(admin.router, prefix="/api/v1")
app.include_router(pwhl.router, prefix="/api/v1")
app.include_router(analytics_router.router, prefix="/api/v1")
app.include_router(fantasy_router.router, prefix="/api/v1")
app.include_router(trends_router.router, prefix="/api/v1")


@app.get("/")
def root():
    return {"name": settings.APP_NAME, "version": settings.APP_VERSION, "status": "running"}


@app.get("/health")
def health():
    return {"status": "healthy"}
