#!/usr/bin/env bash
# Amnesia Session Recorder — start a recorded session.
# Captures operational project context only (git state, task, notes).
# It does NOT capture model reasoning, chat history, or hidden context.
# Usage: session-start.sh --task "Short task description"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
AMNESIA_DIR="$REPO_ROOT/.amnesia"
CURRENT_FILE="$AMNESIA_DIR/current-session"

TASK="(no task specified)"
while [ $# -gt 0 ]; do
  case "$1" in
    --task) TASK="${2:-$TASK}"; shift 2 ;;
    *) echo "Unknown argument: $1"; echo "Usage: $(basename "$0") --task \"description\""; exit 1 ;;
  esac
done

cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository — nothing to record."
  exit 1
fi

if [ -s "$CURRENT_FILE" ]; then
  echo "A session is already active: $(cat "$CURRENT_FILE")"
  echo "Close it first with: scripts/amnesia/session-close.sh --summary \"...\""
  exit 1
fi

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
SESSION_DIR="$AMNESIA_DIR/sessions/$STAMP"
mkdir -p "$SESSION_DIR/snapshots"

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '(no commits yet)')"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || echo '(no commits yet)')"

{
  echo "# Session Context"
  echo
  echo "- **Task:** $TASK"
  echo "- **Started:** $STAMP (UTC)"
  echo "- **Repo path:** $REPO_ROOT"
  echo "- **Branch at start:** $BRANCH"
  echo "- **HEAD at start:** $HEAD_SHA"
  echo
  echo "## Git state at start"
  echo
  echo '```'
  git status -sb
  echo '```'
  echo
  echo "### Diff stat"
  echo '```'
  git diff --stat || true
  echo '```'
  echo
  echo "### Changed files"
  echo '```'
  git diff --name-only || true
  echo '```'
  echo
  echo "## Notes"
  echo
  echo "(add free-form notes here, or use session-save.sh --note)"
  echo
  echo "## Risks"
  echo
  echo "(list known risks here)"
  echo
  echo "## Next actions"
  echo
  echo "(list planned next steps here)"
  echo
  echo "## Session log"
  echo
  echo "- $STAMP — SESSION START — task: $TASK"
} > "$SESSION_DIR/SESSION_CONTEXT.md"

printf '%s\n' "$SESSION_DIR" > "$CURRENT_FILE"

echo "Session started: ${SESSION_DIR#$REPO_ROOT/}"
echo "Context file:    ${SESSION_DIR#$REPO_ROOT/}/SESSION_CONTEXT.md"
echo "Autosave with:   scripts/amnesia/session-save.sh --note \"...\""
