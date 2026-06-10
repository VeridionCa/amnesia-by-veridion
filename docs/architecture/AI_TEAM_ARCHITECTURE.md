# AI Team Architecture

## Overview

AI Team Memory Core coordinates multiple AI coding agents around a shared,
file-based memory inside a Git repository. The design goal: **any agent can
crash, time out, or be replaced at any moment, and the next session loses
nothing**, because all state lives in files.

## Components

| Component | Location | Purpose |
|---|---|---|
| Global memory | `memory/global/` | Project context every agent loads first |
| Agent memory | `memory/agents/` | Per-agent persistent notes and lessons |
| Decisions | `memory/decisions/` | Append-only ADRs — the project's long-term judgment |
| Tasks | `memory/tasks/` | Task contracts and their live state |
| Private memory | `memory/private/` | Local-only notes — gitignored, never published |
| Roles | `agents/` | What each agent may and may not do |
| Workflows | `workflows/` | Named procedures: docs-only, feature-build, refactor, audit, release |
| Templates | `templates/` | Contract, log, audit, handoff, report formats |
| Launchers | `scripts/launch/`, `scripts/windows/` | Read-only session starters |
| Audits | `scripts/audit/` | Read-only hygiene and public-safety checks |

## The team

A minimal team has four roles (one human, three agent roles — agents can be
any model; names below are example assignments):

- **Human operator** — owns approval gates, reviews reports, makes final calls.
- **Architect** (e.g., your-agent) — turns requests into task contracts and ADRs.
- **Executor** (e.g., Claude Code or Codex) — does the work within contract scope.
- **Auditor** (e.g., the *other* model) — cross-reviews the executor's output.

Using different models for executor and auditor is deliberate: independent
failure modes make reviews catch more.

## Information flow

```
Human request
   → Architect: TASK_CONTRACT.md (scope, allowed paths, done criteria)
   → Executor: works + writes EXECUTION_LOG.md in real time
   → Executor: SELF_AUDIT.md against the contract
   → Auditor: cross-review, verdict in the audit file
   → HANDOFF.md (if work continues) or FINAL_REPORT.md (if done)
   → Human approval gate → commit
```

## Why files, not a database

- Git gives versioning, diffing, blame, and rollback for free.
- Every agent and every human can read Markdown.
- No service to run, secure, or back up separately.
- The memory is reviewable in a pull request like any other change.

## Trust boundaries

1. **Repo boundary** — nothing private enters tracked files; `memory/private/`
   is the only in-repo location for sensitive notes and is gitignored.
2. **Contract boundary** — agents only touch paths the active contract allows.
3. **Approval boundary** — irreversible actions (commit, push, delete,
   release, anything outward-facing) require recorded human approval.
