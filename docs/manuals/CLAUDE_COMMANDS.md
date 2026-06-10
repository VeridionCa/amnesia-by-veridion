# Claude Code — Command Guide (for this framework)

Generic reference for using Claude Code as an executor or auditor in
Amnesia by Veridion. Nothing here is specific to any real project.

## Session start

```bash
cd /path/to/your-project
scripts/launch/launch-claude-docs-only.sh     # docs-only mode
scripts/launch/launch-claude-feature.sh TASK-0001   # feature mode with a task
```

The launcher prints the safety rules and the context files to load, then
starts `claude` if installed.

## First prompt pattern

Paste (or let the launcher show you) a session opener like:

```
You are the Executor role. Read, in order:
1. memory/global/PROJECT_CONTEXT.md
2. agents/claude/ROLE.md
3. memory/agents/CLAUDE_MEMORY.md
4. memory/tasks/TASK-0001-your-task.md
Work only within the contract's allowed paths.
Do not commit, push, or run scripts without my approval.
Append to the execution log as you work.
```

## Useful in-session habits

| Goal | Practice |
|---|---|
| Keep scope honest | Re-read the contract's "Allowed paths" before each edit |
| Survive interruption | Append to `EXECUTION_LOG` after every meaningful step |
| End of session | Write/refresh `HANDOFF.md`, update task `Status:` |
| Lessons learned | Add dated entries to `memory/agents/CLAUDE_MEMORY.md` |

## Hard limits (mirror of the role file)

- No `git commit` / `git push` without explicit human approval in-session.
- No file deletion without approval.
- No network calls to real systems; `example.com` placeholders only in docs.
- Never read or quote `memory/private/` contents into tracked files.
