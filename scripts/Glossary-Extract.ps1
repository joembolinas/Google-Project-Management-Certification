<#!
.SYNOPSIS
    List #gloss:<term> tags in src/ not yet present in glossary.md Terms table.
.DESCRIPTION
    Scans raw transcripts for pattern '#gloss:<term>' and compares against existing Terms table in glossary.md.
    Outputs new candidate terms and duplicates.
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
        $candidate = Get-Location
        if (Test-Path (Join-Path $candidate 'scripts')) { $RepoRoot = $candidate.Path } else { $RepoRoot = (Resolve-Path '..').Path }
    }
}
$srcRoot = Join-Path $RepoRoot 'src'
$glossFile = Join-Path $RepoRoot 'glossary.md'

if (-not (Test-Path $glossFile)) { throw "glossary.md not found" }

$existing = @{}
(Get-Content $glossFile) | ForEach-Object {
    if ($_ -match '^\|\s*([A-Za-z0-9 \-\/]+)\s*\|') {
        $term = $Matches[1].Trim()
        if ($term -and $term -ne '(placeholder)') { $existing[$term.ToLower()] = $true }
    }
}

$found = @{}
Get-ChildItem -Path $srcRoot -Recurse -File -Filter *.txt | ForEach-Object {
    $rel = $_.FullName.Substring($RepoRoot.Length+1)
    Get-Content $_.FullName | Select-String -Pattern '#gloss:([^\s]+(\s[^\s]+)*)' -AllMatches | ForEach-Object {
        foreach ($m in $_.Matches) {
            $term = $m.Groups[1].Value.Trim().ToLower()
            if (-not $found.ContainsKey($term)) { $found[$term] = @() }
            $found[$term] += $rel
        }
    }
}

$new = $found.Keys | Where-Object { -not $existing.ContainsKey($_) }
$duplicates = $found.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }

Write-Host "=== Glossary Extract ===" -ForegroundColor Cyan
if ($new) { Write-Host 'New candidate terms:' -ForegroundColor Green; $new | Sort-Object | ForEach-Object { Write-Host "  $_ -> $($found[$_].Count) occurrence(s)" } } else { Write-Host 'No new terms found.' -ForegroundColor Yellow }
if ($duplicates) { Write-Host 'Terms tagged multiple times:' -ForegroundColor Yellow; foreach ($d in $duplicates) { Write-Host "  $($d.Key) ($($d.Value.Count))" } } else { Write-Host 'No multi-tag duplicates.' -ForegroundColor Green }
