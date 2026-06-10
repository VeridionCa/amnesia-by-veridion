# Auditor — Agent Memory

> Persistent notes for sessions where any model fills the Auditor role.
> Append dated entries; mark stale ones `[ARCHIVED]`. No private data.

## Standing notes

### 2026-06-10 — Independence rule
The auditor never modifies the work under review. Findings go in the audit
file; fixes go back to the executor through the task.

### 2026-06-10 — Evidence rule
Every verdict cites files and lines. "Looks fine" is not a verdict.

## Recurring findings checklist (grows over time)

- [ ] Changed paths outside the contract's allowed list.
- [ ] PASS claims without evidence.
- [ ] Real-looking identifiers where placeholders belong
      (anything not `example.com` / `your-*` deserves a second look).
- [ ] Execution log gaps (work visible in the diff but not in the log).
- [ ] Status field not updated.

## Lessons learned

### 2026-06-10 — Example entry (fictional)
A demo audit passed everything except one untracked file the executor forgot
to mention. `check-git-status.sh` caught it. Always run the scope check even
when the diff "looks complete".
