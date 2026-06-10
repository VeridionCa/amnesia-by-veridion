# Project Context

> The one file every agent session must read first.
> Updated: 2026-06-10

## What this project is

`your-project` — a fictional demonstration project used to exercise the
AI Team Memory Core framework. Replace this file's contents with your own
project context when adopting the framework.

## Facts

| Field | Value |
|---|---|
| Project name | `your-project` |
| Public URL | `https://example.com` |
| Repository | `https://example.com/your-org/your-project` |
| Primary human operator | `your-operator` |
| Executor agents | Claude Code, Codex (example assignment) |
| Current phase | scaffold / demo |

## Goals

1. Demonstrate persistent file-based memory across agent sessions.
2. Demonstrate lossless handoffs between two different AI models.
3. Keep every tracked file public-safe at all times.

## Constraints

- No real infrastructure, credentials, or customer data anywhere in tracked
  files — placeholders only.
- All work flows through task contracts in `memory/tasks/`.
- Human approval gates per `docs/runbooks/HUMAN_APPROVAL_FLOW.md`.

## Current state

- Framework scaffold complete (see `CHANGELOG.md` 0.1.0).
- Demo task `TASK-0001` available in `examples/demo-website-project/`.

## Update rules

- Edit in place; bump the `Updated:` date at the top.
- Keep this file under ~100 lines — it is loaded by every session.
- Detail belongs in task files, ADRs, or agent memory, not here.
