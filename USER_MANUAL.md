# User Manual: Google Project Management Certification Study Workspace

## Table of Contents

1. [Overview & Philosophy](#overview--philosophy)
2. [Quick Start Guide](#quick-start-guide)
3. [Directory Structure & File Purposes](#directory-structure--file-purposes)
4. [Workflow States & Protocols](#workflow-states--protocols)
5. [Naming Conventions & Rules](#naming-conventions--rules)
6. [Automation Scripts Reference](#automation-scripts-reference)
7. [Quality Gates & Validation](#quality-gates--validation)
8. [Daily & Weekly Operations](#daily--weekly-operations)
9. [Troubleshooting & Edge Cases](#troubleshooting--edge-cases)
10. [Advanced Features](#advanced-features)

---

## Overview & Philosophy

This workspace implements a **Raw → Synthesis → Reflection → Publication** methodology for structured learning. Every piece of content starts as raw capture, gets refined through iterative synthesis, and culminates in polished public artifacts.

### Core Principles

1. **Raw First Intake**: Every new learning artifact (transcript, note, reflection) begins in `src/` before curation
2. **Traceability**: Every synthesized concept must cite its raw source filename
3. **Append-Only History**: Logs and journals never rewrite past reflections; only append new insights
4. **Quality Gates**: Explicit validation before committing or publishing
5. **Automation Assists**: Scripts reduce friction but never fabricate progress

### Repository Mental Model

- **Knowledge Layers**:
  - Raw intake (`src/`) – unedited, sequential course content
  - Curated artifacts (`1_Project_Files/`) – structured, synthesized knowledge
  - Meta tracking (logs, plans, risks) – project management overlay

---

## Quick Start Guide

### For New Users

1. **Read the Goal**: Check `README.md` for current learning objectives and timeline
2. **Review Current Progress**: Check status checkboxes and browse existing course notes
3. **Start Daily Capture**: Add new transcripts to `src/` using naming pattern `<module>.<sequence>.<Title>.txt`
4. **Set Micro-Goals**: Use `scripts/Add-DailyMicroGoal.ps1` to plan daily focus
5. **Follow Workflow**: Capture → Mini-blocks → Module synthesis → Reflection → Commit

### Daily Routine (5-10 minutes)

**Opening Ritual:**
```powershell
# Set today's micro-goal
pwsh scripts/Add-DailyMicroGoal.ps1 -MicroGoal "Synthesize Module 3 key concepts"

# Review yesterday's progress
cat progress-log.md | head -20
```

**During Study:**
- Save raw transcripts in `src/` with sequential numbering
- Mark unclear items with `??`
- Tag potential glossary terms with `#gloss:<term>`

**Closing Ritual:**
- Update progress log with today's achievements
- Commit if a meaningful milestone reached

---

## Directory Structure & File Purposes

```
google-pm-cert/
├── src/                              # 🔴 RAW INTAKE (immutable)
│   ├── 1.1.Welcome to Google PM.txt
│   ├── 1.6.What is project management.txt
│   └── ...                           # Sequential numbered transcripts
├── 1_Project_Files/                  # 🟢 CURATED WORKSPACE
│   ├── 01_Initiation/
│   │   └── Project_Charter.md        # SMART goals, scope, timeline
│   ├── 02_Planning/
│   │   ├── Project_Plan.md           # Schedule, milestones, variance tracking
│   │   └── Risk_Register.md          # Active risks with scoring & responses
│   ├── 03_Execution/
│   │   ├── Course_Notes/             # Structured module summaries
│   │   │   └── Course_1_Foundations.md
│   │   └── Weekly_Project_Journal.md # Week-by-week reflections
│   └── 04_Closing/
│       └── Lessons_Learned_Report_Blog_Draft.md
├── scripts/                          # 🔧 AUTOMATION TOOLS
│   ├── Add-DailyMicroGoal.ps1
│   ├── Validate-Sources.ps1
│   ├── Glossary-Extract.ps1
│   └── ...                           # See automation section
├── .github/
│   └── copilot-instructions.md       # AI assistant rules & boundaries
├── archive/                          # 📦 SUPERSEDED CONTENT
├── Foundations of Project Management/ # 🖼️ COURSE-SPECIFIC ASSETS
│   └── image/                        # Screenshots, diagrams
├── README.md                         # 🎯 MAIN ORIENTATION
├── progress-log.md                   # 📝 GLOBAL CHRONOLOGICAL LOG
├── glossary.md                       # 📚 CONSOLIDATED TERMINOLOGY
├── workflow.json                     # ⚙️ MACHINE-READABLE WORKFLOW
├── WORKSPACE_BLUEPRINT.md            # 🏗️ REPLICATION TEMPLATE
└── ARTIFACT_INDEX.md                 # 📋 ARTIFACT CATALOG
```

### File Roles & Usage Rules

| File/Directory | Purpose | Edit Rules | Update Triggers |
|----------------|---------|------------|-----------------|
| `src/` | Raw transcripts | **Immutable** (except typo fixes) | New lecture/reading |
| `Course_Notes/` | Structured summaries | Append sections; cite sources | Module completion |
| `Weekly_Project_Journal.md` | Reflective writing | Append to current week; never edit past | Weekly + module completion |
| `Project_Plan.md` | Schedule tracking | Update variance; log changes | Schedule slip > 7 days |
| `Risk_Register.md` | Risk management | Add/close/re-score risks | Weekly review + blockers |
| `progress-log.md` | High-level events | Top insertion; ISO dates | Daily/weekly milestones |
| `glossary.md` | Terminology | Add terms; link instead of redefining | Module synthesis |

---

## Workflow States & Protocols

The workspace follows a state machine with defined triggers, actions, and outputs:

### 1. Per-Lecture Capture
**Trigger**: New video/reading consumed  
**Actions**:
- Save transcript as `<module>.<sequence>.<Title>.txt` in `src/`
- Mark unclear items with `??`
- Tag glossary candidates with `#gloss:<term>`

**Output**: New raw file ready for synthesis

### 2. Micro-Block (Every 2-3 Lectures)
**Trigger**: 2-3 new transcripts captured  
**Actions**:
- Skim transcripts; bold 2-3 key definitions per file
- Add "Mini Capture" bullets under current module in course notes
- Note emerging patterns/blockers

**Output**: Mini Capture bullet list + enhanced raw emphasis

### 3. Module Synthesis
**Trigger**: Module content complete or sufficient  
**Actions**:
- Transform Mini Capture into structured sections:
  - Overview
  - Key Concepts  
  - Definitions
  - Tools/Techniques
  - Examples/Scenarios
  - Sources (cite exact filenames)
  - Module Reflection

**Quality Gates**:
- All concepts traceable to source files
- No verbatim paragraph copying
- Sources section complete

### 4. Validation Phase
**Trigger**: Module synthesis drafted  
**Actions**:
```powershell
# Run validation scripts
pwsh scripts/Validate-Sources.ps1
pwsh scripts/Glossary-Extract.ps1
pwsh scripts/Risk-Aging-Report.ps1
```

**Decision Points**:
- Uncited transcripts → Add to sources or mark intentionally unused
- New glossary terms → Merge without duplicating
- Stale risks → Update or close

### 5. Logging Phase
**Trigger**: Validation clean  
**Actions**:
- Add module reflection to current week in journal
- Insert top entry in progress-log.md
- Update plan progress % and variances
- Update risk register
- Add module snapshot to lessons learned
- Update artifact index timestamps

### 6. Commit Phase
**Trigger**: All logging complete  
**Actions**:
```bash
git add 1_Project_Files/ progress-log.md glossary.md ARTIFACT_INDEX.md
git commit -m "feat(module3): synthesize & reflect (Course 1 Foundations)"
git push
```

---

## Naming Conventions & Rules

### Raw Transcript Files
**Pattern**: `<module>.<sequence>.<Title>.txt`
- Module: Course module number (1, 2, 3, etc.)
- Sequence: Sequential within module (1, 2, 3, etc.)  
- Title: Descriptive title with spaces allowed
- Extension: Always `.txt`

**Examples**:
- ✅ `1.6.What is project management.txt`
- ✅ `2.3.Stakeholder Analysis Techniques.txt`
- ❌ `Module1_PM_Basics.txt` (wrong pattern)
- ❌ `1.6.What is project management?.txt` (punctuation)

### Placeholder Files
**Pattern**: `<module>.<sequence>.MISSING.txt`
- Use when content expected but not yet available
- Never cite in Sources sections
- Example: `3.4.MISSING.txt`

### Directory Naming
- Use snake_case for new subdirectories
- Keep existing emoji patterns in section headers
- No spaces in directory names

---

## Automation Scripts Reference

All scripts located in `scripts/` directory. Run with PowerShell 7+ (pwsh) for best compatibility.

### Daily Operations

#### Add-DailyMicroGoal.ps1
**Purpose**: Insert daily focus statement in progress log  
**Usage**:
```powershell
pwsh scripts/Add-DailyMicroGoal.ps1 -MicroGoal "Complete Module 3 synthesis"
```
**Behavior**: Creates new date section if needed, adds/updates micro-goal line

#### Update-WeeklyJournal.ps1  
**Purpose**: Ensure current week section exists in journal  
**Usage**:
```powershell
pwsh scripts/Update-WeeklyJournal.ps1
```

### Content Processing

#### Tag-GlossaryCandidates.ps1
**Purpose**: Add `#gloss:<term>` tags to first occurrence of key terms  
**Usage**:
```powershell
pwsh scripts/Tag-GlossaryCandidates.ps1 -TermsToTag "stakeholder,deliverable"
```

#### Glossary-Extract.ps1
**Purpose**: Find tagged terms not yet in glossary.md  
**Usage**:
```powershell
pwsh scripts/Glossary-Extract.ps1
```
**Output**: Lists new terms ready for glossary addition

### Validation & Quality

#### Validate-Sources.ps1
**Purpose**: Verify all transcripts properly cited in course notes  
**Usage**:
```powershell
pwsh scripts/Validate-Sources.ps1
```
**Output**: 
- Unreferenced transcripts in src/
- Missing files referenced in Sources
- Classification summary (assessments, placeholders, etc.)

#### Risk-Aging-Report.ps1
**Purpose**: Flag stale high-priority risks  
**Usage**:
```powershell
pwsh scripts/Risk-Aging-Report.ps1 -ThresholdDays 14
```

### Export & Deployment

#### Export-PublicSnapshot.ps1
**Purpose**: Create sanitized version excluding raw transcripts  
**Usage**:
```powershell
pwsh scripts/Export-PublicSnapshot.ps1 -OutputDir ../public-snapshot
```

#### New-StudyWorkspaceFromTemplate.ps1
**Purpose**: Bootstrap new study workspace from this template  
**Usage**:
```powershell
pwsh scripts/New-StudyWorkspaceFromTemplate.ps1 -TargetPath ../new-cert -ProgramName "Data Analytics" -InitGit
```

---

## Quality Gates & Validation

### Pre-Module Synthesis
- [ ] All planned transcripts captured or placeholders created
- [ ] Mini Capture bullets present for module
- [ ] Key terms tagged with `#gloss:`

### Pre-Commit (Module)
- [ ] Run `Validate-Sources.ps1` → Clean report
- [ ] Run `Glossary-Extract.ps1` → New terms added
- [ ] All required sections populated
- [ ] Module reflection added to journal
- [ ] Progress % updated in plan
- [ ] Risk register reviewed

### Weekly Checkpoint
- [ ] Plan variance assessed (rebaseline if slip > 7 days)
- [ ] High risks updated (age < 14 days)
- [ ] New week section in journal if boundary crossed
- [ ] External resources reviewed for relevance

### Course Completion
- [ ] All modules synthesized and reflected
- [ ] README status checkbox updated
- [ ] Course snapshot added to lessons learned
- [ ] Next course baseline established

---

## Daily & Weekly Operations

### Daily Opening Ritual (≤5 min)
1. Check current date section in progress-log.md
2. Set micro-goal for session
3. Select next transcript numerically
4. Skim yesterday's summary section

### Daily Closing Ritual (≤5 min)
1. Update progress log with achievements/blockers
2. Note next session focus
3. Commit if meaningful milestone reached

### Weekly Checkpoint (15-20 min)
1. **Week Boundary**: Run `Update-WeeklyJournal.ps1` if new week
2. **Plan Review**: Compare actual vs planned progress
3. **Risk Hygiene**: Run `Risk-Aging-Report.ps1` and update stale items
4. **Glossary Maintenance**: Run `Glossary-Extract.ps1` and add new terms
5. **Resource Curation**: Review and consolidate any new external links

### Module Completion (30-45 min)
1. **Synthesis**: Transform mini captures into structured sections
2. **Sources**: Add complete Sources list with exact filenames
3. **Validation**: Run all validation scripts
4. **Reflection**: Write module reflection in journal
5. **Planning**: Update progress % and adjust milestones
6. **Risks**: Add/close/re-score based on new information
7. **Commit**: Use structured commit message

---

## Troubleshooting & Edge Cases

### Common Issues

#### "Validation shows uncited transcripts"
**Cause**: Transcripts in src/ not referenced in Sources sections  
**Solutions**:
- Add missing citations to Sources
- Move non-essential files to "Uncited Raw Artifacts" section
- Confirm intentional omission in progress log

#### "Glossary has duplicate definitions"
**Cause**: Same term defined in multiple places  
**Solutions**:
- Keep first definition; replace others with links
- Use glossary.md as single source of truth
- Run `Glossary-Extract.ps1` to detect conflicts

#### "Schedule slip > 7 days"
**Cause**: Actual progress behind baseline plan  
**Solutions**:
- Add risk to register documenting cause
- Re-baseline dates in Project_Plan.md
- Log change in plan's Change Log section
- Consider scope reduction for recovery

#### "Missing transcript files"
**Cause**: Referenced files not in src/ directory  
**Solutions**:
- Create placeholder: `<module>.<n>.MISSING.txt`
- Update Sources to remove incorrect references
- Check for filename typos or encoding issues

### Script Errors

#### "PowerShell execution policy" 
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### "Cannot find path"
**Cause**: Script run from wrong directory  
**Solution**: Always run from repo root or use full paths

#### "UTF-8 encoding issues"
**Cause**: Special characters in filenames  
**Solution**: Use standard ASCII apostrophes/hyphens; avoid smart quotes

---

## Advanced Features

### Configuration Management

All configurable aspects centralized in `workflow.json`:
- Risk aging thresholds
- Naming pattern validation
- Commit message templates
- Public export policies
- Quality gate definitions

### Custom Workflow States

The state machine in `workflow.json` can be extended for specialized needs:
- Add custom trigger conditions
- Define new quality gates
- Modify automation order

### Public Export Pipeline

The `Export-PublicSnapshot.ps1` creates sanitized versions for public sharing:
- Excludes raw transcripts (copyright protection)
- Includes curated summaries and reflections
- Configurable inclusion/exclusion rules

### Multi-Program Adaptation

Use `WORKSPACE_BLUEPRINT.md` and `New-StudyWorkspaceFromTemplate.ps1` to replicate structure for different certifications:
- Data Analytics tracks
- Security certifications  
- Technical bootcamps
- Language learning programs

### AI Assistant Integration

The `.github/copilot-instructions.md` provides guardrails for AI assistants:
- Preserve raw content immutability
- Enforce citation requirements
- Maintain naming conventions
- Prevent scope creep

### Metrics & Analytics

Track quantitative progress indicators:
```powershell
# Module completion rate
$modules_done = (Get-Content Course_Notes/*.md | Select-String "## Module \d+").Count
$total_modules = 18  # Update per course
$completion_pct = ($modules_done / $total_modules) * 100

# Glossary growth
$term_count = (Get-Content glossary.md | Select-String "^\|").Count - 1

# Risk health
$high_risks = (Get-Content 1_Project_Files/02_Planning/Risk_Register.md | Select-String "High.*Open").Count
```

---

## Support & Maintenance

### Regular Housekeeping

**Monthly**:
- Archive completed course assets to reduce workspace size
- Validate links in README resource section
- Review and consolidate similar glossary terms
- Check for orphaned files not referenced anywhere

**Per Course**:
- Update README status checkboxes
- Re-baseline next course schedule
- Archive legacy course-specific logs
- Export final public snapshot

### Backup Strategy

**Essential Files** (backup regularly):
- `1_Project_Files/` (entire directory)
- `progress-log.md`
- `glossary.md`
- `workflow.json`

**Recoverable Files** (can be regenerated):
- `ARTIFACT_INDEX.md` (script-generated)
- Validation reports
- Public export snapshots

### Version Control Best Practices

**Commit Frequency**: 
- Per micro-goal completion (optional)
- Per module synthesis (required)
- Per weekly checkpoint (if changes)

**Commit Messages**:
- `feat(moduleX): synthesize & reflect (Course N)`
- `docs(journal): add week reflection YYYY-MM-DD`
- `chore(risk): update aging review`

**Branch Strategy**:
- Main branch for stable content
- Optional feature branches for experimental synthesis approaches
- Never commit broken validation states to main

---

*Last Updated: 2025-09-23*  
*Version: 1.0*

For questions or improvements, see `WORKSPACE_BLUEPRINT.md` or review `.github/copilot-instructions.md` for AI assistant capabilities.