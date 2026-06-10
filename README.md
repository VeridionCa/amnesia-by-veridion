# Amnesia by Veridion

**AI agents forget context. Amnesia gives them operational memory.**

A Git-native persistent memory framework for Claude Code and Codex teamwork:
shared file-based memory, task contracts, lossless handoffs, self-audits,
read-only launchers, audit scripts, and human approval gates.
No databases. No servers. No secrets — just Markdown, Git, and discipline.

## Why this exists

AI coding agents are powerful and amnesiac. Every session starts from zero;
context lives in chat histories that are ephemeral, model-locked, and
invisible to teammates. Teams that use *two* models (say, Claude for
building and Codex for reviewing) have it worse: neither can see what the
other did or why.

The fix doesn't need infrastructure. A Git repository is already a durable,
diffable, reviewable, model-agnostic store. Amnesia is the missing
convention layer on top of it: where memory lives, how work is scoped, how
agents hand off, and where humans stay in control. The product is named
after the problem it eliminates.

## How it works

Everything is a file:

- **Memory** (`memory/`) — global project context every session loads first,
  per-agent lesson files, append-only decision records (ADRs), and task
  files. Sensitive notes go in gitignored `memory/private/`, never tracked.
- **Roles** (`agents/`) — each agent works under a `ROLE.md` defining its
  mission and hard limits. Executor, Auditor, and Architect are separated on
  purpose: the planner doesn't execute, the executor doesn't approve its own
  work.
- **Task contracts** (`templates/TASK_CONTRACT.md`) — before any work, a
  contract fixes the goal, the allowed paths, the forbidden actions, and
  observable done criteria. If it isn't in the contract, it isn't in scope.
- **Workflows** (`workflows/`) — five named procedures (docs-only,
  feature-build, refactor, audit, release) sharing one lifecycle but with
  different scope rules and required checks.
- **Launchers** (`scripts/launch/`, `scripts/windows/`) — read-only session
  starters that print the safety rules and the context files to load, then
  open `claude` or `codex` if installed.
- **Audits** (`scripts/audit/`) — read-only hygiene and public-safety
  checks; the secret scan redacts values and reports only categories and
  locations.

## The AI team lifecycle

```
1. REQUEST      Human describes the need.
2. CONTRACT     Architect writes the task contract. Human approves it.
3. EXECUTE      Executor (Claude or Codex) works inside the contract,
                appending to the execution log in real time.
4. SELF-AUDIT   Executor checks every done-criterion with evidence.
5. REVIEW       Auditor — ideally the *other* model — verifies every claim
                against the actual files.
6. CLOSE        HANDOFF.md if work continues; FINAL_REPORT.md if done.
7. GATE         Human reviews the report and diff.
8. COMMIT       Only after the gate.
```

If an agent stops mid-task (token limit, crash, end of session), the
execution log plus a handoff file is the recovery point. The next agent —
even a different model — continues with zero conversation history, because
none is needed.

## Safety model

Three boundaries, enforced by convention and checked by audits:

| Boundary | Rule |
|---|---|
| **Repo** | Nothing private is ever tracked. `memory/private/` is gitignored; placeholders (`example.com`, `your-server`) replace all real identifiers. |
| **Contract** | Agents touch only the paths the active contract allows. New files count as scope. |
| **Approval** | Commit, push, delete, release, and anything outward-facing require explicit human approval — per action, per session, recorded in the log. |

Security-flavored content in this project is strictly defensive:
checklists, audits, and toy examples. Nothing here targets real systems.

## Quick start

```bash
git clone https://github.com/veridionCA/amnesia-by-veridion.git
cd amnesia-by-veridion

# 1. Read the architecture
less docs/architecture/AI_TEAM_ARCHITECTURE.md

# 2. Create your first task from the template
scripts/memory/create-task.sh "my-first-task"

# 3. Launch an agent in safe docs-only mode (read-only starter)
scripts/launch/launch-claude-docs-only.sh

# 4. Before publishing anything, run the public-safety audit
scripts/audit/pre-public-audit.sh
```

Windows users: see `scripts/windows/` and `docs/manuals/MACHINE_LAUNCHERS.md`.
A worked, fully fictional example lives in `examples/demo-website-project/`.

## Folder structure

```
amnesia-by-veridion/
├── README.md / SECURITY.md / CONTRIBUTING.md / CHANGELOG.md / LICENSE
├── docs/
│   ├── architecture/   # how the system works
│   ├── manuals/        # per-tool command guides and launcher docs
│   ├── runbooks/       # step-by-step operational flows
│   ├── PROJECT_STATUS.md / ROADMAP.md / PHASE_1_REPORT.md
├── memory/
│   ├── global/         # shared project context all agents load
│   ├── agents/         # per-agent persistent memory
│   ├── decisions/      # append-only architecture decision records
│   ├── tasks/          # task contracts and task state
│   └── private/        # local-only memory — gitignored, never published
├── agents/             # role definitions: claude, codex, auditor, architect
├── workflows/          # docs-only, feature-build, refactor, audit, release
├── scripts/
│   ├── launch/         # read-only session starters (bash)
│   ├── windows/        # read-only session starters (PowerShell)
│   ├── audit/          # public-safety and hygiene checks (read-only)
│   └── memory/         # task/memory helpers
├── templates/          # task contract, execution log, self-audit, handoff, report
└── examples/           # fictional demo project and handoff
```

## Project status

**Phase 2.2 — rebranded, preparing first public release.** The full
framework is built and audited; first publication is pending at
`github.com/veridionCA/amnesia-by-veridion`. Details and the "not built
yet" list: [`docs/PROJECT_STATUS.md`](docs/PROJECT_STATUS.md).

## Roadmap

| Version | Theme |
|---|---|
| v0.1.0 *(current)* | Scaffold and docs |
| v0.2.0 | Stronger launchers and context packs |
| v0.3.0 | Cross-agent handoff demo |
| v0.4.0 | GitHub issue templates and CI audit workflow |
| v0.5.0 | Public repo extraction guide |
| v1.0.0 | Stable public release |

Full details: [`docs/ROADMAP.md`](docs/ROADMAP.md).

## Public-safety promise

Every tracked file in this repository is generic and safe to publish:

- Placeholders only — `example.com`, `your-project`, `your-server`,
  `your-agent`, `your-operator`, `your-production-system`.
- All examples, agents, tasks, and projects are fictional.
- No credentials, no real infrastructure, no customer data, no operational
  history — and read-only audit tooling (`scripts/audit/`) plus
  [`docs/manuals/PUBLIC_REPO_GUIDE.md`](docs/manuals/PUBLIC_REPO_GUIDE.md)
  to keep it that way.

If you find anything that breaks this promise, see [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
