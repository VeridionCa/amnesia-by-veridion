# Workflow: Feature-Build

For adding new functionality — scripts, templates, structural additions, or
(in adopting projects) application code.

## Scope rules

- Allowed paths are exactly those in the contract — feature-build contracts
  must list them file-by-file or by narrow directory.
- New files count as scope: creating a file not implied by the contract is a
  scope violation.

## Required steps

1. **Contract** with observable done criteria and a verification command or
   procedure per criterion. Human approves.
2. **Design note** — for non-trivial features the architect adds a short
   "approach" section to the contract (or an ADR if the choice is durable).
3. **Execute** — executor builds, logging each step. New scripts must follow
   the safety rules of their folder (launchers read-only, audits read-only).
4. **Verify** — run each criterion's verification; paste real output (scrubbed
   of anything private) into the execution log.
5. **Self-audit** — full `templates/SELF_AUDIT.md`.
6. **Cross-review (mandatory)** — auditor role, different model preferred.
7. **Human gate** — diff + report reviewed before commit.

## Extra checks

- `scripts/audit/check-git-status.sh` — no stray files.
- `scripts/audit/check-large-files.sh` — no accidental binaries.
- `scripts/audit/check-secrets-basic.sh` — clean or explained.

## Failure handling

A criterion that cannot be met → status `rejected` or a handoff explaining
the blocker. Never silently narrow the goal to fit what was achieved.
