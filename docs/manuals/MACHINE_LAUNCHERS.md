# Machine Launchers

Launchers are **read-only session starters**. They exist so that starting an
agent session always begins with the same safety ritual, on any machine.

## Guarantees

Every launcher in `scripts/launch/` (bash) and `scripts/windows/` (PowerShell):

- modifies **no** files,
- runs **no** git write commands (no add/commit/push),
- connects to **no** servers,
- prints the **safety rules** for the selected mode,
- prints the **context files** the agent must load,
- then opens `claude` or `codex` **only if installed** — otherwise it prints a
  friendly install hint and exits cleanly.

## Available launchers

| Script | Mode |
|---|---|
| `launch-claude-docs-only.sh` | Claude, documentation/memory-only scope |
| `launch-claude-feature.sh [TASK-ID]` | Claude, feature work under a task contract |
| `launch-codex-feature.sh [TASK-ID]` | Codex, feature work under a task contract |
| `launch-auditor.sh [TASK-ID]` | Either model in the Auditor role |
| `ai-team-menu.sh` | Interactive menu over all of the above |
| `windows/launch-claude-docs-only.ps1` | PowerShell equivalent |
| `windows/launch-codex-feature.ps1` | PowerShell equivalent |
| `windows/ai-team-menu.ps1` | PowerShell menu |

## Usage

```bash
# Linux / macOS
scripts/launch/ai-team-menu.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File scripts\windows\ai-team-menu.ps1
```

## Adding a launcher

Copy an existing one. Keep the three sections intact: safety banner, context
listing, tool detection. If your new launcher needs to *do* anything beyond
printing and starting the agent CLI, it is not a launcher — it belongs
elsewhere, behind an approval gate.
