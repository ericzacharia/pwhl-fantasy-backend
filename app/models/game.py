from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean, Date
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base


class Game(Base):
    __tablename__ = "games"

    id = Column(Integer, primary_key=True, index=True)
    pwhl_game_id = Column(String, unique=True, index=True)
    season = Column(String(20), nullable=False)
    game_date = Column(Date, nullable=False)
    game_time = Column(DateTime(timezone=True))
    home_team_id = Column(Integer, ForeignKey("pwhl_teams.id"))
    away_team_id = Column(Integer, ForeignKey("pwhl_teams.id"))
    home_score = Column(Integer, default=0)
    away_score = Column(Integer, default=0)
    status = Column(String(20), default="scheduled")  # scheduled, live, final
    period = Column(Integer)
    time_remaining = Column(String(10))
    is_overtime = Column(Boolean, default=False)
    is_shootout = Column(Boolean, default=False)
    venue = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    home_team = relationship("PWHLTeam", foreign_keys=[home_team_id], back_populates="home_games")
    away_team = relationship("PWHLTeam", foreign_keys=[away_team_id], back_populates="away_games")
    player_stats = relationship("PlayerStats", back_populates="game")
    events = relationship("GameEvent", back_populates="game")


class GameEvent(Base):
    __tablename__ = "game_events"

    id = Column(Integer, primary_key=True, index=True)
    game_id = Column(Integer, ForeignKey("games.id"), index=True)
    event_type = Column(String(20))  # goal, penalty, shot, save
    period = Column(Integer)
    time_in_period = Column(String(10))
    player_id = Column(Integer, ForeignKey("players.id"))
    team_id = Column(Integer, ForeignKey("pwhl_teams.id"))
    description = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    game = relationship("Game", back_populates="events")
