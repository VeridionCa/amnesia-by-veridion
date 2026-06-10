#!/usr/bin/env bash
# Read-only basic secret/keyword tripwire.
# REDACTS VALUES: prints only file path, line number, and keyword CATEGORY.
# Never prints the matched line content. Never modifies anything.
# This is a tripwire, not a guarantee — every hit needs manual review,
# and a clean run does not prove the tree is safe to publish.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCAN_DIR="${1:-$REPO_ROOT}"

echo "== check-secrets-basic (read-only, values redacted) =="
echo "Scanning: $SCAN_DIR"
echo "Output format: <category>  <file>:<line>"
echo

total=0

scan_category() {
  category="$1"
  pattern="$2"
  hits="$(grep -rInE --binary-files=without-match \
            --exclude-dir=.git \
            -e "$pattern" "$SCAN_DIR" 2>/dev/null | cut -d: -f1,2 || true)"
  if [ -n "$hits" ]; then
    while IFS= read -r loc; do
      printf '  %-22s %s\n' "$category" "$loc"
      total=$((total + 1))
    done <<EOF
$hits
EOF
  fi
}

scan_category "password-like"   '(password|passwd|pwd)[[:space:]]*[:=]'
scan_category "token-like"      '(token|bearer|api[_-]?key|apikey)[[:space:]]*[:=]'
scan_category "secret-like"     'secret[[:space:]]*[:=]'
scan_category "private-key"     'BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY'
scan_category "ssh-key-material" 'ssh-(rsa|ed25519|dss) AAAA'
scan_category "aws-key-id"      'AKIA[0-9A-Z]{16}'
scan_category "credential-word" 'credential'
scan_category "env-assignment"  '^[A-Z_]{4,}=[^[:space:]]{8,}'

echo
if [ "$total" -eq 0 ]; then
  echo "No keyword hits. Reminder: this does NOT guarantee the tree is clean."
else
  echo "Total hits: $total — review EACH location manually."
  echo "Values were intentionally not printed."
fi
echo "This script changed nothing."
