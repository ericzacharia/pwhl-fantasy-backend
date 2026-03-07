from pydantic_settings import BaseSettings
import os


class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql://eric@localhost:5432/pwhl_fantasy"
    ASYNC_DATABASE_URL: str = "postgresql+asyncpg://eric@localhost:5432/pwhl_fantasy"
    SECRET_KEY: str = "pwhl-fantasy-super-secret-key-change-in-production-2024"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    REFRESH_TOKEN_EXPIRE_DAYS: int = 30
    APP_NAME: str = "PWHL Fantasy"
    APP_VERSION: str = "1.0.0"

    model_config = {"env_file": os.path.join(os.path.dirname(__file__), "..", ".env"), "extra": "ignore"}


settings = Settings()
