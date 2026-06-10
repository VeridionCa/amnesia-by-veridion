#!/usr/bin/env bash
# Append a dated entry to an agent memory file. Append-only: never edits
# or removes existing content. Refuses to write into memory/private/.
# Usage: update-memory.sh <claude|codex|auditor> "lesson or note text"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if [ $# -lt 2 ]; then
  echo "Usage: $(basename "$0") <claude|codex|auditor> \"note text\""
  exit 1
fi

agent="$1"; shift
note="$*"

case "$agent" in
  claude)  file="$REPO_ROOT/memory/agents/CLAUDE_MEMORY.md" ;;
  codex)   file="$REPO_ROOT/memory/agents/CODEX_MEMORY.md" ;;
  auditor) file="$REPO_ROOT/memory/agents/AUDITOR_MEMORY.md" ;;
  *) echo "Unknown agent '$agent' (expected claude|codex|auditor)"; exit 1 ;;
esac

if [ ! -f "$file" ]; then
  echo "Memory file not found: $file"
  exit 1
fi

today="$(date +%Y-%m-%d)"
{
  echo ""
  echo "### ${today} — note"
  echo "${note}"
} >> "$file"

echo "Appended a dated entry to ${file#$REPO_ROOT/}."
echo "Reminder: no secrets or real system identifiers in memory files."
