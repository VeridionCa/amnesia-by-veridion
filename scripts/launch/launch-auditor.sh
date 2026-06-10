#!/usr/bin/env bash
# Read-only session starter: Auditor role (Claude or Codex).
# Usage: launch-auditor.sh [TASK-ID]
# Modifies nothing; prints context + safety rules; opens whichever
# agent CLI is installed (prefers the one you pick).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TASK_ID="${1:-<none selected>}"

cat <<'BANNER'
==============================================================
  AMNESIA BY VERIDION — AUDITOR mode (cross-review)
==============================================================
SAFETY RULES (audit workflow):
  1. READ-ONLY over the work under review — never modify it.
  2. Verify every PASS claim against the actual files.
  3. Findings need file/line evidence; verdicts without
     evidence are invalid.
  4. Defensive review only; no testing against real systems.
  5. Output: a Cross-review section in the task's audit file.
BANNER

echo
echo "TASK UNDER REVIEW: ${TASK_ID}"
echo
echo "CONTEXT TO LOAD (in order):"
echo "  1. memory/global/PROJECT_CONTEXT.md"
echo "  2. agents/auditor/ROLE.md"
echo "  3. memory/agents/AUDITOR_MEMORY.md"
echo "  4. workflows/audit/WORKFLOW.md"
echo "  5. memory/tasks/${TASK_ID}* (contract, log, self-audit)"
echo

have_claude=0; have_codex=0
command -v claude >/dev/null 2>&1 && have_claude=1
command -v codex  >/dev/null 2>&1 && have_codex=1

if [ "$have_claude" -eq 1 ] && [ "$have_codex" -eq 1 ]; then
  echo "Both agent CLIs found. Tip: pick the model that did NOT do the work."
  printf "Start which agent? [claude/codex/none]: "
  read -r choice
  case "$choice" in
    claude) cd "$REPO_ROOT"; exec claude ;;
    codex)  cd "$REPO_ROOT"; exec codex ;;
    *)      echo "Not starting an agent. (Nothing was modified.)" ;;
  esac
elif [ "$have_claude" -eq 1 ]; then
  echo "Starting Claude Code in: $REPO_ROOT"
  cd "$REPO_ROOT"; exec claude
elif [ "$have_codex" -eq 1 ]; then
  echo "Starting Codex in: $REPO_ROOT"
  cd "$REPO_ROOT"; exec codex
else
  echo "No agent CLI (claude/codex) found on this machine."
  echo "Install one first, then re-run this launcher."
  echo "(Nothing was modified — this launcher is read-only.)"
fi
