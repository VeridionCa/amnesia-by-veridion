#!/usr/bin/env bash
# Read-only: show what git sees — modified, staged, and untracked files.
# Never adds, commits, restores, or deletes anything.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$REPO_ROOT"

echo "== check-git-status (read-only) =="
echo "Repository: $REPO_ROOT"
echo

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository — nothing to check."
  exit 0
fi

echo "-- Branch --"
if git rev-parse --verify HEAD >/dev/null 2>&1; then
  git rev-parse --abbrev-ref HEAD
else
  echo "WARN: repository has no commits yet — skipping branch/commit checks."
fi
echo
echo "-- Working tree (short status) --"
status_output="$(git status --short)"
if [ -z "$status_output" ]; then
  echo "(clean)"
else
  echo "$status_output"
fi
echo
echo "-- Untracked files --"
untracked="$(git ls-files --others --exclude-standard)"
if [ -z "$untracked" ]; then
  echo "(none)"
else
  echo "$untracked"
fi
echo
echo "Review: every path above must be inside your task's allowed paths."
echo "This script changed nothing."
