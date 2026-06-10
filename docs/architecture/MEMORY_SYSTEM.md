# Memory System

## Principles

1. **Files are the only memory.** Chat history is treated as already lost.
2. **Read before write.** Sessions start by loading the context pack.
3. **Write as you go.** Memory updates happen during work, not at the end.
4. **Append over edit** for records (decisions, logs); **edit in place** for
   living state (context, task status), always noting the update date.
5. **Private memory never ships.** `memory/private/` is gitignored.

## Layout

```
memory/
├── global/
│   └── PROJECT_CONTEXT.md      # the one file every session must read
├── agents/
│   ├── CLAUDE_MEMORY.md        # lessons, preferences, recurring pitfalls
│   ├── CODEX_MEMORY.md
│   └── AUDITOR_MEMORY.md
├── decisions/
│   └── ADR-0001-....md         # append-only decision records
├── tasks/
│   ├── TASK_TEMPLATE.md
│   └── TASK-XXXX-<slug>.md     # one file per task, created from template
└── private/                    # gitignored; local-only sensitive notes
```

## What goes where

| Information | Location |
|---|---|
| What the project is, goals, constraints | `global/PROJECT_CONTEXT.md` |
| "Last time I broke X by doing Y" | the agent's own memory file |
| "We chose approach A over B because…" | a new ADR in `decisions/` |
| Current work, scope, status | the task file in `tasks/` |
| Anything sensitive (real hostnames, keys, client names) | `private/` or outside the repo |

## Memory hygiene rules

- One fact per section; date every update (`Updated: YYYY-MM-DD`).
- No secrets, credentials, or personal data in any tracked memory file —
  use placeholders (`example.com`, `your-server`) even in lessons learned.
- Stale entries are marked `[ARCHIVED]`, not deleted, so history stays
  reviewable.
- Memory files are subject to the same pre-publish audit as everything else.

## Context packs

A context pack is the minimal set of files an agent needs for a session:
global context + its role + its memory + the active task. Generate one with:

```bash
scripts/memory/generate-context-pack.sh TASK-0001
```

The pack is written to `context-packs/` (gitignored) so generated bundles
never pollute the repository.
