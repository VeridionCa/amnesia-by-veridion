# Workflow: Audit

A read-only sweep of the repository for hygiene, consistency, and public
safety. Produces findings, not fixes.

## Scope rules

- **Zero modifications** to the audited content. The only files an audit
  task may write are its own findings report and the auditor's memory file.
- Defensive review only: no probing of real systems, no offensive tooling.
  Security examples remain authorized-lab/toy scope.

## Standard audit battery

| Check | Tool | Looks for |
|---|---|---|
| Working-tree state | `scripts/audit/check-git-status.sh` | Uncommitted/untracked surprises |
| Large files | `scripts/audit/check-large-files.sh` | Binaries, archives, dumps |
| Secrets (redacted) | `scripts/audit/check-secrets-basic.sh` | Credential-shaped keywords |
| Placeholder discipline | manual grep + review | Real-looking domains, hosts, names |
| Memory freshness | manual review | Stale `Updated:` dates, missing `[ARCHIVED]` |
| Link integrity | manual review | Dangling relative links in docs |

## Required steps

1. Lightweight contract naming which checks run and over which paths.
2. Run the battery; record every finding with file/line and severity
   (BLOCKER / WARN / NOTE).
3. Findings report from `templates/FINAL_REPORT.md`, leading with blockers.
4. Human decides what becomes follow-up tasks. The audit itself fixes nothing.

## Cadence

Run before every release (mandatory — see `workflows/release/`) and
periodically as a standalone task.
