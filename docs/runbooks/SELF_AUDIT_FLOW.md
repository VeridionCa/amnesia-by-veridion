# Runbook: Self-Audit Flow

How an executor audits its own work before anyone else sees it.

## When

After the work feels done, before requesting cross-review or human approval.
Self-audit is mandatory for every task, including docs-only ones.

## Procedure

1. **Re-read the contract** — not your memory of it, the actual file.

2. **Create the audit file** from `templates/SELF_AUDIT.md`, next to the task
   or in the location the contract names.

3. **For each done-criterion**, record:
   - `PASS` — with evidence (file path, what to look at);
   - `FAIL` — with what's missing and why;
   - `N/A` — with justification.
   A claim without evidence counts as FAIL.

4. **Scope check** — run, read-only:
   ```bash
   scripts/audit/check-git-status.sh
   ```
   Every changed path must be inside the contract's allowed paths.
   Anything else is a finding, even if harmless.

5. **Public-safety check** (always, even for private repos — habits):
   ```bash
   scripts/audit/check-secrets-basic.sh
   ```
   Review every hit. "It's just documentation" must be verified, not assumed.

6. **Honest verdict** — overall PASS only if every criterion passed and both
   checks are clean. A self-audit that finds problems is a *successful*
   self-audit; fix or report, never hide.

7. Update the task `Status: self-audited` and hand off to the auditor.

## Anti-patterns

- Writing the audit from memory without re-opening files.
- Marking PASS on "should work" — run or read the thing.
- Fixing issues silently after the audit without re-auditing.
- Auditing only the happy path while the contract lists edge cases.
