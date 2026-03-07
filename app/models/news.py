from sqlalchemy import Column, Integer, String, DateTime, Text
from sqlalchemy.sql import func
from app.database import Base

class NewsArticle(Base):
    __tablename__ = "news_articles"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    url = Column(String, unique=True, nullable=False)
    thumbnail = Column(String, nullable=True)
    fallback_image = Column(String, nullable=True)
    date_str = Column(String, nullable=True)
    team_logos = Column(Text, nullable=True)  # JSON array of logo URLs
    summary = Column(Text, nullable=True)
    player_image_url = Column(String, nullable=True)  # headshot if player name detected in title
    scraped_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
