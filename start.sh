#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PORT="${PORT:-8765}"
DOCS="$ROOT/docs"
URL="http://127.0.0.1:${PORT}/"

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: need python3 for local preview server" >&2
  exit 1
fi

free_port() {
  local port=$1
  local pids=""

  if command -v lsof >/dev/null 2>&1; then
    pids=$(lsof -ti ":${port}" 2>/dev/null || true)
  elif command -v fuser >/dev/null 2>&1; then
    fuser -k "${port}/tcp" 2>/dev/null || true
    sleep 0.3
    return
  fi

  if [[ -n "$pids" ]]; then
    kill -9 $pids 2>/dev/null || true
    sleep 0.3
  fi
}

# 本地预览：直接打开 http://127.0.0.1:${PORT}/CourseOutline.html

free_port "$PORT"

echo "=========================================="
echo "  Course Outline"
echo "  ${URL}"
echo "=========================================="
echo ""
echo "1. Keep this terminal running (Ctrl+C to stop)."
echo "2. Cursor Remote-SSH: Ports → ${PORT} → Open in Browser"
echo "3. Local: http://localhost:${PORT}/CourseOutline.html"
echo ""

exec python3 -m http.server "$PORT" --bind 127.0.0.1 --directory "$DOCS"
