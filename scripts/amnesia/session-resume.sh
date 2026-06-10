#!/usr/bin/env bash
# Amnesia Session Recorder — generate a resume prompt for the next AI session.
# Prints the prompt to stdout and writes RESUME_PROMPT.md in the session dir.
# Usage: session-resume.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CURRENT_FILE="$REPO_ROOT/.amnesia/current-session"

cd "$REPO_ROOT"

if [ ! -s "$CURRENT_FILE" ]; then
  echo "No active session. Start one with: scripts/amnesia/session-start.sh --task \"...\""
  exit 1
fi
SESSION_DIR="$(cat "$CURRENT_FILE")"
CONTEXT="$SESSION_DIR/SESSION_CONTEXT.md"
if [ ! -f "$CONTEXT" ]; then
  echo "Session context file missing: $CONTEXT"
  exit 1
fi

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
TASK="$(grep -m1 '^\- \*\*Task:\*\*' "$CONTEXT" | sed 's/^- \*\*Task:\*\* //')"
BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '(no commits yet)')"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || echo '(no commits yet)')"

# Extract a markdown section body (between "## <name>" and the next "## ").
section() {
  awk -v sec="## $1" '
    $0 == sec {grab=1; next}
    grab && /^## / {exit}
    grab {print}
  ' "$CONTEXT"
}

RESUME="$SESSION_DIR/RESUME_PROMPT.md"
{
  echo "# Resume Prompt — generated $STAMP (UTC)"
  echo
  echo "You are resuming an interrupted working session. Load this context,"
  echo "verify it against the actual repository state, then continue."
  echo
  echo "## Task"
  echo
  echo "${TASK:-'(unknown task)'}"
  echo
  echo "## Current repository state"
  echo
  echo "- Branch: $BRANCH"
  echo "- HEAD: $HEAD_SHA"
  echo
  echo "### Changed files (uncommitted)"
  echo '```'
  git diff --name-only || true
  echo '```'
  echo
  echo "### Status"
  echo '```'
  git status -sb
  echo '```'
  echo
  echo "## Latest session log entries"
  echo
  section "Session log" | tail -5
  echo
  echo "## Risks recorded"
  section "Risks"
  echo "## Next actions recorded"
  section "Next actions"
  echo
  echo "## Instructions for the resuming AI session"
  echo
  echo "1. Read the full session context: ${CONTEXT#$REPO_ROOT/}"
  echo "2. Verify the branch and HEAD above match \`git status -sb\` before editing."
  echo "3. Continue from the first incomplete next-action. Do not redo finished work."
  echo "4. Stay within the task scope stated above; ask the human before expanding it."
  echo "5. Do not commit, push, or delete without explicit human approval."
  echo "6. Save progress as you go: scripts/amnesia/session-save.sh --note \"...\""
} > "$RESUME"

cat "$RESUME"
echo
echo "(also written to ${RESUME#$REPO_ROOT/})"
