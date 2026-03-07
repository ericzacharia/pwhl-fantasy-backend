from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, ForeignKey, Date
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base


class Player(Base):
    __tablename__ = "players"

    id = Column(Integer, primary_key=True, index=True)
    pwhl_player_id = Column(String, unique=True, index=True)
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    position = Column(String(2), nullable=False)  # C, LW, RW, D, G
    jersey_number = Column(Integer)
    pwhl_team_id = Column(Integer, ForeignKey("pwhl_teams.id"))
    nationality = Column(String)
    birthdate = Column(Date)
    height_cm = Column(Integer)
    weight_kg = Column(Integer)
    shoots = Column(String(1))  # L or R (catches for goalies)
    is_active = Column(Boolean, default=True)
    headshot_url = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    pwhl_team = relationship("PWHLTeam", back_populates="players")
    stats = relationship("PlayerStats", back_populates="player")
    roster_entries = relationship("FantasyRoster", back_populates="player")

    @property
    def full_name(self):
        return f"{self.first_name} {self.last_name}"


class PlayerStats(Base):
    __tablename__ = "player_stats"

    id = Column(Integer, primary_key=True, index=True)
    player_id = Column(Integer, ForeignKey("players.id"), index=True)
    season = Column(String(9), nullable=False)  # e.g., "2024-2025"
    game_id = Column(Integer, ForeignKey("games.id"), nullable=True)

    # Skater stats
    games_played = Column(Integer, default=0)
    goals = Column(Integer, default=0)
    assists = Column(Integer, default=0)
    points = Column(Integer, default=0)
    plus_minus = Column(Integer, default=0)
    penalty_minutes = Column(Integer, default=0)
    shots = Column(Integer, default=0)
    hits = Column(Integer, default=0)
    blocks = Column(Integer, default=0)
    faceoffs_won = Column(Integer, default=0)
    faceoffs_total = Column(Integer, default=0)
    time_on_ice = Column(Float, default=0.0)  # minutes

    # Goalie stats
    wins = Column(Integer, default=0)
    losses = Column(Integer, default=0)
    overtime_losses = Column(Integer, default=0)
    saves = Column(Integer, default=0)
    shots_against = Column(Integer, default=0)
    goals_against = Column(Integer, default=0)
    shutouts = Column(Integer, default=0)
    save_percentage = Column(Float, default=0.0)
    goals_against_average = Column(Float, default=0.0)

    # Fantasy points
    fantasy_points = Column(Float, default=0.0)

    is_season_total = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    player = relationship("Player", back_populates="stats")
    game = relationship("Game", back_populates="player_stats")
