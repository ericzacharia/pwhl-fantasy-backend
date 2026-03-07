from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base


class PWHLTeam(Base):
    __tablename__ = "pwhl_teams"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    city = Column(String, nullable=False)
    abbreviation = Column(String(5), unique=True, nullable=False)
    logo_url = Column(String)
    primary_color = Column(String(7))
    secondary_color = Column(String(7))
    arena = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    players = relationship("Player", back_populates="pwhl_team")
    home_games = relationship("Game", foreign_keys="Game.home_team_id", back_populates="home_team")
    away_games = relationship("Game", foreign_keys="Game.away_team_id", back_populates="away_team")
