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
    [string]$RepoRoot
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) {
    if ($PSScriptRoot) {
        $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
    } else {
        # Fallback: assume script run from repo root or scripts directory relative
        $candidate = Get-Location
        if (Test-Path (Join-Path $candidate 'scripts')) { $RepoRoot = $candidate.Path } else { $RepoRoot = (Resolve-Path '..').Path }
    }
}

 $srcRoot = Join-Path $RepoRoot 'src'
 $courseNotesDir = Join-Path $RepoRoot '1_Project_Files/03_Execution/Course_Notes'

 # Collect actual transcript files (normalize to forward slashes)
 # Exclusions:
 #  - Legacy aggregate files like `2.md` that collapse multiple transcripts (pattern: ^\d+\.md$ with no further dot)
 $actual = Get-ChildItem -Path $srcRoot -Recurse -File |
     Where-Object {
         $_.Name -match '^\d+\.' -and 
         $_.Name -notmatch '^\d+\.md$' -and 
         $_.Name -notmatch 'subtitle|SUBTITLE|SUBTITLES'
     } |
     ForEach-Object { ($_.FullName.Substring($RepoRoot.Length+1)) -replace '\\','/' }

 # Extract references
 $referenced = @()
 Get-ChildItem -Path $courseNotesDir -Filter '*.md' | ForEach-Object {
     $inSources = $false
     $blankToleranceUsed = $false
     Get-Content $_.FullName | ForEach-Object {
         $line = $_
         # Accept either 'Sources:' or '## Sources' (with optional trailing colon/space)
         if ($line -match '^(##\s+Sources:?|Sources:)') { $inSources = $true; $blankToleranceUsed = $false; return }
         if ($inSources) {
             if ($line -match '^\s*$') {
                 if (-not $blankToleranceUsed) { $blankToleranceUsed = $true; return } else { $inSources = $false; return }
             }
             if ($line -match '^# ') { $inSources = $false; return }
             if ($line -match '-\s+`([^`]+)`') { $referenced += (($Matches[1]) -replace '\\','/') }
         }
     }
 }

 # Normalize legacy Module 1 path style (src/1.x.* -> src/Course1-Module1/1.x.*) if actual file present
 $normalizedReferenced = @()
 foreach ($r in $referenced) {
     if ($r -match '^src/1\.(\d+)\.') {
         $candidate = $r -replace '^src/','src/Course1-Module1/'
         if ($actual -contains $candidate) { $normalizedReferenced += $candidate; continue }
     }
     $normalizedReferenced += $r
 }
 $referenced = $normalizedReferenced

 $actualSet = [System.Collections.Generic.HashSet[string]]::new()
 $actual | ForEach-Object { [void]$actualSet.Add($_) }
 $refSet = [System.Collections.Generic.HashSet[string]]::new()
 $referenced | ForEach-Object { [void]$refSet.Add($_) }

$unreferenced = $actual | Where-Object { -not $refSet.Contains($_) }

# Classify unreferenced for clearer reporting
$classified = $unreferenced | ForEach-Object {
    $p = $_
    $name = [System.IO.Path]::GetFileName($p)
    if ($name -match 'MISSING') { [PSCustomObject]@{ Path=$p; Category='MISSING_PLACEHOLDER' } }
    elseif ($name -match 'SUBTITLE|SUBTITLES|subtitle') { [PSCustomObject]@{ Path=$p; Category='SUBTITLES' } }
    elseif ($name -match 'Test your knowledge|Practice Assignment|Challenge') { [PSCustomObject]@{ Path=$p; Category='ASSESSMENT' } }
    else { [PSCustomObject]@{ Path=$p; Category='OTHER' } }
}
 $missing = $referenced | Where-Object { -not $actualSet.Contains($_) }

 # Module numbering gap detection (second-level indices inside each module)
 # For filenames like 2.10.The core skills.txt we treat the part after the first dot as the intra-module index (10)
 # Overview files often use .0. (e.g., 2.0.Overview) which we include but do not require for gap continuity.
 $numberingFindings = @()
 $moduleDirs = Get-ChildItem -Path $srcRoot -Directory | Where-Object { $_.Name -match '^Course1-Module' }
 foreach ($dir in $moduleDirs) {
     $indices = @()
     Get-ChildItem -Path $dir.FullName -File | ForEach-Object {
         $n = $_.Name
         # Skip legacy aggregate like 2.md
         if ($n -match '^\d+\.md$') { return }
         if ($n -match '^\d+\.(\d+)\.') {
             $indices += [int]$Matches[1]
         }
     }
     $indices = $indices | Sort-Object -Unique
     if ($indices.Count -gt 0) {
         $min = ($indices | Measure-Object -Minimum).Minimum
         $max = ($indices | Measure-Object -Maximum).Maximum
         # Allow min to be 0 (overview). For gap detection start at 1 if 0 present.
         $start = if ($indices -contains 1) { 1 } elseif ($indices -contains 0) { 0 } else { $min }
         $expected = $start..$max
         # Exclude 0 from required continuity (i.e., ignore missing 0) but include all >=1
         $required = $expected | Where-Object { $_ -ge 1 }
         $present = $indices | Where-Object { $_ -ge 1 }
         $gaps = $required | Where-Object { $_ -notin $present }
         if ($gaps) { $numberingFindings += "$($dir.Name) intra-module index gaps: $($gaps -join ', ')" }
     }
 }

Write-Host "=== Validate Sources Report ===" -ForegroundColor Cyan
Write-Host "Total transcripts: $($actual.Count)"; Write-Host "Referenced transcripts: $($refSet.Count)"
if ($unreferenced) {
    Write-Host "Unreferenced transcripts (raw list):" -ForegroundColor Yellow; $unreferenced | ForEach-Object { Write-Host "  $_" }
    $grouped = $classified | Group-Object Category | Sort-Object Name
    Write-Host "Unreferenced summary by category:" -ForegroundColor Yellow
    foreach ($g in $grouped) {
        Write-Host "  [$($g.Name)] $($g.Count)"
    }
} else { Write-Host "No unreferenced transcripts." -ForegroundColor Green }
if ($missing) { Write-Host "Missing (referenced but absent):" -ForegroundColor Red; $missing | ForEach-Object { Write-Host "  $_" } } else { Write-Host "No missing referenced files." -ForegroundColor Green }
if ($numberingFindings) { Write-Host "Numbering findings:" -ForegroundColor Yellow; $numberingFindings | ForEach-Object { Write-Host "  $_" } } else { Write-Host "No numbering gaps detected in module directories." -ForegroundColor Green }
