# Changelog

All notable changes to AI Team Memory Core are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/); versions follow
[Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-06-10

Initial public-safe scaffold — the complete framework, built generic from
the start: placeholders only, fictional examples only, nothing private.

### Added

**File-based memory system**
- `memory/global/PROJECT_CONTEXT.md` — the context every session loads first.
- Per-agent persistent memory: `CLAUDE_MEMORY.md`, `CODEX_MEMORY.md`,
  `AUDITOR_MEMORY.md`.
- Append-only decision records, starting with ADR-0001 (file-based memory).
- Task template and gitignored `memory/private/` for local-only notes.

**Agent roles**
- Executor roles for Claude Code and Codex (model-agnostic by design),
  plus Auditor (cross-review) and Architect (contracts and ADRs), each with
  mission, required reading, outputs, and hard limits.

**Workflows**
- Five named workflows over one shared lifecycle: docs-only, feature-build,
  refactor, audit, release — each with its own scope rules and checks.

**Templates**
- Task contract, execution log (append-only), self-audit with cross-review
  section, handoff, and final report.

**Launch scripts (read-only)**
- Bash: docs-only, feature (Claude/Codex), auditor, interactive menu.
- PowerShell: docs-only, Codex feature, menu.
- All print safety rules + context list, then start the agent CLI only if
  installed; friendly fallback otherwise. No writes, no git, no network.

**Audit scripts (read-only)**
- `check-git-status.sh`, `check-large-files.sh`, `check-secrets-basic.sh`
  (redacts values — reports category + file:line only), and
  `pre-public-audit.sh` chaining all three plus a manual checklist.

**Memory helper scripts**
- `create-task.sh` (one new file, never overwrites), `update-memory.sh`
  (append-only), `generate-context-pack.sh` (writes only to gitignored
  `context-packs/`).

**Docs**
- Architecture: team architecture, memory system, agent roles, workflow
  lifecycle.
- Manuals: Claude commands, Codex commands, machine launchers, public repo
  guide.
- Runbooks: safe task flow, self-audit flow, human approval flow.
- Project tracking: `PROJECT_STATUS.md`, `ROADMAP.md`, `PHASE_1_REPORT.md`.

**Fictional examples**
- Demo website project with a complete lifecycle task (TASK-0001).
- Demo mid-task agent handoff (TASK-0002 handoff).

### Security
- Public-safety boundaries baked in: placeholder-only identifiers,
  gitignored private memory, secret-shaped filename patterns ignored as
  defense in depth, redacting secret scan required before any publish.
