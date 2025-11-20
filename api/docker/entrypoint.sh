#!/bin/sh
set -e

echo "======================================"
echo "  API - Starting"
echo "======================================"
echo ""

wait_for_db() {
  echo "Waiting for database at ${DB_HOST}:${DB_PORT}..."
  
  max_attempts=30
  attempt=0
  
  while [ $attempt -lt $max_attempts ]; do
    if nc -z ${DB_HOST} ${DB_PORT} 2>/dev/null; then
      echo "✅ Database is ready!"
      return 0
    fi
    
    attempt=$((attempt + 1))
    echo "  Attempt $attempt/$max_attempts - Database not ready yet..."
    sleep 2
  done
  
  echo "❌ Database connection timeout"
  exit 1
}

wait_for_db

echo ""
echo "Running database migrations..."
npm run migrate

echo ""
echo "======================================"
echo "  Starting application server"
echo "======================================"
echo ""

exec "$@"
