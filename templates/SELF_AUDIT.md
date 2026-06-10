# Self-Audit — TASK-XXXX

> Filled by the executor after the work, before cross-review.
> Re-read the contract first. Claims require evidence; no evidence = FAIL.

**Task:** TASK-XXXX — <title>
**Executor:** <agent / model>
**Date:** YYYY-MM-DD

## Done criteria

| # | Criterion | Verdict | Evidence |
|---|---|---|---|
| 1 | <from contract> | PASS / FAIL / N-A | <file:line, command output, or how to check> |

## Scope check

- Command run: `scripts/audit/check-git-status.sh`
- Changed paths: <list>
- All within allowed paths? YES / NO — <explain any NO>

## Public-safety check

- Command run: `scripts/audit/check-secrets-basic.sh`
- Hits: <count>
- Every hit reviewed and explained? YES / NO — <notes; categories only, no values>

## Deviations from contract

<Anything done differently than written, and why. "None" if none.>

## Known gaps

<What this work does NOT cover that a reviewer might assume it does.>

## Overall verdict

**PASS / FAIL** — <one sentence>

---

## Cross-review (filled by Auditor — different agent)

- **Reviewer:** <agent / model>
- **Date:** YYYY-MM-DD
- **Claims verified against files:** YES / NO
- **Findings:** <file/line evidence, severity>
- **Verdict:** APPROVE / APPROVE-WITH-NOTES / REJECT
