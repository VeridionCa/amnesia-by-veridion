# Codex — Command Guide (for this framework)

Generic reference for using Codex CLI as an executor or auditor in
Amnesia by Veridion. Nothing here is specific to any real project.

## Session start

```bash
cd /path/to/your-project
scripts/launch/launch-codex-feature.sh TASK-0001
```

The launcher prints the safety rules and the context files to load, then
starts `codex` if installed.

## First prompt pattern

```
You are the Executor role. Read, in order:
1. memory/global/PROJECT_CONTEXT.md
2. agents/codex/ROLE.md
3. memory/agents/CODEX_MEMORY.md
4. memory/tasks/TASK-0001-your-task.md
Work only within the contract's allowed paths.
Do not commit, push, or run scripts without my approval.
Append to the execution log as you work.
```

## Repository instructions file

If your Codex setup reads a repository instructions file (for example
`AGENTS.md` at the repo root), point it at the same startup sequence so both
models load identical context. Keeping Claude and Codex on the same memory
files is what makes handoffs between them lossless.

## Cross-review duty

When Codex audits Claude's work (or vice versa), it must:

1. Read the task contract first.
2. Read the executor's self-audit.
3. Verify each PASS claim against the actual files — never trust the claim.
4. Write its verdict in the audit file under "Cross-review".

## Hard limits (mirror of the role file)

- No `git commit` / `git push` without explicit human approval in-session.
- No file deletion without approval.
- No network calls to real systems; `example.com` placeholders only in docs.
- Never read or quote `memory/private/` contents into tracked files.
