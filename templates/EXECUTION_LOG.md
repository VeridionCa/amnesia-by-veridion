# Execution Log — TASK-XXXX

> Append-only. Write entries **during** the work, after each meaningful step.
> Never rewrite or delete an entry; correct with a new entry.
> Scrub anything private before pasting command output.

**Task:** TASK-XXXX — <title>
**Executor:** <agent / model>
**Started:** YYYY-MM-DD HH:MM

---

## Entries

```
YYYY-MM-DD HH:MM — SESSION START. Loaded context: PROJECT_CONTEXT, ROLE,
                   agent memory, task file.
YYYY-MM-DD HH:MM — <step taken, files touched, result>
YYYY-MM-DD HH:MM — DECISION: <small in-task decision and why>
YYYY-MM-DD HH:MM — BLOCKER: <what and why> → <asked human / wrote handoff>
YYYY-MM-DD HH:MM — APPROVAL: human approved <exact action>. Scope: this
                   action only.
YYYY-MM-DD HH:MM — SESSION END. State: <where things stand>. Next: <step>.
```

## Entry types

| Tag | Use |
|---|---|
| (none) | Normal work step |
| `DECISION:` | In-scope judgment call worth remembering |
| `BLOCKER:` | Progress stopped; what's needed |
| `APPROVAL:` | Human approval/rejection, quoted precisely |
| `SESSION START/END` | Session boundaries — make resumption trivial |
