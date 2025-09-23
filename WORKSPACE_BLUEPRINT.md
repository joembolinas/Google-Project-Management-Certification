# Reusable Study Workspace Blueprint

Purpose: Generalize this repository's governance so you can clone the model for ANY multi-module / multi-course learning program (e.g., Data Analytics cert, Security track) with minimal edits.

## 1. Core Principles (Keep Identical)
- Raw First Intake → Synthesis → Reflection → Planning/Risk Adjustment → Publication.
- Trace every synthesized concept to a raw source filename.
- Append-only history (logs, journals, risk changes) – never rewrite past reflections.
- Explicit quality gates before public-facing promotion.
- Automation assists; it never invents progress.

## 2. Directory Archetype
```
<root>/
  src/                                  # Raw transcripts, scratch captures, placeholders
  1_Project_Files/
    01_Initiation/                      # Charter, scope framing
    02_Planning/                        # Plan, Risk Register, (optionally Schedule exports)
    03_Execution/
      Course_Notes/                     # Structured synthesized module/course notes
      Weekly_Project_Journal.md         # Rolling week-by-week reflections
    04_Closing/
      Lessons_Learned_Report_Blog_Draft.md
  glossary.md
  ARTIFACT_INDEX.md
  progress-log.md                       # High-level global meta log
  workflow.json                         # Machine-readable workflow (update for new program)
  .github/copilot-instructions.md       # AI guardrails
  WORKSPACE_BLUEPRINT.md                # (this file)
```
Adaptation: Keep structure stable. Only add subfolders under `src/` for program-specific module grouping (e.g., `Course2-Module1/`).

## 3. Naming Schema Templates
- Raw transcript file: `<module>.<sequence>.<Title>.txt` (e.g., `3.4.Iterative Planning.txt`).
- Placeholder: `<module>.<sequence>.MISSING.txt`.
- Module subfolders (optional): `CourseX-ModuleY/` when a course spans many modules; internal files still use numeric prefix.
- Never rename after citation except to fix a blocking typo; log the rename in `progress-log.md`.

## 4. Workflow State Mapping (Abstract)
| State | Abstract Trigger | Output Invariant |
|-------|------------------|------------------|
| per_unit_capture | New learning unit consumed | New raw file in `src/` |
| micro_block | Every 2–3 units | Mini Capture bullets present |
| module_synthesis | All (or enough) units for module | Structured sections + Sources |
| validation_phase | Draft complete | Zero unexpected uncited citable raws |
| logging_phase | Validation clean | Journal + plan + risk + index updated |
| optional_public_snapshot | Need sanitized bundle | `dist/` (excluded raw) |
| commit_phase | Logging done | Remote commit |
| next_module_prep | Module finalized | Scaffold for next module |
| weekly_checkpoint | New calendar week | New week header + risk/plan review |
| program_completion | All modules finished | Lessons Learned snapshot finalized |

Reuse: Map your program's terminology (chapter/week/lesson) → unit; (module) → logical grouping for synthesis.

## 5. Quality Gate Abstract Rules
- Each synthesized key concept must trace to ≥1 raw filename.
- No verbatim paragraph-scale copying (OK: short phrases ≤ ~8 words if unavoidable term).
- Glossary terms unique; re-use references instead of redefining.
- Risk register reviewed at least weekly; high risks updated (age < threshold).

## 6. Script Responsibilities (Generalized)
| Script Role | What It Should Do | Portability Consideration |
|-------------|-------------------|---------------------------|
| Add Daily Micro Goal | Insert daily micro-goal block in global log | Date parsing locale-agnostic |
| Add / Update Weekly Journal | Ensure current week block exists; append notes | Week boundary detection |
| Tag Glossary Candidates | Insert `#gloss:<term>` at first occurrence | Idempotent tagging |
| Glossary Extract | List new terms not yet in glossary.md | Diff against existing table |
| Validate Sources | Detect uncited vs missing raw files | Classification rules externally configurable |
| Risk Aging Report (future) | Flag stale high-severity risks | Threshold in workflow.json |
| Export Public Snapshot (optional) | Build sanitized view excluding raw | Exclusion list configurable |
| Pre-Push Guard | Block unsafe push (e.g., raw in public export) | Repo visibility check |

