#!/usr/bin/env bash
# Read-only: list files above a size threshold and common binary/archive
# types that usually don't belong in a public docs repo.
# Never deletes or modifies anything.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
THRESHOLD_KB="${1:-500}"

echo "== check-large-files (read-only) =="
echo "Scanning: $REPO_ROOT (threshold: ${THRESHOLD_KB} KB)"
echo

echo "-- Files larger than ${THRESHOLD_KB} KB --"
large="$(find "$REPO_ROOT" -type f -size "+${THRESHOLD_KB}k" \
  -not -path "*/.git/*" 2>/dev/null || true)"
if [ -z "$large" ]; then
  echo "(none)"
else
  # shellcheck disable=SC2086
  du -k $large | sort -rn | awk '{printf "  %6d KB  %s\n", $1, $2}'
fi
echo

echo "-- Binary/archive types (any size) --"
types="$(find "$REPO_ROOT" -type f \( \
  -name '*.zip' -o -name '*.tar.gz' -o -name '*.tgz' -o -name '*.7z' \
  -o -name '*.sql' -o -name '*.db' -o -name '*.sqlite' \
  -o -name '*.exe' -o -name '*.dll' -o -name '*.so' \
  -o -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.gif' \
  -o -name '*.mp4' -o -name '*.mov' \
  \) -not -path "*/.git/*" 2>/dev/null || true)"
if [ -z "$types" ]; then
  echo "(none)"
else
  echo "$types"
fi
echo
echo "Review each finding manually. This script changed nothing."
