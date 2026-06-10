#!/usr/bin/env bash
# Read-only session starter: Claude Code, feature-build mode.
# Usage: launch-claude-feature.sh [TASK-ID]
# Modifies nothing; prints context + safety rules; opens `claude` if installed.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TASK_ID="${1:-<none selected>}"

cat <<'BANNER'
==============================================================
  AI TEAM MEMORY CORE — Claude Code / FEATURE-BUILD mode
==============================================================
SAFETY RULES (feature-build workflow):
  1. Work ONLY within the task contract's allowed paths.
  2. New files count as scope — don't create unlisted files.
  3. No git commit/push, deletion, or side-effect scripts
     without explicit human approval in this session.
  4. No contact with real systems. Placeholders only.
  5. Verify every done-criterion; log evidence as you go.
BANNER

echo
echo "SELECTED TASK: ${TASK_ID}"
if [ "${TASK_ID}" != "<none selected>" ]; then
  found="$(find "$REPO_ROOT/memory/tasks" -maxdepth 1 -name "${TASK_ID}*" -type f 2>/dev/null || true)"
  if [ -n "$found" ]; then
    echo "Task file: ${found#$REPO_ROOT/}"
  else
    echo "WARNING: no file matching '${TASK_ID}*' in memory/tasks/ — create one first:"
    echo "  scripts/memory/create-task.sh \"short-name\""
  fi
fi
echo
echo "CONTEXT TO LOAD (in order):"
echo "  1. memory/global/PROJECT_CONTEXT.md"
echo "  2. agents/claude/ROLE.md"
echo "  3. memory/agents/CLAUDE_MEMORY.md"
echo "  4. workflows/feature-build/WORKFLOW.md"
echo "  5. memory/tasks/${TASK_ID}*"
echo

if command -v claude >/dev/null 2>&1; then
  echo "Starting Claude Code in: $REPO_ROOT"
  cd "$REPO_ROOT"
  exec claude
else
  echo "Claude Code CLI not found on this machine."
  echo "Install it first, then re-run this launcher."
  echo "(Nothing was modified — this launcher is read-only.)"
fi
