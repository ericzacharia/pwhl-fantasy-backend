#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== PWHL Fantasy Backend ==="

# Start PostgreSQL if not running
if ! brew services list | grep postgresql@14 | grep -q started; then
    echo "Starting PostgreSQL..."
    brew services start postgresql@14
    sleep 2
fi

# Create database if it doesn't exist
/opt/homebrew/opt/postgresql@14/bin/createdb pwhl_fantasy 2>/dev/null || true
echo "Database: pwhl_fantasy"

# Activate venv
cd "$BACKEND_DIR"
source venv/bin/activate

# Run migrations
echo "Running migrations..."
alembic upgrade head

# Start server
echo "Starting FastAPI server on http://localhost:8000"
echo "API docs: http://localhost:8000/docs"
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
