#!/usr/bin/env bash
# Amnesia Session Recorder — close the active session with a final handoff.
# Usage: session-close.sh --summary "What was accomplished"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CURRENT_FILE="$REPO_ROOT/.amnesia/current-session"

SUMMARY="(no summary provided)"
while [ $# -gt 0 ]; do
  case "$1" in
    --summary) SUMMARY="${2:-$SUMMARY}"; shift 2 ;;
    *) echo "Unknown argument: $1"; echo "Usage: $(basename "$0") --summary \"text\""; exit 1 ;;
  esac
done

cd "$REPO_ROOT"

if [ ! -s "$CURRENT_FILE" ]; then
  echo "No active session to close."
  exit 1
fi
SESSION_DIR="$(cat "$CURRENT_FILE")"
CONTEXT="$SESSION_DIR/SESSION_CONTEXT.md"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '(no commits yet)')"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || echo '(no commits yet)')"

if [ -f "$CONTEXT" ]; then
  echo "- $STAMP — SESSION CLOSE — $SUMMARY" >> "$CONTEXT"
fi

{
  echo "# Final Handoff — $STAMP (UTC)"
  echo
  echo "- **Summary:** $SUMMARY"
  echo "- **Branch at close:** $BRANCH"
  echo "- **HEAD at close:** $HEAD_SHA"
  echo
  echo "## Final git status"
  echo '```'
  git status -sb
  echo '```'
  echo
  echo "## Final diff stat"
  echo '```'
  git diff --stat || true
  echo '```'
  echo
  echo "## Final changed files"
  echo '```'
  git diff --name-only || true
  echo '```'
  echo
  echo "## Continuing later"
  echo
  echo "Start a new session with scripts/amnesia/session-start.sh and point the"
  echo "next AI session at this handoff plus the session context file:"
  echo "${CONTEXT#$REPO_ROOT/}"
} > "$SESSION_DIR/FINAL_HANDOFF.md"

rm -f "$CURRENT_FILE"

echo "Session closed."
echo "Final handoff: ${SESSION_DIR#$REPO_ROOT/}/FINAL_HANDOFF.md"
