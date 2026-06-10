# Read-only session starter: Claude Code, docs-only mode (Windows).
# Modifies nothing, commits nothing, pushes nothing, connects to no servers.
$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")

Write-Host "=============================================================="
Write-Host "  AI TEAM MEMORY CORE - Claude Code / DOCS-ONLY mode"
Write-Host "=============================================================="
Write-Host "SAFETY RULES (docs-only workflow):"
Write-Host "  1. Only docs/, memory/ (not private of others), templates/,"
Write-Host "     examples/, and top-level *.md may change."
Write-Host "  2. No scripts, no executables, no .gitignore/LICENSE changes."
Write-Host "  3. No git commit/push, no deletions - human approval required."
Write-Host "  4. Placeholders only: example.com, your-project, your-server."
Write-Host "  5. Log as you go in the active task's execution log."
Write-Host ""
Write-Host "CONTEXT TO LOAD (in order):"
Write-Host "  1. memory/global/PROJECT_CONTEXT.md"
Write-Host "  2. agents/claude/ROLE.md"
Write-Host "  3. memory/agents/CLAUDE_MEMORY.md"
Write-Host "  4. workflows/docs-only/WORKFLOW.md"
Write-Host "  5. Your active task file in memory/tasks/"
Write-Host ""

if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "Starting Claude Code in: $RepoRoot"
    Set-Location $RepoRoot
    claude
} else {
    Write-Host "Claude Code CLI not found on this machine."
    Write-Host "Install it first, then re-run this launcher."
    Write-Host "(Nothing was modified - this launcher is read-only.)"
}
