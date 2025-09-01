<#
.SYNOPSIS
    Ensure current week section exists in Weekly_Project_Journal.md and append/update micro-goal completion notes.
.DESCRIPTION
    Determines ISO week span (Mon-Sun). If section for that span is missing, inserts at top (after title) with template.
    Optionally appends a bullet under Tasks Completed.
.PARAMETER RepoRoot
    Repo root path (auto-detected if omitted).
.PARAMETER TaskNote
    Bullet to append under Tasks Completed (skips if already present unless -Force).
#>
[CmdletBinding()]
param(
    [string]$RepoRoot,
    [string]$TaskNote,
    [switch]$Force
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { if ($PSScriptRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path } else { $RepoRoot = (Get-Location).Path } }
$journal = Join-Path $RepoRoot '1_Project_Files/03_Execution/Weekly_Project_Journal.md'
if (-not (Test-Path $journal)) { throw 'Weekly_Project_Journal.md not found.' }

function Get-WeekRange {
    $today = Get-Date
    $dow = [int]$today.DayOfWeek  # Sunday=0
    $monday = $today.AddDays( (-1 * (($dow + 6) % 7)) ) # shift to Monday
    $sunday = $monday.AddDays(6)
    return @{ Start=$monday.ToString('yyyy-MM-dd'); End=$sunday.ToString('yyyy-MM-dd') }
}

function Get-NextWeekNumber([string]$Content) {
    # Find existing week headers like '### Week 2:' and increment, else start at 1
    $matches = Select-String -InputObject $Content -Pattern '^### Week\s+(\d+)\s*:' -AllMatches
    if ($matches) {
        $nums = $matches.Matches | ForEach-Object { [int]$_.Groups[1].Value }
        if ($nums.Count -gt 0) { return ([int]([Math]::Max($nums))) + 1 }
    }
    return 1
}

$r = Get-WeekRange
# Determine if a header for the week range already exists; if not, we will assign next sequential number
$existingHeader = $null
if ($content -match [Regex]::Escape($r.Start)) {
    # Attempt to locate existing week header containing the start date
    $existingHeader = ($content -split "`n") | Where-Object { $_ -match "^### Week .*: $($r.Start) - $($r.End)$" } | Select-Object -First 1
}
$weekNumber = if ($existingHeader) { ($existingHeader -replace '^### Week (\d+).*','$1') } else { Get-NextWeekNumber -Content $content }
$header = "### Week $weekNumber: $($r.Start) - $($r.End)"
$content = Get-Content $journal -Raw -Encoding UTF8
if ($content -notmatch [Regex]::Escape($r.Start) ) {
    Write-Host "Inserting new week section $($r.Start) - $($r.End)" -ForegroundColor Cyan
    $template = @(
        $header,
        '',
        '* Tasks Completed:',
        '* Challenges:',
        '* Key Learnings:',
        '* Plan Next Week:',
        '',
        '---',
        '',
        $content
    ) -join "`n"
    $content = $template
}
if ($TaskNote) {
    $lines = $content -split "`n"
    $idx = ($lines | Select-String -Pattern ([Regex]::Escape($header))).LineNumber
    if ($idx) {
        # find Tasks Completed line
        for ($i=$idx; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match '^\* Tasks Completed:') {
                $insertAt = $i + 1
                # look ahead until blank or next section
                $existingBlock = @()
                for ($j=$insertAt; $j -lt $lines.Count; $j++) {
                    if ($lines[$j] -match '^\* ') { break }
                    if ($lines[$j] -match '^---') { break }
                    if ($lines[$j].Trim() -ne '') { $existingBlock += $lines[$j].Trim() }
                }
                $already = $existingBlock | Where-Object { $_ -like "*${TaskNote}*" }
                if ($already -and -not $Force) { Write-Host 'Task note already present.' -ForegroundColor Green }
                else {
                    $lines = $lines[0..$i] + ("  * $TaskNote") + $lines[($i+1)..($lines.Count-1)]
                    Write-Host 'Inserted task note.' -ForegroundColor Cyan
                }
                $content = $lines -join "`n"
                break
            }
        }
    }
}
Set-Content -Path $journal -Value $content -Encoding UTF8
Write-Host 'Weekly journal update complete.' -ForegroundColor Green
