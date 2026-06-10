#!/usr/bin/env bash
# Build a single-file context pack for a session: global context + role +
# agent memory + the task file. Output goes to context-packs/ (gitignored).
# Reads tracked files; writes only inside context-packs/.
# Usage: generate-context-pack.sh TASK-0001 [claude|codex|auditor]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT_DIR="$REPO_ROOT/context-packs"

if [ $# -lt 1 ]; then
  echo "Usage: $(basename "$0") TASK-XXXX [claude|codex|auditor]"
  exit 1
fi

task_id="$1"
agent="${2:-claude}"

task_file="$(find "$REPO_ROOT/memory/tasks" -maxdepth 1 -name "${task_id}*" -type f | head -1)"
if [ -z "$task_file" ]; then
  echo "No task file matching '${task_id}*' in memory/tasks/."
  exit 1
fi

case "$agent" in
  claude)  role="$REPO_ROOT/agents/claude/ROLE.md";  mem="$REPO_ROOT/memory/agents/CLAUDE_MEMORY.md" ;;
  codex)   role="$REPO_ROOT/agents/codex/ROLE.md";   mem="$REPO_ROOT/memory/agents/CODEX_MEMORY.md" ;;
  auditor) role="$REPO_ROOT/agents/auditor/ROLE.md"; mem="$REPO_ROOT/memory/agents/AUDITOR_MEMORY.md" ;;
  *) echo "Unknown agent '$agent'"; exit 1 ;;
esac

mkdir -p "$OUT_DIR"
out="$OUT_DIR/${task_id}-${agent}.context-pack.md"

{
  echo "# Context Pack — ${task_id} / ${agent}"
  echo "_Generated $(date +%Y-%m-%d) — gitignored; do not commit._"
  for f in "$REPO_ROOT/memory/global/PROJECT_CONTEXT.md" "$role" "$mem" "$task_file"; do
    echo ""
    echo "---"
    echo ""
    echo "<!-- SOURCE: ${f#$REPO_ROOT/} -->"
    cat "$f"
  done
} > "$out"

echo "Wrote ${out#$REPO_ROOT/}"
echo "Paste or load this single file to start a session with full context."
