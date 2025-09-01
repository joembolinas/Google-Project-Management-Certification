<#!
.SYNOPSIS
    Local safety script to prevent accidental push if repository is (or becomes) public while raw transcripts exist.
.DESCRIPTION
    Intended to be called from a Git pre-push hook. Checks remote visibility via GitHub API (requires GH_TOKEN or GITHUB_TOKEN with repo scope) OR falls back to heuristic: presence of a marker file PUBLIC_OK.
    If repo appears public and src/ exists with .txt transcripts, aborts.
.INSTALL
    Create .git/hooks/pre-push (no extension) with:

    #!/usr/bin/env pwsh
    pwsh -File scripts/PrePushGuard.ps1 || exit 1

    Make it executable (on Unix). On Windows Git Bash it will run PowerShell Core if available; else adapt to powershell.exe.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$Owner = 'joembolinas',
    [string]$Repo = 'Google-Project-Management-Certification'
)
$ErrorActionPreference = 'Stop'
$publicOkMarker = Join-Path $RepoRoot 'PUBLIC_OK'
$srcDir = Join-Path $RepoRoot 'src'

function Test-RepoPublic {
    if (Test-Path $publicOkMarker) { return $false } # Marker explicitly allows push
    $token = $env:GH_TOKEN
    if (-not $token) { return $false } # Without token, skip (fail-open)
    try {
        $resp = Invoke-RestMethod -Headers @{Authorization = "Bearer $token"} -Uri "https://api.github.com/repos/$Owner/$Repo" -ErrorAction Stop
        return ($resp.visibility -eq 'public')
    } catch {
        Write-Host 'PrePushGuard: API check failed, skipping visibility enforcement.' -ForegroundColor Yellow
        return $false
    }
}

$repoIsPublic = Test-RepoPublic
if ($repoIsPublic -and (Test-Path $srcDir) -and (Get-ChildItem $srcDir -Recurse -Filter *.txt | Measure-Object).Count -gt 0) {
    Write-Host 'PrePushGuard: Detected public repo with raw transcripts present. Block push.' -ForegroundColor Red
    Write-Host 'Create PUBLIC_OK file to override (acknowledging intentional exposure).'
    exit 1
}
Write-Host 'PrePushGuard: OK' -ForegroundColor Green
