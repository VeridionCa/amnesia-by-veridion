# Workflow: Release

For tagging and publishing a version of the project. The most gated workflow:
everything outward-facing happens here, and only humans pull the trigger.

## Preconditions

- All tasks intended for the release are `Status: done`.
- A full **audit workflow** run (`workflows/audit/`) completed with zero
  BLOCKER findings.
- `scripts/audit/pre-public-audit.sh` clean or every hit explained in the
  release notes.

## Required steps

1. **Release contract** — version number, included changes, target
   (e.g., public GitHub at `https://example.com/your-org/your-project`).
2. **Changelog** — move "Unreleased" items in `CHANGELOG.md` under the new
   version with today's date.
3. **Final sweep** — re-run the pre-public audit on the exact tree to be
   published.
4. **Release report** — from `templates/FINAL_REPORT.md`: what ships, audit
   results, known issues.
5. **Human gate (double)** — human approves (a) the commit and (b) the
   push/tag/publish as separate explicit approvals.
6. **Publish** — human (or human-supervised session) performs the tagged
   push.
7. **Record** — release noted in `memory/global/PROJECT_CONTEXT.md` and the
   execution log closed.

## Agent limits

Agents prepare everything up to step 4. Steps 5–6 are human actions; an agent
may type the commands only with per-command approval in the live session.

## Rollback

If a published release is found to leak private data: treat it as exposed
(rotate anything affected), then the human decides on yank/rewrite. See
`docs/manuals/PUBLIC_REPO_GUIDE.md`.
