<#!
.SYNOPSIS
    Export curated, publishable artifacts to a clean snapshot folder (excludes raw transcripts & private assets).
.DESCRIPTION
    Copies selected files/directories into dist/public-snapshot for staging a public repo/blog.
    Excludes: src/, archive/, notes/, raw images (all under "Foundations of Project Management/image/").
    You can optionally include a curated images folder by passing -IncludeImages and specifying -ImagesSubpaths.
.PARAMETER IncludeImages
    Switch to copy specific image subpaths (safe curated set) into snapshot under images/.
.PARAMETER ImagesSubpaths
    Relative subpaths beneath "Foundations of Project Management/image" to include when -IncludeImages is used.
.EXAMPLE
    ./Export-PublicSnapshot.ps1
.EXAMPLE
    ./Export-PublicSnapshot.ps1 -IncludeImages -ImagesSubpaths progress-log
.NOTES
    Run from repository root or supply -RepoRoot.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [switch]$IncludeImages,
    [string[]]$ImagesSubpaths
)

$ErrorActionPreference = 'Stop'
$dest = Join-Path $RepoRoot 'dist/public-snapshot'
if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
New-Item -ItemType Directory -Path $dest | Out-Null

function Copy-Safe($rel) {
    $srcPath = Join-Path $RepoRoot $rel
    if (Test-Path $srcPath) {
        $targetPath = Join-Path $dest $rel
        $targetDir = Split-Path $targetPath -Parent
        if (!(Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir | Out-Null }
        Copy-Item $srcPath -Recurse -Force -Container:$true
    }
}

# Core curated artifacts
$includeFiles = @(
    'README.md',
    'ARTIFACT_INDEX.md',
    'ARCHIVE_PLAN.md',
    'glossary.md',
    'progress-log.md',
    'resources.md',
    '1_Project_Files/01_Initiation/Project_Charter.md',
    '1_Project_Files/02_Planning/Project_Plan.md',
    '1_Project_Files/02_Planning/Risk_Register.md',
    '1_Project_Files/03_Execution/Weekly_Project_Journal.md',
    '1_Project_Files/03_Execution/Course_Notes/Course_1_Foundations.md',
    '1_Project_Files/04_Closing/Lessons_Learned_Report_Blog_Draft.md'
)

foreach ($f in $includeFiles) { Copy-Safe $f }

# Optionally include selected image subpaths
if ($IncludeImages) {
    foreach ($sp in $ImagesSubpaths) {
        $imgRel = Join-Path 'Foundations of Project Management/image' $sp
        if (Test-Path (Join-Path $RepoRoot $imgRel)) {
            Copy-Safe $imgRel
        } else {
            Write-Warning "Image subpath not found: $imgRel"
        }
    }
}

# Prune placeholders if desired (future enhancement)

Write-Host "Public snapshot exported to: $dest" -ForegroundColor Green
