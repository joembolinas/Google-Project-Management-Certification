<#!
.SYNOPSIS
    Validate that every transcript in src/ referenced (and only referenced) in Course Notes Sources sections.
.DESCRIPTION
    Parses Course Notes markdown files for lines inside a Sources block (`Sources:` heading until blank line or next heading) containing backticked paths.
    Compares to actual transcript filenames in src/ (recursing). Reports:
      - Unreferenced transcripts present in src/
      - Referenced paths that do not exist
      - Potential numbering gaps
.LIMITATIONS
    Assumes consistent formatting: lines starting with `- ` and a backticked path.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)
$ErrorActionPreference = 'Stop'

$srcRoot = Join-Path $RepoRoot 'src'
$courseNotesDir = Join-Path $RepoRoot '1_Project_Files/03_Execution/Course_Notes'

# Collect actual transcript files
$actual = Get-ChildItem -Path $srcRoot -Recurse -File | ForEach-Object { $_.FullName.Substring($RepoRoot.Length+1) }

# Extract references
$referenced = @()
Get-ChildItem -Path $courseNotesDir -Filter '*.md' | ForEach-Object {
    $inSources = $false
    Get-Content $_.FullName | ForEach-Object {
        $line = $_
        if ($line -match '^Sources:') { $inSources = $true; return }
        if ($inSources) {
            if ($line -match '^\s*$' -or $line -match '^# ') { $inSources = $false; return }
            if ($line -match '-\s+`([^`]+)`') { $referenced += $Matches[1] }
        }
    }
}

$actualSet = [System.Collections.Generic.HashSet[string]]::new()
$actual | ForEach-Object { [void]$actualSet.Add($_) }
$refSet = [System.Collections.Generic.HashSet[string]]::new()
$referenced | ForEach-Object { [void]$refSet.Add($_) }

$unreferenced = $actual | Where-Object { -not $refSet.Contains($_) }
$missing = $referenced | Where-Object { -not $actualSet.Contains($_) }

# Simple numbering gap detection for top-level module 1 pattern (example extension later)
$module1 = $actual | Where-Object { $_ -match '^src/Course1-Module1/1\.(\d+)\.' } | ForEach-Object { [int]($Matches[1]) }
$expected = 1..($module1 | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum)
$gaps = $expected | Where-Object { $_ -notin $module1 }

Write-Host "=== Validate Sources Report ===" -ForegroundColor Cyan
Write-Host "Total transcripts: $($actual.Count)"; Write-Host "Referenced transcripts: $($refSet.Count)"
if ($unreferenced) { Write-Host "Unreferenced transcripts:" -ForegroundColor Yellow; $unreferenced | ForEach-Object { Write-Host "  $_" } } else { Write-Host "No unreferenced transcripts." -ForegroundColor Green }
if ($missing) { Write-Host "Missing (referenced but absent):" -ForegroundColor Red; $missing | ForEach-Object { Write-Host "  $_" } } else { Write-Host "No missing referenced files." -ForegroundColor Green }
if ($gaps) { Write-Host "Numbering gaps detected (Module 1 sequence): $($gaps -join ', ')" -ForegroundColor Yellow } else { Write-Host "No numbering gaps in Module 1 sequence." -ForegroundColor Green }
