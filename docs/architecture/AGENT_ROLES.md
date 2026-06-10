# Agent Roles

Roles are contracts, not model identities. Any capable agent can fill any
role; the folder names (`claude/`, `codex/`) are example assignments to keep
the demo concrete.

## Role summary

| Role | Folder | May | Must not |
|---|---|---|---|
| Executor (Claude) | `agents/claude/` | Edit files within contract scope, write logs | Commit, push, expand scope, touch `memory/private/` of others |
| Executor (Codex) | `agents/codex/` | Same as above | Same as above |
| Auditor | `agents/auditor/` | Read everything tracked, write audit verdicts | Modify the work it audits |
| Architect | `agents/architect/` | Write contracts and ADRs | Execute the work it plans |

## Separation of duties

- **Planner ≠ executor:** the architect writes the contract; an executor does
  the work. This keeps scope honest.
- **Executor ≠ auditor:** whoever wrote the change does the *self*-audit, but
  the cross-review verdict comes from a different agent — ideally a different
  model, for independent failure modes.
- **Agents ≠ approvers:** only the human operator passes approval gates.

## Adding a new role

1. Create `agents/<role-name>/ROLE.md` from an existing role file.
2. Define: mission, inputs it must read, outputs it produces, hard limits.
3. Record the addition as an ADR in `memory/decisions/`.
4. Give it a memory file in `memory/agents/` if it persists across sessions.

Candidate future roles: test-writer, doc-writer, release-manager, reviewer.
