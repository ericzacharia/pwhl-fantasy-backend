from sqlalchemy import Column, Integer, String, DateTime, Text, Float
from sqlalchemy.sql import func
from app.database import Base

class AnalyticsEvent(Base):
    __tablename__ = "analytics_events"

    id            = Column(Integer, primary_key=True, index=True)
    user_id       = Column(Integer, index=True, nullable=True)   # null = unauthenticated
    event_type    = Column(String(64), index=True)               # api_call, screen_view, app_open, etc.
    endpoint      = Column(String(256), nullable=True)
    screen        = Column(String(128), nullable=True)
    properties    = Column(Text, nullable=True)                  # JSON blob of extra data
    ip_address    = Column(String(64), nullable=True)
    user_agent    = Column(String(512), nullable=True)
    app_version   = Column(String(32), nullable=True)
    os_version    = Column(String(32), nullable=True)
    device_model  = Column(String(128), nullable=True)
    device_id     = Column(String(256), nullable=True)           # IDFV
    locale        = Column(String(32), nullable=True)
    timezone      = Column(String(64), nullable=True)
    network_type  = Column(String(32), nullable=True)
    session_id    = Column(String(64), nullable=True, index=True)
    created_at    = Column(DateTime(timezone=True), server_default=func.now(), index=True)

class DeviceProfile(Base):
    __tablename__ = "device_profiles"

    id            = Column(Integer, primary_key=True, index=True)
    user_id       = Column(Integer, index=True)
    device_id     = Column(String(256), unique=True, index=True) # IDFV
    device_model  = Column(String(128), nullable=True)
    os_version    = Column(String(32), nullable=True)
    app_version   = Column(String(32), nullable=True)
    locale        = Column(String(32), nullable=True)
    timezone      = Column(String(64), nullable=True)
    carrier       = Column(String(128), nullable=True)
    screen_width  = Column(Integer, nullable=True)
    screen_height = Column(Integer, nullable=True)
    push_token    = Column(String(512), nullable=True)
    last_seen     = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    created_at    = Column(DateTime(timezone=True), server_default=func.now())
