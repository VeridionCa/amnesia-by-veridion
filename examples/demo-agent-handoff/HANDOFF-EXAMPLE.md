# Handoff — TASK-0002

> **Fictional example** of `templates/HANDOFF.md` filled in. All details
> invented.

**Task:** TASK-0002 — Restructure `your-project` docs into guides/ and reference/
**From:** Claude Code (executor)
**To:** any executor (Codex expected)
**Date:** 2026-06-03 16:40
**Task status set to:** in-progress

## Where things stand

The new `guides/` and `reference/` folders exist and 6 of 10 pages are moved
with their links updated. The remaining 4 pages (`api-overview.md`,
`cli-usage.md`, `glossary.md`, `changelog-policy.md`) are still in the old
flat layout. No content was rewritten — moves and link updates only, per the
refactor workflow invariant.

## Done criteria progress

| # | Criterion | State |
|---|---|---|
| 1 | All 10 pages relocated | partial — 6/10 done (see log 14:55 entry for list) |
| 2 | All internal links resolve | partial — done for moved pages only |
| 3 | Old paths removed | not started (deletion needs human approval — see open question) |
| 4 | No content changes | done so far — moves only |

## Exact next step

Move `site/docs/api-overview.md` → `site/docs/reference/api-overview.md`,
then update the 3 files that link to it (listed in the execution log,
15:20 entry).

## Warnings and context

- DECISION (log 14:30): `glossary.md` goes to `reference/`, not `guides/` —
  the human confirmed this in-session; don't re-litigate.
- The link checker idea in the log is a *future task*, not part of this one.
  Don't build it.

## Files touched so far

- `site/docs/guides/...` — 4 pages moved + links updated
- `site/docs/reference/...` — 2 pages moved + links updated
- `memory/tasks/TASK-0002-docs-restructure.md` — log entries

## Open questions for the human

- Criterion 3 requires deleting the old page locations. Deletion is gated:
  request approval before removing anything.
