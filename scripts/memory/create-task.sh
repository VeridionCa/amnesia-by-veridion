#!/usr/bin/env bash
# Create a new task file in memory/tasks/ from the template.
# Writes exactly ONE new file; never overwrites an existing one.
# Usage: create-task.sh "short-task-name"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TASKS_DIR="$REPO_ROOT/memory/tasks"
TEMPLATE="$TASKS_DIR/TASK_TEMPLATE.md"

if [ $# -lt 1 ] || [ -z "$1" ]; then
  echo "Usage: $(basename "$0") \"short-task-name\""
  exit 1
fi

slug="$(echo "$1" | tr '[:upper:] ' '[:lower:]-' | tr -cd 'a-z0-9-')"
if [ -z "$slug" ]; then
  echo "Could not derive a slug from '$1'."
  exit 1
fi

# Next ID: highest existing TASK-NNNN + 1
last="$(find "$TASKS_DIR" -maxdepth 1 -name 'TASK-[0-9]*' -type f 2>/dev/null \
        | sed -E 's/.*TASK-([0-9]+).*/\1/' | sort -n | tail -1)"
next=$(( ${last:-0} + 1 ))
task_id="$(printf 'TASK-%04d' "$next")"
target="$TASKS_DIR/${task_id}-${slug}.md"

if [ -e "$target" ]; then
  echo "Refusing to overwrite existing file: $target"
  exit 1
fi

today="$(date +%Y-%m-%d)"
sed -e "s/TASK-XXXX/${task_id}/g" \
    -e "s/<short title>/${slug}/" \
    -e "s/YYYY-MM-DD/${today}/" \
    "$TEMPLATE" > "$target"

echo "Created: ${target#$REPO_ROOT/}"
echo "Next: fill in goal, allowed paths, and done criteria,"
echo "then get human approval before any agent starts work."
