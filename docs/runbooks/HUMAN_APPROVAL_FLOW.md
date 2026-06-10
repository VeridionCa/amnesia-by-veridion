# Runbook: Human Approval Flow

The approval gate is the human's control surface. This runbook defines what
requires approval, how agents request it, and how approval is recorded.

## Actions that always require explicit human approval

| Action | Why |
|---|---|
| `git commit` | Human-reviewed change summary required |
| `git push` / publishing | Affects shared/public state |
| Deleting any file | Irreversible without history |
| Creating or editing a decision record (ADR) | Records are canonical |
| Running any script with side effects | Scripts may modify state |
| Anything touching a system outside the repo | Outside agent authority |
| Releasing a version | Outward-facing |

Approval applies to **one specific action in the current session**. It does
not carry forward to similar actions later.

## How an agent requests approval

In-session, the agent presents:

1. **What** — the exact action (e.g., "commit these 3 files").
2. **Why** — which contract item requires it.
3. **Evidence** — the diff or file list.
4. **Risk** — what could go wrong and the rollback path.

Then it stops and waits. No "I'll proceed unless you object."

## How approval is recorded

The human's "yes" is recorded in the execution log:

```
2026-01-15 14:02 APPROVAL: human approved commit of
  memory/tasks/TASK-0001-demo.md, docs/manuals/PUBLIC_REPO_GUIDE.md
  Scope: this commit only.
```

No log entry → no approval happened → the action is not taken.

## Rejection

A rejection is also logged, with the reason if given. The agent updates the
task status and either fixes the issue or writes a handoff describing the
blocked state. Re-requesting the same approval without changes is not allowed.
