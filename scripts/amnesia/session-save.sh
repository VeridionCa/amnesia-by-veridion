#!/usr/bin/env bash
# Amnesia Session Recorder — autosave a snapshot of the active session.
# Appends a timestamped note and captures fresh operational git state.
# Usage: session-save.sh --note "What just happened"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CURRENT_FILE="$REPO_ROOT/.amnesia/current-session"

NOTE="(no note)"
while [ $# -gt 0 ]; do
  case "$1" in
    --note) NOTE="${2:-$NOTE}"; shift 2 ;;
    *) echo "Unknown argument: $1"; echo "Usage: $(basename "$0") --note \"text\""; exit 1 ;;
  esac
done

cd "$REPO_ROOT"

if [ ! -s "$CURRENT_FILE" ]; then
  echo "No active session. Start one with: scripts/amnesia/session-start.sh --task \"...\""
  exit 1
fi
SESSION_DIR="$(cat "$CURRENT_FILE")"
if [ ! -d "$SESSION_DIR" ]; then
  echo "Active session directory missing: $SESSION_DIR"
  exit 1
fi

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '(no commits yet)')"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || echo '(no commits yet)')"
SNAPSHOT="$SESSION_DIR/snapshots/$STAMP.md"

{
  echo "# Snapshot $STAMP"
  echo
  echo "- **Note:** $NOTE"
  echo "- **Branch:** $BRANCH"
  echo "- **HEAD:** $HEAD_SHA"
  echo
  echo "## Git status"
  echo '```'
  git status -sb
  echo '```'
  echo
  echo "## Diff stat"
  echo '```'
  git diff --stat || true
  echo '```'
  echo
  echo "## Changed files"
  echo '```'
  git diff --name-only || true
  echo '```'
} > "$SNAPSHOT"

{
  echo "- $STAMP — SAVE — $NOTE (branch: $BRANCH, HEAD: $HEAD_SHA)"
} >> "$SESSION_DIR/SESSION_CONTEXT.md"

echo "Snapshot saved: ${SNAPSHOT#$REPO_ROOT/}"
