# Workflow: Docs-Only

The lowest-risk workflow: only documentation, memory, and template files may
change. Default choice when no code or scripts are involved.

## Scope rules

| Allowed | Forbidden |
|---|---|
| `docs/**`, `memory/**` (except others' private), `templates/**`, `examples/**`, top-level `*.md` | `scripts/**`, anything executable, `.gitignore`, `LICENSE` |

## Required steps

1. Contract created and approved (can be lightweight: goal + file list +
   done criteria).
2. Executor edits docs/memory only; logs as it goes.
3. Self-audit: every changed path in scope, dates updated, links resolve
   (relative paths exist), no placeholder left half-filled.
4. `scripts/audit/check-secrets-basic.sh` clean or all hits explained.
5. Human gate before commit.

## Relaxations vs. feature-build

- Cross-review by a second agent is optional (human review suffices).
- No tests to run.

## Typical tasks

- Updating `PROJECT_CONTEXT.md` after a milestone.
- Writing a new runbook or manual.
- Recording lessons in agent memory.
- Drafting an ADR (final approval still required for `memory/decisions/`).
