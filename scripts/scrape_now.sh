#!/bin/bash
# Manually trigger a data scrape via the API
TOKEN="${1:-}"
if [ -z "$TOKEN" ]; then
    echo "Usage: $0 <jwt_token>"
    echo "Get a token by logging in first: POST /api/v1/auth/login"
    exit 1
fi
curl -s -X POST http://localhost:8000/api/v1/admin/scrape \
    -H "Authorization: Bearer $TOKEN" | python3 -m json.tool
