#!/usr/bin/env bash
# Read-only pre-publication audit: runs the full battery before any
# publish/release/PR. Modifies nothing; deletes nothing; redacts values.
# A passing run is necessary but NOT sufficient — a human must still
# review the flagged lines and skim new files.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "############################################################"
echo "#  PRE-PUBLIC AUDIT (read-only)                            #"
echo "############################################################"
echo

echo "### 1/3 git status ###"
"$SCRIPT_DIR/check-git-status.sh"
echo

echo "### 2/3 large files ###"
"$SCRIPT_DIR/check-large-files.sh"
echo

echo "### 3/3 secret/keyword tripwire (values redacted) ###"
"$SCRIPT_DIR/check-secrets-basic.sh"
echo

cat <<'CHECKLIST'
############################################################
MANUAL CHECKLIST — the scripts cannot do these for you:
  [ ] Every keyword hit above inspected and explained.
  [ ] No real domains/hosts/usernames/paths — placeholders
      only (example.com, your-project, your-server).
  [ ] memory/private/ contains nothing tracked (.gitkeep only).
  [ ] Commit messages and branch names are also clean.
  [ ] New files skimmed end-to-end by a human.
Publication requires explicit human approval.
This audit changed nothing.
############################################################
CHECKLIST
