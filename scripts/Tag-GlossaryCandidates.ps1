<#
.SYNOPSIS
    Append #gloss:<term> tags to matching lines in provided transcript files.
.DESCRIPTION
    For each -Term, searches each target file line for the first occurrence of the literal term (case-insensitive) not already tagged on that line, then appends ' #gloss:<normalized>' at end.
    Skips lines already containing any #gloss tag for that term. Normalizes term to lowercase.
.PARAMETER RepoRoot
    Root of repository (auto-detected if omitted).
.PARAMETER Terms
    One or more glossary term phrases (quoted if spaces).
.PARAMETER Paths
    Optional relative paths (from repo root) to limit tagging; if omitted scans all txt/md under src/ matching module pattern.
.PARAMETER DryRun
    Show intended changes without writing.
.EXAMPLE
    pwsh scripts/Tag-GlossaryCandidates.ps1 -Terms "scope creep" "stakeholder map" -Paths src/Course1-Module3/3.2.Stakeholders.txt
#>
[CmdletBinding()]
param(
    [string]$RepoRoot,
    [Parameter(Mandatory=$true)][string[]]$Terms,
    [string[]]$Paths,
    [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { if ($PSScriptRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path } else { $RepoRoot = (Get-Location).Path } }
$targets = @()
if ($Paths) {
    foreach ($p in $Paths) {
        $full = Join-Path $RepoRoot $p
        if (-not (Test-Path $full)) { Write-Warning "Path not found: $p"; continue }
        $targets += $full
    }
} else {
    $targets = Get-ChildItem -Path (Join-Path $RepoRoot 'src') -Recurse -File -Include *.txt,*.md | Select-Object -ExpandProperty FullName
}
if (-not $targets) { throw 'No target files resolved.' }

$changes = @()
foreach ($file in $targets) {
    $lines = Get-Content $file -Encoding UTF8
    $modified = $false
    for ($i=0; $i -lt $lines.Count; $i++) {
        foreach ($term in $Terms) {
            $norm = $term.ToLower()
            if ($lines[$i] -match "#gloss:$norm") { continue }
            if ($lines[$i] -imatch ("(^|[^#])" + [Regex]::Escape($term))) {
                # If line already has other gloss tags, still allow adding new term
                $lines[$i] = $lines[$i].TrimEnd() + " #gloss:$norm"
                $modified = $true
                $changes += [PSCustomObject]@{ File=$file; Line=$i+1; Term=$norm }
                break
            }
        }
    }
    if ($modified -and -not $DryRun) {
        Set-Content -Path $file -Value $lines -Encoding UTF8
    }
}
if ($changes) {
    Write-Host 'Tagging summary:' -ForegroundColor Cyan
    $changes | ForEach-Object { Write-Host "  $($_.File) (line $($_.Line)) -> #gloss:$($_.Term)" }
} else { Write-Host 'No tags applied (possibly all already tagged or terms not found).' -ForegroundColor Yellow }
if ($DryRun) { Write-Host 'Dry run only: no files modified.' -ForegroundColor Green }
