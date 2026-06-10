# Workflow: Refactor

For behavior-preserving restructures: renames, file moves, consolidation,
rewording docs for clarity. The defining promise: **nothing observable
changes** except organization and readability.

## Scope rules

- Contract lists both the paths being changed **and** the paths that
  reference them (links, includes, script paths) — a refactor's most common
  failure is a dangling reference.

## Required steps

1. **Contract** with an explicit invariants list: what must behave/read the
   same after the change.
2. **Inventory first** — executor lists every reference to the things being
   moved/renamed (search before touching).
3. **Execute** — change + update all references in the same task.
4. **Verify invariants** — for docs: every relative link still resolves; for
   scripts: same output on a dry run before/after where applicable.
5. **Self-audit** — includes a "references updated" table:
   old path → new path → referencing files updated.
6. **Cross-review** — auditor specifically hunts dangling references.
7. **Human gate** before commit.

## Hard rule

Refactor tasks must not smuggle in behavior changes. If a bug or improvement
is found mid-refactor: log it, leave it, open a new task.
