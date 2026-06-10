#!/usr/bin/env bash
# Interactive menu over the read-only launchers.
# Modifies nothing, commits nothing, pushes nothing, connects to no servers.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cat <<'BANNER'
==============================================================
  AMNESIA BY VERIDION — Launch Menu (read-only)
==============================================================
  1) Claude — docs-only mode
  2) Claude — feature-build mode
  3) Codex  — feature-build mode
  4) Auditor — cross-review mode
  q) Quit
==============================================================
BANNER

printf "Select: "
read -r sel

ask_task() {
  printf "Task ID (e.g. TASK-0001, empty for none): "
  read -r task
}

case "$sel" in
  1) exec "$SCRIPT_DIR/launch-claude-docs-only.sh" ;;
  2) ask_task; exec "$SCRIPT_DIR/launch-claude-feature.sh" ${task:+"$task"} ;;
  3) ask_task; exec "$SCRIPT_DIR/launch-codex-feature.sh" ${task:+"$task"} ;;
  4) ask_task; exec "$SCRIPT_DIR/launch-auditor.sh" ${task:+"$task"} ;;
  q|Q) echo "Bye. (Nothing was modified.)" ;;
  *) echo "Unknown selection. (Nothing was modified.)" ;;
esac
