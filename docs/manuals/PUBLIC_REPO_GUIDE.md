# Public Repo Guide

How to keep this repository — and any project built on it — safe to publish.

## The rule

**If it identifies a real system, person, or organization, it does not get
tracked.** Use placeholders:

| Real thing | Placeholder |
|---|---|
| Domain / URL | `example.com` |
| Project name | `your-project` |
| Server / host | `your-server` |
| Agent / account | `your-agent` |
| Sensitive context | `your-context`, `your-private-memory` |
| Production system | `your-production-system` |

## Where private things go

1. **`memory/private/`** — gitignored; local notes that need to sit near the
   work.
2. **Outside the repo** — anything credential-shaped never enters the working
   tree at all, even ignored. `.gitignore` patterns for `.env`, keys, and
   dumps exist as defense in depth, not as an invitation.

## Before every publish / release / PR

```bash
scripts/audit/pre-public-audit.sh
```

This runs, read-only:

1. `check-git-status.sh` — what would actually be committed.
2. `check-large-files.sh` — binaries and archives that don't belong.
3. `check-secrets-basic.sh` — keyword scan that **redacts values** (prints
   file, line number, and keyword category only).

The secret scan is a tripwire, not a guarantee. A human must still review
every flagged line and skim new files before publishing.

## Common leak vectors (learned the easy way)

- Execution logs that paste real command output (hostnames, paths, usernames).
- "Lessons learned" memory entries naming real systems.
- Example tasks copied from real ones and incompletely scrubbed.
- Screenshots — this framework uses none; keep it that way.
- Commit messages and branch names (the audit doesn't see those — you do).

## If something private was committed

Treat it as exposed: rotate any credential involved, then rewrite history
only with explicit human decision (history rewrites are outside agent
authority in this framework).
