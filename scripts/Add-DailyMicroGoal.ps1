<#
.SYNOPSIS
    Insert a new daily micro-goal block at top of progress-log.md.
.DESCRIPTION
    Adds a dated section (ISO date) with a 'Micro-goal:' line if today's date section does not yet exist.
    If section exists and lacks a Micro-goal line, inserts one beneath the date heading.
.PARAMETER RepoRoot
    Optional path to repo root. Auto-detected if omitted.
.EXAMPLE
    pwsh scripts/Add-DailyMicroGoal.ps1 -MicroGoal "Capture 3 definitions from 3.2–3.3"
#>
[CmdletBinding()]
param(
    [string]$RepoRoot,
    [Parameter(Mandatory=$true)][string]$MicroGoal,
    [switch]$Force
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) {
    if ($PSScriptRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path } else { $RepoRoot = (Get-Location).Path }
}
$logFile = Join-Path $RepoRoot 'progress-log.md'
if (-not (Test-Path $logFile)) { throw "progress-log.md not found at $RepoRoot" }

$today = (Get-Date).ToString('yyyy-MM-dd')
$content = Get-Content $logFile -Raw -Encoding UTF8
$pattern = "(?m)^## $today\b"
if ($content -notmatch $pattern) {
    Write-Host "Creating new date section for $today" -ForegroundColor Cyan
    $block = @("## $today","Micro-goal: $MicroGoal","","- Covered:","- Key Takeaway:","- Next Step:","","$content") -join [Environment]::NewLine
    Set-Content -Path $logFile -Value $block -Encoding UTF8
} else {
    # Section exists; ensure Micro-goal line present/updated
    $lines = $content -split "`n"
    for ($i=0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match "^## $today\b") {
            $insertIndex = $i + 1
            if ($insertIndex -lt $lines.Count -and $lines[$insertIndex] -match '^Micro-goal:') {
                if ($Force) { $lines[$insertIndex] = "Micro-goal: $MicroGoal"; Write-Host 'Updated existing micro-goal.' -ForegroundColor Yellow }
                else { Write-Host 'Micro-goal already present (use -Force to overwrite).' -ForegroundColor Green }
            } else {
                $lines = $lines[0..$i] + @("Micro-goal: $MicroGoal") + $lines[($i+1)..($lines.Count-1)]
                Write-Host 'Inserted micro-goal line.' -ForegroundColor Cyan
            }
            break
        }
    }
    Set-Content -Path $logFile -Value ($lines -join "`n") -Encoding UTF8
}
Write-Host 'Done.' -ForegroundColor Green
