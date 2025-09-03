<#
.SYNOPSIS
    Generate a new study workspace (clone of governance structure) from this repository template.
.DESCRIPTION
    Creates a target directory with standardized folders, copies governance & workflow files, and inserts
    placeholder values (Goal, Dates, Program Name) into README-like scaffold.

    By default it DOES NOT copy raw transcripts (src/) or historical logs; it creates fresh, empty equivalents.

.PARAMETER TargetPath
    Destination directory to create (must not already exist unless -Force is specified).
.PARAMETER ProgramName
    Logical name of the new certification/program (e.g., "Data Analytics Certificate").
.PARAMETER StartDate
    ISO start date (defaults to today's date).
.PARAMETER TargetDate
    Planned finish date (optional placeholder if not supplied uses YYYY-MM-DD token).
.PARAMETER InitGit
    If specified, runs 'git init' and creates initial commit.
.PARAMETER Force
    Overwrite existing empty directory if present.
.EXAMPLE
    pwsh scripts/New-StudyWorkspaceFromTemplate.ps1 -TargetPath ../data-analytics-cert -ProgramName "Google Data Analytics" -StartDate 2025-09-05 -TargetDate 2026-01-15 -InitGit
#>
[CmdletBinding()] param(
    [Parameter(Mandatory)][string]$TargetPath,
    [Parameter(Mandatory)][string]$ProgramName,
    [string]$StartDate = (Get-Date -Format 'yyyy-MM-dd'),
    [string]$TargetDate = 'YYYY-MM-DD',
    [switch]$InitGit,
    [switch]$Force
)
$ErrorActionPreference = 'Stop'

function Write-Info($msg){ Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Warn($msg){ Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err($msg){ Write-Host "[ERROR] $msg" -ForegroundColor Red }

# 1. Validate target
if (Test-Path $TargetPath) {
    if (-not $Force) { throw "TargetPath '$TargetPath' already exists. Use -Force to reuse if empty." }
    if ((Get-ChildItem -Path $TargetPath | Measure-Object).Count -gt 0) {
        throw "TargetPath '$TargetPath' is not empty; aborting to avoid overwrite."}
} else {
    New-Item -ItemType Directory -Path $TargetPath | Out-Null
}

# 2. Create core directory skeleton
$dirs = @(
    'src',
    '1_Project_Files/01_Initiation',
    '1_Project_Files/02_Planning',
    '1_Project_Files/03_Execution/Course_Notes',
    '1_Project_Files/04_Closing',
    '.github'
)
foreach ($d in $dirs){ New-Item -ItemType Directory -Path (Join-Path $TargetPath $d) -Force | Out-Null }

# 3. Copy governance files (selective)
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$copyMap = @{
    'workflow.json' = 'workflow.json';
    '.github/copilot-instructions.md' = '.github/copilot-instructions.md';
    'WORKSPACE_BLUEPRINT.md' = 'WORKSPACE_BLUEPRINT.md';
}
foreach ($k in $copyMap.Keys){
    Copy-Item (Join-Path $repoRoot $k) (Join-Path $TargetPath $copyMap[$k]) -Force
}

# 4. Generate minimal README scaffold
$readme = @"
# $ProgramName

Structured private knowledge base for capturing raw transcripts, synthesizing insights, and producing a polished public learning narrative.

## Goal
Complete the $ProgramName by $TargetDate.

## Timeline
Start Date: $StartDate  
Target Finish: $TargetDate

## Status (Initialize)
- [ ] Course / Module 1 – Not started

## Quick Links (populate as created)
- Artifact index: `ARTIFACT_INDEX.md` (to-be-created)
- Progress log: `progress-log.md`
- Raw transcripts: `src/`

## Workflow Summary
See `workflow.json` and `WORKSPACE_BLUEPRINT.md` for the standardized raw → synthesis → reflection lifecycle.

---
Scaffold generated $(Get-Date -Format 'u'). Update placeholders before first commit.
"@
Set-Content -Path (Join-Path $TargetPath 'README.md') -Value $readme -Encoding UTF8

# 5. Create empty key artifacts
Set-Content -Path (Join-Path $TargetPath 'progress-log.md') -Value "# Progress Log`n`n## $StartDate`n- Covered: Initialization`n- Key Takeaway: Repository scaffold created.`n- Next Step: Capture first raw transcript.`n" -Encoding UTF8
Set-Content -Path (Join-Path $TargetPath 'glossary.md') -Value "# Glossary`n`n| Term | Definition | Source | Notes |`n|------|------------|--------|-------|`n" -Encoding UTF8
Set-Content -Path (Join-Path $TargetPath 'ARTIFACT_INDEX.md') -Value "# Artifact Index`n`n(Initialize as artifacts are created)" -Encoding UTF8

# Initiation docs placeholders
Set-Content -Path (Join-Path $TargetPath '1_Project_Files/01_Initiation/Project_Charter.md') -Value "# Project Charter`n`n**Program:** $ProgramName`n**Start Date:** $StartDate`n**Target Finish:** $TargetDate`n`n## SMART Goal`nTBD`n" -Encoding UTF8

Set-Content -Path (Join-Path $TargetPath '1_Project_Files/02_Planning/Project_Plan.md') -Value "# Project Plan`n`n## Baseline Schedule`nTBD`n" -Encoding UTF8
Set-Content -Path (Join-Path $TargetPath '1_Project_Files/02_Planning/Risk_Register.md') -Value "# Risk Register`n`n| ID | Risk | Impact | Prob | Score | Response | Owner | Status | Last Review |`n|----|------|--------|------|-------|----------|-------|--------|-------------|`n" -Encoding UTF8
Set-Content -Path (Join-Path $TargetPath '1_Project_Files/03_Execution/Weekly_Project_Journal.md') -Value "# Weekly Project Journal`n`n## Week 1 ($StartDate)`n- Focus: Initialization`n- Notes:`n" -Encoding UTF8
Set-Content -Path (Join-Path $TargetPath '1_Project_Files/04_Closing/Lessons_Learned_Report_Blog_Draft.md') -Value "# Lessons Learned Draft`n`n(Accumulate module snapshots here.)" -Encoding UTF8

# 6. Optional git init
if ($InitGit){
    Push-Location $TargetPath
    git init | Out-Null
    git add .
    git commit -m "chore(init): scaffold $ProgramName workspace" | Out-Null
    Pop-Location
    Write-Info "Initialized git repository and created initial commit."
}

Write-Info "New study workspace scaffold created at: $TargetPath"
Write-Info "Next: Add first raw transcript to 'src/' and update README placeholders."
