# AI Assistant Project Instructions

Purpose: This repo is a structured personal learning project for completing the Google Project Management Professional Certificate. Content is mostly Markdown/text transcripts, progress logs, and planning artifacts—no build system, code compilation, or automated tests.

## Repository Mental Model
- Treat the repository as a living knowledge base + project management workspace.
- Knowledge layers:
  1. Raw intake & transcripts (`src/`) – unedited, sequential course content dumps.
  2. Curated phased artifacts (`1_Project_Files/`), plus root logs and governance (`setup.md`, `ARCHIVE_PLAN.md`).
- Ingestion Rule: Every new artifact (transcript, screenshot filename reference, scratch reflection, ad‑hoc note) starts life in `src/` first. Curation/promotions into `1_Project_Files/` happen only after synthesis or stabilization—never author curated content directly without a raw source.
- Progress tracking lives in three anchors: `progress-log.md` (global), `Foundations of Project Management/progress-log.md` (course/module), and future portfolio artifacts (not yet present).

## Key Directories & Roles
- `src/`: Plain text transcript/note dumps. Keep filenames prefixed with module ordering numbers (e.g., `1.6.What is project management.txt`). Do not rename existing files unless standardizing typos; preserve numeric ordering.
- `archive/legacy_notes/`: Historical legacy summaries (read-only). Do not add new content here.
- `Foundations of Project Management/`: Course‑specific assets: images under `image/` and course progress log. Place any additional module images inside the existing subfolder pattern rather than creating new top-level image roots.
- `1_Project_Files/`: Canonical phased workspace (new). Contains: `01_Initiation/Project_Charter.md`, `02_Planning/Project_Plan.md`, `02_Planning/Risk_Register.md`, `03_Execution/Weekly_Project_Journal.md`, `03_Execution/Course_Notes/` (course summaries), `04_Closing/Lessons_Learned_Report_Blog_Draft.md`.
- Root markdown files:
  - `README.md`: High‑level orientation and status checklist. Update status boxes only when a course milestone meaningfully advances (finish a course / module cluster).
  - `progress-log.md`: High-level chronological daily/weekly entries. Append newest entries at top using existing date heading pattern.
  - `resources.md`: External links & tools only. Keep list concise; group by category.
  - `setup.md`: Long-form procedural & structural guide. Treat as a reference document—avoid mixing ephemeral daily progress here.

## Editing & Content Conventions
- Dates: Use ISO `YYYY-MM-DD` in headings and file names (future posts) for ordering & parseability.
- Checklists: Use GitHub Markdown `[ ]` / `[X]`; only flip to `[X]` when truly complete.
- Tone: Concise, instructional in guides; reflective in logs/journals; neutral in raw transcripts.
- Avoid duplicating the same concept in multiple curated files—reference instead (e.g., link to `setup.md` instead of restating process steps elsewhere). New course/module summaries should go in `1_Project_Files/03_Execution/Course_Notes/`; if updating an older `notes/` file, add a brief "Superseded by: <new file>" line at top.
- Preserve emoji already used (e.g., section icons) but do not introduce inconsistent styling.

## Safe Automation Boundaries
- Assistants may: add new dated progress entries, summarize transcript chunks into structured notes, standardize formatting (headings, tables), add new resource links (grouped).
- Assistants must NOT: delete raw `src/` transcripts, move / reorder numbered transcript files arbitrarily, overwrite reflective journals with generated summaries, introduce executable code/tooling not already adopted (build systems, CI), fabricate progress not achieved, re-populate the now-archived `notes/` path, or remove placeholder sections in new `Course_Notes` stubs without replacing them with real content.

## When Adding New Summaries
1. Identify source transcript files in `src/` (keep references by filename in a "Sources" section).
2. Produce a concise outline (Key Concepts, Definitions, Tools, Examples).
3. Add cross-links back to foundational definitions if they already exist to reduce drift.
 4. Place new structured summary in `1_Project_Files/03_Execution/Course_Notes/` and include a Reflection section.

## Image & Asset Handling
- Keep image assets inside existing `image/` substructure; if adding new modules, follow pattern: `image/progress-log/` or create a new logically named folder under `image/` (snake_case) if necessary.
- Do not embed large base64 images in markdown—reference relative file paths.

## Structural Integrity Checks (Before Commit)
- No orphan large binary files at repo root.
- No accidental duplication of transcripts (check for same numeric prefix + slightly varied title).
- Ensure new markdown files have a top-level `#` heading matching filename intent.
 - Preserve placeholder section headings in `1_Project_Files/` until fully populated.

## Operational Workflow (Authoritative Guide)
This workflow governs daily study, module synthesis, weekly checkpoints, and course transitions.

### Per Lecture (Video / Reading)
1. Download transcript into `src/` using next numeric pattern (`1.<n>.<Title>.txt`).
2. Capture raw bullets only; mark unclear items with `??` (no polishing now).
3. Tag glossary-worthy items inline with `#gloss:<term>` for later grep.

