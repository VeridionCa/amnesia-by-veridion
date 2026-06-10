# Amnesia Session Recorder (MVP)

Recover project context after leaving a Claude Code or Codex session —
without manually writing a handoff.

## The problem it solves

You stop a session (token limit, end of day, crash) and the next session —
you, or an AI agent — has to reconstruct: what was I doing, what changed,
what's risky, what's next. The Session Recorder captures that operational
context automatically as you work, and turns it into a ready-to-paste
resume prompt.

## What it does NOT do

- It does **not** capture model reasoning, hidden chain-of-thought, or chat
  history — only observable project state (git) and what you choose to note.
- It does not replace task contracts or the audited handoff flow for
  multi-agent work — it's the lightweight always-on layer underneath them.
- It does not commit, push, or modify your project files. Everything it
  writes lives under `.amnesia/` (gitignored runtime data).

## Quick start

```bash
# begin a recorded session
scripts/amnesia/session-start.sh --task "Build the doctor MVP"

# autosave as you work (any number of times)
scripts/amnesia/session-save.sh --note "Doctor checks passing locally"

# interrupted? next session, generate the resume prompt:
scripts/amnesia/session-resume.sh

# done? close with a final handoff:
scripts/amnesia/session-close.sh --summary "Doctor MVP complete, tests green"
```

## Commands

| Command | What it does |
|---|---|
| `session-start.sh --task "..."` | Creates `.amnesia/sessions/<timestamp>/` with a `SESSION_CONTEXT.md` (task, branch, HEAD, status, diff) and marks it active via `.amnesia/current-session`. Refuses if a session is already active. |
| `session-save.sh --note "..."` | Appends a timestamped log entry and writes a fresh git-state snapshot to `snapshots/<time>.md`. |
| `session-resume.sh` | Prints a resume prompt (task, current git state, latest log entries, risks, next actions, safety instructions for the AI) and writes `RESUME_PROMPT.md`. |
| `session-close.sh --summary "..."` | Appends the final summary, writes `FINAL_HANDOFF.md` with closing git state, and clears the active-session marker. |

## Recovery workflow

1. New session (human or AI) runs `scripts/amnesia/session-resume.sh`.
2. Paste the printed prompt into Claude Code / Codex (or let the agent read
   `RESUME_PROMPT.md` directly).
3. The agent verifies branch/HEAD against reality, reads the full
   `SESSION_CONTEXT.md`, and continues from the first incomplete next-action.
4. Keep saving with `session-save.sh`; close with `session-close.sh`.

Sessions are kept under `.amnesia/sessions/` (local only) so past handoffs
remain browsable.

## Safety notes

- `.amnesia/` runtime data is **gitignored** — session files can contain
  absolute local paths and work-in-progress detail, so they never belong in
  a public repository.
- Notes and summaries are written by you: keep credentials, private
  hostnames, and customer data out of them, same as any memory file.
- The generated resume prompt instructs the next agent to verify state
  before editing and to seek human approval for commits/pushes/deletions.

## Example resume prompt (abridged)

```markdown
# Resume Prompt — generated 20260610T180000Z (UTC)

You are resuming an interrupted working session. Load this context,
verify it against the actual repository state, then continue.

## Task
Build the doctor MVP

## Current repository state
- Branch: feature/doctor-mvp
- HEAD: ab12cd3

### Changed files (uncommitted)
scripts/amnesia/doctor.sh

## Latest session log entries
- 20260610T174500Z — SAVE — Doctor checks passing locally ...

## Instructions for the resuming AI session
1. Read the full session context: .amnesia/sessions/20260610T170001Z/SESSION_CONTEXT.md
2. Verify the branch and HEAD above match `git status -sb` before editing.
3. Continue from the first incomplete next-action. Do not redo finished work.
...
```
