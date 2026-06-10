# ADR-0001: File-based shared memory for AI teamwork

- **Status:** Accepted
- **Date:** 2026-06-10
- **Deciders:** human operator (`your-operator`)

## Context

Multiple AI coding agents (Claude Code, Codex, and future agents) need to
collaborate on the same project across many sessions. Chat history is
ephemeral, model-specific, and not reviewable. The team needs memory that is
durable, diffable, model-agnostic, and publishable without leaking private
information.

## Decision

Use **plain Markdown files in the Git repository** as the only shared memory:

- `memory/global/` for project context, `memory/agents/` for per-agent notes,
  `memory/decisions/` for append-only ADRs, `memory/tasks/` for task
  contracts, `memory/private/` (gitignored) for anything sensitive.
- All work is governed by task contracts; all closure goes through self-audit,
  cross-review, and human approval gates.
- Decision records are append-only: superseded, never edited.

## Alternatives considered

1. **Vector database / RAG store** — rejected: extra infrastructure, opaque
   contents, not reviewable in PRs, harder to keep public-safe.
2. **Per-model built-in memory** — rejected: not shared between models,
   not versioned, invisible to the human operator.
3. **Wiki outside the repo** — rejected: drifts from the code, no atomic
   review of memory + change together.

## Consequences

- (+) Any agent or human can read/restore full context from files alone.
- (+) Memory changes are reviewed like code.
- (−) Agents must be disciplined about reading and updating files; the
  workflows and launchers exist to enforce that ritual.
- (−) Memory files can grow stale; the `Updated:` dates and `[ARCHIVED]`
  convention mitigate this.
