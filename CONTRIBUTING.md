# Contributing

Thanks for your interest in Amnesia by Veridion!

## Ground rules

1. **Everything in this repo must be public-safe.** No real company,
   infrastructure, customer, or security data — placeholders only
   (`example.com`, `your-project`, `your-agent`).
2. **Run the audit before opening a PR:**
   ```bash
   scripts/audit/pre-public-audit.sh
   ```
3. **Docs are the product.** Changes to templates, workflows, or roles should
   update the matching docs in `docs/`.
4. **Decisions are append-only.** Never edit a published ADR in
   `memory/decisions/` — add a superseding one.

## How to contribute

1. Fork and create a feature branch.
2. For non-trivial changes, open an issue first describing the problem.
3. Follow the existing file style: Markdown, short sections, tables for
   enumerable facts.
4. Keep scripts POSIX-sh-friendly (bash) or PowerShell 5.1+ compatible, and
   keep launchers/audits **read-only** — they must not modify, commit, push,
   or connect to remote systems.
5. Update `CHANGELOG.md` under "Unreleased".

## What gets rejected

- Anything that embeds real operational data, even your own.
- Scripts with side effects in `scripts/launch/` or `scripts/audit/`.
- Examples that target real systems or describe offensive techniques beyond
  authorized-lab/defensive scope.
