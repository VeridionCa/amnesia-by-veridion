# Example: Demo Website Project

A **fully fictional** walkthrough of using AI Team Memory Core on a small
website project. Nothing here refers to any real site, server, or company —
the project, domain (`example.com`), agents, and task are all invented for
demonstration.

## Scenario

`your-project` is a small static documentation site published at
`https://example.com`. The human operator wants two AI agents to maintain it:

- **Claude Code** as executor for content tasks,
- **Codex** as auditor (cross-review).

## What this example shows

1. A complete, filled-in task contract: [`TASK-0001.md`](TASK-0001.md) —
   adding an FAQ page to the fictional site, with allowed paths, done
   criteria, execution log, self-audit, cross-review, and approval record.
2. How the status field moves: `draft → approved → in-progress →
   self-audited → reviewed → awaiting-approval → done`.
3. How approvals are quoted in the log, and how the auditor's verdict cites
   evidence.

## How to use it

Read `TASK-0001.md` top to bottom — it is the lifecycle from
`docs/architecture/WORKFLOW_LIFECYCLE.md` made concrete. Then create your own
first task:

```bash
scripts/memory/create-task.sh "my-first-task"
```

For a continuation scenario (agent stops mid-task), see
[`../demo-agent-handoff/`](../demo-agent-handoff/).
