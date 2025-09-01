# Tooling Guide

Central reference for local automation scripts supporting the Google PM Certificate workspace.

> Conventions: Run scripts from repository root in PowerShell unless noted. All scripts are additive/read-only unless explicitly copying or exporting.

## Index

| Script                                | Purpose                                                  | Key Actions                                              |
| ------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
|  `scripts/AdJournalWeek.ps1`        | Insert a new weekly journal section scaffolding          | Detects current week, appends template if missing        |
| `scripts/Export-PublicSnapshot.ps1` | Build a curated export excluding private raw transcripts | Copies selected artifacts into `dist/public-snapshot/` |
| `scripts/Validate-Sources.ps1`      | Cross-check Course Notes Sources vs. actual transcripts  | Lists unreferenced & missing transcript paths            |
| `scripts/Glossary-Extract.ps1`      | Surface new `#gloss:` terms not in `glossary.md`     | Scans `src/`, reports candidate terms                  |
| `scripts/Risk-Aging-Report.ps1`     | Flag stale / high risks in register                      | Parses risk table & highlights conditions                |
| `scripts/PrePushGuard.ps1`          | Prevent accidental public push of raw transcripts        | For Git pre-push hook; blocks if repo public             |

---

## 1. Add-JournalWeek.ps1

Purpose: Maintain a consistent weekly reflection cadence without manual date formatting.

Usage:

```
pwsh scripts/Add-JournalWeek.ps1
```

Behavior:

- Locates `Weekly_Project_Journal.md`.
- Checks if current ISO week already has an entry; if not, inserts a template section.
- Leaves existing weeks untouched.

When to Run: First session of the calendar week before adding new reflection content.

---

## 2. Export-PublicSnapshot.ps1

Purpose: Prepare a sanitized set of publishable artifacts (no raw Coursera transcripts) for a public repo or blog staging.

Usage (basic):

```
pwsh scripts/Export-PublicSnapshot.ps1
```

Include selected image subfolders:

```
pwsh scripts/Export-PublicSnapshot.ps1 -IncludeImages -ImagesSubpaths progress-log
```

Output:

- Creates/overwrites `dist/public-snapshot/`.
- Copies curated markdown (charter, plan, risk register, course notes, journal, lessons learned draft, top-level docs).
- Excludes: `src/`, `archive/`, `notes/`, and all images unless explicitly included.

Scenarios:

- Publishing periodic learning snapshot.
- Preparing for open-source release with sanitized content.

---

## 3. Validate-Sources.ps1

Purpose: Enforce traceability between raw transcripts and synthesized Course Notes.

Usage:

```
pwsh scripts/Validate-Sources.ps1
```

Output Sections:

- Total transcripts / Referenced transcripts counts.
- Unreferenced transcripts: Files in `src/` not yet cited.
- Missing referenced files: Paths cited in Sources blocks that do not exist.
- Numbering gaps (Module 1 heuristic): Flags missing sequence numbers.

Act On:

- Add uncited important transcripts to Sources if used.
- Remove or ignore low-value transcripts intentionally unsynthesized (optionally annotate later).
- Investigate any missing referenced file (rename mismatch?).

---

## 4. Glossary-Extract.ps1

Purpose: Shortlist glossary candidates before manual curation to `glossary.md`.

Usage:

```
pwsh scripts/Glossary-Extract.ps1
```

Behavior:

- Finds `#gloss:<term>` tags across `src/`.
- Compares lowercase terms to existing Terms table (excluding placeholder row).
- Prints new candidate terms + multi-tag duplicates (for consolidation).

Workflow Integration:

1. Tag terms inline during raw capture.
2. Run extractor during module synthesis.
3. Add stable definitions to `glossary.md` (≤25 words) and remove extra duplicate tags from future transcripts.

---

## 5. Risk-Aging-Report.ps1

Purpose: Maintain proactive risk hygiene; surface items needing review.

Usage:

```
pwsh scripts/Risk-Aging-Report.ps1
```

Optional parameters:

```
pwsh scripts/Risk-Aging-Report.ps1 -StaleDays 10
```

Behavior:

- Reads `Risk_Register.md` table.
- Flags rows with High status.
- Flags rows with `Last_Review` older than configured stale threshold.
- Flags rows missing a `Last_Review` date.

Action Steps:

- Update `Last_Review` after analyzing each risk weekly.
- Mitigate or downgrade persistent High risks; document response.

---

## 6. PrePushGuard.ps1

Purpose: Safety net to avoid exposing proprietary/raw transcript content if repository visibility changes.

Installation (local only, not committed):
Create `.git/hooks/pre-push` (Unix) or `.git/hooks/pre-push` via Git Bash on Windows:

```
#!/usr/bin/env pwsh
pwsh -File scripts/PrePushGuard.ps1 || exit 1
```

(Ensure executable permission on Unix: `chmod +x .git/hooks/pre-push`.)

Override Mechanism:

- Create an empty `PUBLIC_OK` file at repo root to bypass block.

Behavior:

- If GH_TOKEN provided and repo is public + `src/` contains `.txt` transcripts → abort push.
- Otherwise prints "PrePushGuard: OK".

Use Cases:

- Prior to cloning curated artifacts into a public mirror.
- During long-term private study before licensing decisions.

---

## Recommended Run Cadence

| Script                | Trigger                        | Frequency                  |
| --------------------- | ------------------------------ | -------------------------- |
| Add-JournalWeek       | First study session of week    | Weekly                     |
| Validate-Sources      | Before module synthesis commit | Per module                 |
| Glossary-Extract      | After tagging new terms        | Per module / micro-block   |
| Risk-Aging-Report     | During weekly checkpoint       | Weekly                     |
| Export-PublicSnapshot | Preparing public snapshot      | Ad hoc                     |
| PrePushGuard          | (Installed)                    | Runs automatically on push |

---

## Future Enhancements (Ideas)

- Combine Validate + Glossary extraction into a single dashboard script.
- Add JSON export option for snapshot (machine ingest for blog generator).
- Extend Risk report with risk scoring trend.
- Add transcript gap detection across all modules (not just Module 1).

---

Last updated: 2025-09-01
