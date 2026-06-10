# Runbook: Safe Task Flow

Step-by-step procedure for running one task from request to commit.

## Preconditions

- Repository is clean (`scripts/audit/check-git-status.sh`).
- `memory/global/PROJECT_CONTEXT.md` is current.

## Steps

1. **Create the task**
   ```bash
   scripts/memory/create-task.sh "short-task-name"
   ```
   Fill in the generated `memory/tasks/TASK-XXXX-short-task-name.md`:
   goal, allowed paths, forbidden actions, done criteria.

2. **Human approves the contract.** Set `Status: approved`.

3. **Launch the executor**
   ```bash
   scripts/launch/launch-claude-feature.sh TASK-XXXX
   # or
   scripts/launch/launch-codex-feature.sh TASK-XXXX
   ```

4. **Executor works.** It must:
   - touch only allowed paths,
   - append to the execution log after each meaningful step,
   - stop and ask if the contract is ambiguous or scope pressure appears.

5. **Self-audit.** Executor fills a `SELF_AUDIT.md` from the template:
   every done-criterion gets PASS / FAIL / N-A with file-level evidence.
   Set `Status: self-audited`.

6. **Cross-review.** Launch the auditor (other model preferred):
   ```bash
   scripts/launch/launch-auditor.sh TASK-XXXX
   ```
   Auditor verifies claims against files; appends verdict.
   Set `Status: reviewed`.

7. **Close.** Executor writes `FINAL_REPORT.md` (or `HANDOFF.md` if work
   continues). Set `Status: awaiting-approval`.

8. **Human gate.** Human reads the report and diff. On approval — and only
   then — stage the specific files and commit. Set `Status: done`.

## Abort conditions

Stop and escalate to the human immediately if:

- a needed change falls outside allowed paths,
- any file appears to contain private data,
- a destructive action (delete, overwrite of unrelated work) seems required,
- the contract and reality disagree.
