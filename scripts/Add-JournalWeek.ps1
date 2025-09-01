<#
.SYNOPSIS
  Inserts a new weekly journal block at the top of Weekly_Project_Journal.md after the title line.

.DESCRIPTION
  Calculates the next week number by scanning existing headings matching '### Week N:'.
  Accepts optional start date; defaults to today. End date = start + 6 days.

.PARAMETER StartDate
  ISO (YYYY-MM-DD) start date for the new week. If omitted, uses today's local date.

.EXAMPLE
  ./Add-JournalWeek.ps1

.EXAMPLE
  ./Add-JournalWeek.ps1 -StartDate 2025-09-08
#>
param(
    [string]$StartDate
)

$journalPath = Join-Path $PSScriptRoot '..' '1_Project_Files' '03_Execution' 'Weekly_Project_Journal.md'
if (!(Test-Path $journalPath)) { throw "Journal file not found at $journalPath" }

# Resolve start date
if (-not $StartDate) { $start = Get-Date } else { $start = Get-Date $StartDate }
$start = [DateTime]::Parse($start.ToString('yyyy-MM-dd'))
$end = $start.AddDays(6)

# Read file
$content = Get-Content $journalPath -Raw

# Determine next week number
$weekMatches = Select-String -InputObject $content -Pattern '### Week (\d+):' -AllMatches
if ($weekMatches) {
    $nums = $weekMatches.Matches | ForEach-Object { [int]$_.Groups[1].Value }
    $nextWeek = ($nums | Measure-Object -Maximum).Maximum + 1
} else {
    $nextWeek = 1
}

$newBlock = @"
### Week $nextWeek`: $($start.ToString('yyyy-MM-dd')) - $($end.ToString('yyyy-MM-dd'))
* Tasks Completed:
* Challenges:
* Key Learnings:
* Plan Next Week:

"@

# Insert after title and any blank line that follows
$lines = $content -split "`r?`n"
$titleIndex = ($lines | Select-String -Pattern '^# Weekly Project Journal$').LineNumber - 1
if ($titleIndex -lt 0) { throw 'Title heading not found.' }

# Find insertion point: after title + following blank lines + template section if present
$insertIndex = $titleIndex + 1
while ($insertIndex -lt $lines.Length -and $lines[$insertIndex].Trim() -eq '') { $insertIndex++ }

# If template marker present, insert after it
$templateMarkerIndex = ($lines | Select-String -Pattern '^\(Add weekly dated sections' | ForEach-Object { $_.LineNumber - 1 })
if ($templateMarkerIndex) { $insertIndex = ($templateMarkerIndex | Sort-Object -Descending | Select-Object -First 1) + 1 }

$updated = @()
$updated += $lines[0..($insertIndex-1)]
$updated += $newBlock.TrimEnd()
$updated += ''
$updated += $lines[$insertIndex..($lines.Length-1)]

$updated -join "`r`n" | Set-Content $journalPath -Encoding UTF8
Write-Host "Inserted Week $nextWeek block ($($start.ToString('yyyy-MM-dd')) - $($end.ToString('yyyy-MM-dd')))" -ForegroundColor Green
