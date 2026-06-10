# Project Status

> Updated: 2026-06-10

## Current phase

**Phase 2.2 — rebrand to "Amnesia by Veridion", preparing first public release.**

## Current status

Scaffold built, polished, audited, and rebranded. First publication is
pending at `github.com/veridionCA/amnesia-by-veridion` (repo creation and
push gated on human approval). Nothing has been published yet.

The framework was developed under the working name "AI Team Memory Core";
all user-facing naming now reads "Amnesia by Veridion".

## What exists now

| Capability | Where |
|---|---|
| Persistent file-based memory | `memory/` (global, agents, decisions, tasks, gitignored private) |
| Claude executor role | `agents/claude/ROLE.md` |
| Codex executor role | `agents/codex/ROLE.md` |
| Auditor role | `agents/auditor/ROLE.md` |
| Architect role | `agents/architect/ROLE.md` |
| Task contracts | `templates/TASK_CONTRACT.md`, `memory/tasks/TASK_TEMPLATE.md` |
| Handoff templates | `templates/HANDOFF.md` |
| Self-audit templates | `templates/SELF_AUDIT.md` |
| Execution log + final report templates | `templates/EXECUTION_LOG.md`, `templates/FINAL_REPORT.md` |
| Read-only launchers (bash + PowerShell) | `scripts/launch/`, `scripts/windows/` |
| Public-safety audit scripts (read-only, redacting) | `scripts/audit/` |
| Memory helper scripts | `scripts/memory/` |
| Five named workflows | `workflows/` |
| Architecture docs, manuals, runbooks | `docs/` |
| Fictional examples | `examples/` |

## What is not built yet

- Packaged installer.
- Real cross-platform GUI.
- GitHub Actions (CI audit workflow).
- Automated tests beyond shell syntax checks and the audit scripts.
- Public repo extraction (this project still lives inside a parent repository).

## Next safe step

1. Human review of the full scaffold.
2. First commit — **only this project folder**, nothing else from the parent
   repository.
3. Later: extract to a clean public repository following a documented
   extraction guide (planned for v0.5.0 — see `ROADMAP.md`).
