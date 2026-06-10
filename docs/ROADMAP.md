# Roadmap

Versioned plan for Amnesia by Veridion. Dates are intentionally absent —
each version ships when its audit passes, not when a calendar says so.

## v0.1.0 — Scaffold and docs *(current)*

- Complete public-safe scaffold: memory system, roles, workflows, templates.
- Architecture docs, manuals, runbooks.
- Read-only launchers (bash + PowerShell) and redacting audit scripts.
- Fictional examples (demo website project, demo handoff).
- Status: built; awaiting human review and first commit.

## v0.2.0 — Stronger launchers and context packs

- Context-pack size budgets and per-role pack profiles.
- Launchers validate task status (warn if task not `approved`).
- Launcher option to auto-generate the context pack before starting.
- Configurable agent CLI names (beyond `claude`/`codex`).

## v0.3.0 — Cross-agent handoff demo

- A complete, runnable two-session demo: agent A starts a fictional task,
  stops mid-way, agent B finishes it — with real logs from both sessions
  (fictional content, real mechanics).
- Handoff quality checklist distilled from the demo.

## v0.4.0 — GitHub issue templates and CI audit workflow

- Issue templates: task proposal, audit finding, handoff problem.
- Pull request template embedding the self-audit summary.
- GitHub Actions workflow running the pre-public audit on every PR
  (read-only; fails on unexplained keyword hits).

## v0.5.0 — Public repo extraction guide

- Step-by-step guide for lifting this folder out of a parent repository into
  a clean public repo with no history leakage.
- Final pre-publication checklist (audit + manual review + license/contact
  fixups).

## v1.0.0 — Stable public release

- Stable contract/handoff/audit schema, versioned templates.
- Documented compatibility policy for template changes.
- First tagged public release.