## 7. Configuration Surface
Centralize tweakable values (thresholds, regex patterns, commit message templates) inside `workflow.json`. When cloning for a new program:
1. Duplicate repo (or scaffold from template).
2. Update `workflow.json` keys: `version`, `last_updated`, add new course/module enumerations if desired.
3. Adjust `naming_rules.raw_transcript_pattern` if adopting different prefix logic (e.g., week-based `W1.03.<Title>.txt`).
4. Update `commit_patterns` to reflect new course names.
5. Review `public_export_policy` if artifact set changes.

## 8. Adaptation Checklist (Run Once Per New Program)
- [ ] Clone template repo & rename root directory appropriately.
- [ ] Update README Goal, Timeline, Status checklist.
- [ ] Replace banner assets (optional) but keep `<picture>` pattern.
- [ ] Revise `workflow.json` (`last_updated`, program-specific wording).
- [ ] Initialize `Project_Charter.md` and baseline `Project_Plan.md` (Course list & target dates).
- [ ] Create Module 1 course notes file skeleton with Mini Capture stub.
- [ ] Add first raw transcript in `src/` using naming rules.
- [ ] Run `Add-DailyMicroGoal.ps1` to create initial progress log entry.
- [ ] Add initial glossary placeholder row (if not already) and confirm table headers.
- [ ] Commit with `chore(init): scaffold <Program Name> workspace`.

## 9. Porting to a Different Domain Example
Domain: Data Analytics Certification.
- Map "Lesson" → per_unit_capture.
- Map "Module" (e.g., Data Cleaning) → module_synthesis boundary.
- Additional artifact? Perhaps `Dataset_Experiments.md` under `03_Execution/` — add to `ARTIFACT_INDEX.md` and include in `workflow.json.directories`.
- Update glossary emphasis on statistics terms; scripts remain unchanged.

## 10. Extensibility Guidelines
When adding a NEW automation:
1. Document its purpose + run cadence in `workflow.json.scripts`.
2. Keep parameters optional; prefer deriving context (dates, paths) automatically.
3. Idempotent outputs (re-running doesn't duplicate content).
4. Append a short note to `progress-log.md` when first introduced.

## 11. Minimal Public Export Strategy
Goal: Share synthesized knowledge without leaking raw proprietary/paid content.
- Include: README, curated Course_Notes (paraphrased), Plan (sanitized), Risk Register (sanitize sensitive items), Lessons Learned narrative, Glossary.
- Exclude: `src/`, internal meta logs, temporary stubs, placeholder MISSING files, raw images unless transformed.

## 12. Governance Change Control
Any process modification must:
1. Update `.github/copilot-instructions.md` (single source of truth for agent behavior).
2. Reflect machine-readable change in `workflow.json` if structural.
3. Add progress-log entry summarizing the adjustment.
4. (Optional) Append to a "Changelog" section if cumulative changes become frequent.

## 13. Common Pitfalls & Preventive Controls
| Pitfall | Preventive Control |
|---------|--------------------|
| Transcripts renamed after citation causing broken traceability | Validation script cross-check + rename logging rule |
| Duplicate glossary definitions diverging | Extract script shows existing; manual merge |
| Stale high risks | Aging report threshold & weekly checkpoint gate |
| Over-citation of non-essential raw files (assessments) | Classification exclusion list in validator |
| Scope creep adding unrelated resources | README Resource Snapshot single-source governance |

## 14. Metrics (Adaptable)
Track simple quantitative indicators (update manually or via script later):
- Module Progress % = synthesized_modules / planned_modules * 100.
- Glossary Growth = delta terms per module.
- Risk Churn = opened_this_module + closed_this_module.
- Reflection Cadence = journal_entries / weeks_elapsed.

## 15. Sunset & Archive Pattern
When a course completes and becomes less actively referenced:
1. Move legacy granular logs to `archive/` subfolder preserving paths.
2. Insert a supersession note in any deprecated file.
3. Update `ARTIFACT_INDEX.md` to reflect archived status.

## 16. Quick Start (TL;DR For New Clone)
1. Add Charter & Plan.
2. Capture first transcript in `src/`.
3. Create Course Notes file with Module 1 Mini Capture stub.
4. Log micro-goal and first progress entry.
5. Tag first glossary term; extract & add to glossary.
6. Continue capture → micro-block → synthesis cadence.

---
Version: 1.0 (Generated 2025-09-02)
