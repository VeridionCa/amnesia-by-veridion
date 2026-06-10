# Workflow Lifecycle

Every piece of work moves through the same lifecycle, regardless of which
named workflow (`docs-only`, `feature-build`, `refactor`, `audit`, `release`)
is in effect. Workflows differ only in scope rules and required checks.

## Stages

```
1. REQUEST     Human describes the need.
2. CONTRACT    Architect writes memory/tasks/TASK-XXXX-<slug>.md
               from templates/TASK_CONTRACT.md. Human approves the contract.
3. EXECUTE     Executor works inside the contract's allowed paths,
               appending to the execution log in real time.
4. SELF-AUDIT  Executor fills templates/SELF_AUDIT.md: every contract
               requirement gets PASS / FAIL / N-A with evidence.
5. REVIEW      Auditor cross-checks; verdict appended to the audit file.
6. CLOSE       HANDOFF.md if another agent continues;
               FINAL_REPORT.md if the work is done.
7. GATE        Human reviews report → approves or rejects.
8. COMMIT      Only after the gate. Memory files updated; task marked done.
```

## State tracking

The task file's `Status:` field is the single source of truth:

`draft → approved → in-progress → self-audited → reviewed → awaiting-approval → done | rejected`

Agents update the field as they move the task; humans flip
`awaiting-approval → done`.

## Choosing a workflow

| Situation | Workflow |
|---|---|
| Documentation, memory, templates only | `workflows/docs-only/` |
| New functionality | `workflows/feature-build/` |
| Behavior-preserving restructure | `workflows/refactor/` |
| Hygiene / public-safety / quality sweep | `workflows/audit/` |
| Tagging and publishing a version | `workflows/release/` |

## Interruptions

If an agent stops mid-task (token limit, error, end of session), the
execution log plus a `HANDOFF.md` is the recovery point. The next session:

1. Reads the context pack for the task.
2. Reads the handoff and the execution log.
3. Continues from the first unchecked contract item.

Nothing is re-derived from memory of the conversation, because there is none.
