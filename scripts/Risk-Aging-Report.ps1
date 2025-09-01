<#!
.SYNOPSIS
    Simple risk aging / status report.
.DESCRIPTION
    Parses Risk_Register.md table and flags risks missing review or with High status.
    Assumes columns include at least: ID, Description, Status, Last_Review (or Review_Date), Impact, Probability.
.LIMITATION
    Lightweight heuristic; adjust column detection as register matures.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [int]$StaleDays = 14
)
$ErrorActionPreference = 'Stop'
$register = Join-Path $RepoRoot '1_Project_Files/02_Planning/Risk_Register.md'
if (-not (Test-Path $register)) { throw 'Risk_Register.md not found.' }

$lines = Get-Content $register
# Extract table lines (between first line starting with | and a blank line after)
$tableLines = $lines | Where-Object { $_ -match '^\|' }
if (-not $tableLines) { Write-Warning 'No table rows found.'; exit }

# Determine column indices
$header = $tableLines | Select-Object -First 1
$cols = $header.Split('|').Trim() | Where-Object { $_ }
function Get-ColIndex($name) { ($cols | ForEach-Object { $_ }) -as [string[]] | ForEach-Object -Begin { $i=0 } -Process { if ($_ -eq $name) { $script:found=$i }; $i++ } -End { return $script:found } }

$idIdx = [array]::IndexOf($cols,'ID')
$statusIdx = [array]::IndexOf($cols,'Status')
$lastIdx = [array]::IndexOf($cols,'Last_Review')
$impactIdx = [array]::IndexOf($cols,'Impact')
$probIdx = [array]::IndexOf($cols,'Probability')

$now = Get-Date
$staleCutoff = $now.AddDays(-$StaleDays)

$rows = @()
foreach ($row in $tableLines | Select-Object -Skip 2) { # skip header + separator
    $parts = $row.Split('|').Trim() | Where-Object { $_ }
    if ($parts.Count -lt 3) { continue }
    $obj = [PSCustomObject]@{
        ID = if ($idIdx -ge 0) { $parts[$idIdx] } else { '' }
        Status = if ($statusIdx -ge 0) { $parts[$statusIdx] } else { '' }
        LastReview = if ($lastIdx -ge 0 -and $parts[$lastIdx]) { [datetime]::Parse($parts[$lastIdx]) } else { $null }
        Impact = if ($impactIdx -ge 0) { $parts[$impactIdx] } else { '' }
        Probability = if ($probIdx -ge 0) { $parts[$probIdx] } else { '' }
    }
    $rows += $obj
}

Write-Host '=== Risk Aging Report ===' -ForegroundColor Cyan
foreach ($r in $rows) {
    $flags = @()
    if ($r.Status -match 'High') { $flags += 'HIGH' }
    if ($r.LastReview -and $r.LastReview -lt $staleCutoff) { $flags += 'STALE' }
    elseif (-not $r.LastReview) { $flags += 'NO_DATE' }
    $flagStr = if ($flags) { '[' + ($flags -join ',') + ']' } else { '' }
    Write-Host ("{0,-6} {1,-6} {2,-10:d} {3}" -f $r.ID,$r.Status,($r.LastReview),$flagStr)
}