### Micro Block (Every 2–3 Lectures)
1. Skim new transcripts; bold 1–3 high‑value definitions directly where they appear.
2. Add a temporary "Mini Capture" bullet list under the correct Module heading in the in‑progress course summary (`Course_1_Foundations.md`).
3. If a recurring issue (time, clarity) surfaces twice, consider a provisional risk note (queue for formalization).

### End of Module
1. Transform Mini Capture bullets into structured sections: Key Concepts, Definitions, Tools/Techniques, Examples.
2. Add a Sources list citing exact transcript filenames used.
3. Write Module Reflection (What clicked / Struggle / Adjustment) into the current week's block in `Weekly_Project_Journal.md` (add new week via script if boundary crossed).
4. Update `Project_Plan.md` (progress % / variance) and adjust milestones if needed.
5. Update `Risk_Register.md` (add, close, re‑score risks).
6. Commit with message: `feat(moduleX): synthesize & reflect (Course 1 Foundations)`.

### Weekly Cadence (Checkpoint)
1. Insert new week section (script) if it's the first study session of the calendar week.
2. Review plan vs. actual; if slip > 7 days, re‑baseline (Change Log entry).
3. Risk hygiene: confirm each Open High risk still valid.
4. Add new external resources only if they bring unique value (avoid noise).

### After Each Course Completion
1. Mark checkbox in `README.md`; update `ARTIFACT_INDEX.md` if new artifacts formed.
2. Add a "Course X Snapshot" paragraph to `Lessons_Learned_Report_Blog_Draft.md`.
3. Re‑baseline schedule for next course in `Project_Plan.md`.

### Daily Opening Ritual (≤5 min)
1. Select next transcript numerically.
2. Skim yesterday's summary subsection.
3. Set a micro-goal (e.g., "Capture 3 definitions + 1 example").

### Daily Closing Ritual (≤5 min)
1. Journal: Progress / Blocker / Next Focus.
2. Stage and commit if a coherent artifact (summary update, plan change) is ready.

### Quality Gates Before Module Commit
- Every definition traced to a Sources entry.
- No duplicate definitions across sections (link rather than copy).
- Risk / Plan updated if schedule variance or new recurring issue.

### Edge Cases & Handling
- Missing transcript: create placeholder `1.x.<title>-MISSING.txt` to preserve numbering.
- Behind schedule: add risk, scope module synthesis (focus top 3 concepts) to recover.
- New methodology concept repeating across modules: centralize definition once; link later.

### Optional Future Automation (Not Yet Implemented)
- Script to list transcripts missing from any Sources block.
- Glossary tag extractor to build/update a consolidated glossary.

### Principles
- Raw stays messy (`src/`); polish only in `Course_Notes`.
- Single reflection locus: Weekly Journal.
- Cite Sources immediately—avoid retroactive hunts.

---
## Example Tasks & Expected Approach
- "Add today's study reflection": Insert dated block at top of `progress-log.md` maintaining blank line separation.
- "Synthesize Module 1": Follow End of Module steps above; update Course 1 file.
- "Add new resource": Append under correct category in `resources.md`, only if category has ≥2 items after addition.

## Future Expansion Placeholder
- A `portfolio/` directory may be added later; until it exists, do not create speculative folders.

## Interaction Style for AI Agents
- Clarify ambiguities briefly (e.g., missing date) but default to conservative, append-only edits.
- Prefer minimal diffs: touch only lines you change.
- Cite source filenames when generating synthesized content for traceability.

---
If any of these conventions appear outdated as the repository evolves (e.g., new course folders), surface a changelog suggestion instead of silently diverging.

---

## Context Addendum (Holistic Project Brain)
Mission: Master Google PM Certificate concepts and produce a polished public blog post (in a separate `your-username.github.io` repo) that narrates the learning journey. This repo = private knowledge base (workshop). Public site = polished portfolio (gallery).

Workflow (weekly cadence): Capture (raw `src/` transcripts) → Synthesize (`1_Project_Files/03_Execution/Course_Notes/` structured summaries) → Reflect (`progress-log.md` top insertion) → Update Dashboard (`README.md` only on real milestone completion).

Assistant Operating Principles (condensed):
- Preserve raw intake (`src/` immutable except typo filename normalization). Never delete / reorder numbering.
- Synthesize, don’t overwrite reflections; new insight lives in Course Notes with Sources citing exact `src/*.txt` filenames.
- Minimal diffs; keep existing emojis/style; ISO dates; top-level heading present.
- No speculative folders (e.g., `portfolio/`) until they actually exist; mention proposed changes instead.

Structural Guardrails (repeat for clarity): unique numbered transcript filenames, no root binaries, headings start with `#`, resource categories only if ≥2 items.

Changelog Practice: If adopting a new pattern (e.g., adding Course 2 folder), append a short “Proposed Convention Update” block at end of this file instead of silent divergence.

Single Source of Truth: Update this file first when evolving process; summaries should reference it rather than restating governance verbatim.

Transition Note: Early consolidation executed (2025-08-31). Legacy Course 1 summaries relocated to `archive/legacy_notes/`. Former `notes/` directory decommissioned (2025-09-01) and should not be repopulated.
