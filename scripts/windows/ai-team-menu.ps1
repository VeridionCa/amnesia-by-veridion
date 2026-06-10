# Interactive menu over the read-only launchers (Windows).
# Modifies nothing, commits nothing, pushes nothing, connects to no servers.
$ErrorActionPreference = "Stop"

Write-Host "=============================================================="
Write-Host "  AI TEAM MEMORY CORE - Launch Menu (read-only)"
Write-Host "=============================================================="
Write-Host "  1) Claude - docs-only mode"
Write-Host "  2) Codex  - feature-build mode"
Write-Host "  q) Quit"
Write-Host "=============================================================="
$sel = Read-Host "Select"

switch ($sel) {
    "1" {
        & (Join-Path $PSScriptRoot "launch-claude-docs-only.ps1")
    }
    "2" {
        $task = Read-Host "Task ID (e.g. TASK-0001, empty for none)"
        if ([string]::IsNullOrWhiteSpace($task)) {
            & (Join-Path $PSScriptRoot "launch-codex-feature.ps1")
        } else {
            & (Join-Path $PSScriptRoot "launch-codex-feature.ps1") -TaskId $task
        }
    }
    default {
        Write-Host "Bye. (Nothing was modified.)"
    }
}
