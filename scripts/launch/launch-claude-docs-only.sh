#!/usr/bin/env bash
# Read-only session starter: Claude Code, docs-only mode.
# This script modifies nothing, commits nothing, pushes nothing,
# and connects to no servers. It prints context + safety rules,
# then opens `claude` if installed.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

cat <<'BANNER'
==============================================================
  AMNESIA BY VERIDION — Claude Code / DOCS-ONLY mode
==============================================================
SAFETY RULES (docs-only workflow):
  1. Only docs/, memory/ (not private of others), templates/,
     examples/, and top-level *.md may change.
  2. No scripts, no executables, no .gitignore/LICENSE changes.
  3. No git commit/push, no deletions — human approval required.
  4. Placeholders only: example.com, your-project, your-server.
  5. Log as you go in the active task's execution log.
BANNER

echo
echo "CONTEXT TO LOAD (in order):"
echo "  1. memory/global/PROJECT_CONTEXT.md"
echo "  2. agents/claude/ROLE.md"
echo "  3. memory/agents/CLAUDE_MEMORY.md"
echo "  4. workflows/docs-only/WORKFLOW.md"
echo "  5. Your active task file in memory/tasks/"
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
