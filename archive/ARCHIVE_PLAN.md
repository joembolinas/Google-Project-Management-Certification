# Archive / Migration Plan

## Purpose
Guide the orderly consolidation of legacy note locations (`notes/`, `Foundations of Project Management/`) into the new canonical phased structure under `1_Project_Files/` without data loss or confusion.

## Current State (Post-Early Relocation & Decommission)
- Legacy Course 1 summaries relocated from `notes/` to `archive/legacy_notes/` earlier than originally planned (Phase 3 pulled forward).
- `notes/` directory decommissioned (2025-09-01) and retained only temporarily with placeholders for safe removal; do not repopulate.
- Raw transcripts remain in `src/` (authoritative intake). No relocation planned short-term.

## Target End State
- All active course/module summaries reside ONLY in `1_Project_Files/03_Execution/Course_Notes/`.
- Legacy summaries marked with supersedure banners or moved to `archive/`.
- Images consolidated or referenced consistently (TBD strategy) without duplication.

## Phased Migration
| Phase | Trigger | Actions | Exit Criteria |
|-------|---------|--------|---------------|
| 1 (Completed early 2025-08-31) | Structure created | Add supersedure banners (completed) | Banners added (done) |
| 2 (Skipped) | n/a (nothing left in `notes/`) | Originally: audit legacy vs new | Skipped (empty legacy) |
| 3 (Partially executed early) | Decision to consolidate sooner | Relocate legacy Course 1 files to `archive/legacy_notes/` | Files moved; README & Index updated |
| 4 (Upcoming) | Prior to blog publication | Final cleanup: remove unused image duplicates; verify links | Clean link check pass |

## Decision Log Template
Add decisions below as they occur:

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2025-08-31 | Early relocation of legacy Course 1 notes to archive | Reduce duplication risk early; simplify AI guidance | Phases 2 & 3 merged/accelerated |

## Governance
- Do not delete original legacy files until Phase 3 relocation complete and verified via git diff + manual scan.
- Any assistant proposing automated migration must output a preview file list first.

## Validation Checklist (Each Phase)
- [ ] All supersedure banners present
- [ ] No new content added to legacy directories
- [ ] Course Notes contain Sources section
- [ ] Risk & Plan updated if migration delays impact schedule

---
Status: Rev v0.2 (early relocation executed)
