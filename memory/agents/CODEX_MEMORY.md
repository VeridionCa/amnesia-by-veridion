# Codex — Agent Memory

> Persistent notes for sessions where Codex fills a role.
> Append dated entries; mark stale ones `[ARCHIVED]`. No private data.

## Standing notes

### 2026-06-10 — Startup sequence
Always load, in order: `memory/global/PROJECT_CONTEXT.md` →
`agents/codex/ROLE.md` → this file → the active task file.

### 2026-06-10 — Shared memory discipline
Claude and Codex read the same global context and task files. When taking
over from Claude (or handing off), trust the files, not assumptions about
what the other model "probably did" — verify claims against the diff.

## Lessons learned

### 2026-06-10 — Example entry (fictional)
On a demo cross-review, a self-audit claimed PASS on a done-criterion that
the file did not satisfy. Verdict: verify every PASS against the actual file;
never rubber-stamp.

## Preferences observed

- The operator wants approval requests to include the exact file list and a
  rollback path before any commit.
