# Read-only session starter: Codex, feature-build mode (Windows).
# Usage: .\launch-codex-feature.ps1 [-TaskId TASK-0001]
# Modifies nothing, commits nothing, pushes nothing, connects to no servers.
param(
    [string]$TaskId = "<none selected>"
)
$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")

Write-Host "=============================================================="
Write-Host "  AI TEAM MEMORY CORE - Codex / FEATURE-BUILD mode"
Write-Host "=============================================================="
Write-Host "SAFETY RULES (feature-build workflow):"
Write-Host "  1. Work ONLY within the task contract's allowed paths."
Write-Host "  2. New files count as scope - don't create unlisted files."
Write-Host "  3. No git commit/push, deletion, or side-effect scripts"
Write-Host "     without explicit human approval in this session."
Write-Host "  4. No contact with real systems. Placeholders only."
Write-Host "  5. Verify every done-criterion; log evidence as you go."
Write-Host ""
Write-Host "SELECTED TASK: $TaskId"
if ($TaskId -ne "<none selected>") {
    $TaskFile = Get-ChildItem -Path (Join-Path $RepoRoot "memory\tasks") -Filter "$TaskId*" -File -ErrorAction SilentlyContinue
    if ($TaskFile) {
        Write-Host "Task file: $($TaskFile.Name)"
    } else {
        Write-Host "WARNING: no file matching '$TaskId*' in memory/tasks/ - create one first."
    }
}
Write-Host ""
Write-Host "CONTEXT TO LOAD (in order):"
Write-Host "  1. memory/global/PROJECT_CONTEXT.md"
Write-Host "  2. agents/codex/ROLE.md"
Write-Host "  3. memory/agents/CODEX_MEMORY.md"
Write-Host "  4. workflows/feature-build/WORKFLOW.md"
Write-Host "  5. memory/tasks/$TaskId*"
Write-Host ""

if (Get-Command codex -ErrorAction SilentlyContinue) {
    Write-Host "Starting Codex in: $RepoRoot"
    Set-Location $RepoRoot
    codex
} else {
    Write-Host "Codex CLI not found on this machine."
    Write-Host "Install it first, then re-run this launcher."
    Write-Host "(Nothing was modified - this launcher is read-only.)"
}
