
## 1. Starting Module 3 (Day 1 Opening)

Objective: Begin raw capture and set a focused micro-goal.

Scripts / Files / Prompts:

1. Prompt (Chat): Generate daily micro-goal for Module 3 first two lectures (3.1–3.2) focusing on 2 definitions + 1 stakeholder example.
   - Tool behind the scenes: Add-DailyMicroGoal.ps1
   - Result: New block added at top of progress-log.md with Micro-goal line.
2. Download transcripts into `src/Course1-Module3/` with correct numbering (e.g., `3.1.<title>.txt`, `3.2.<title>.txt`).
3. Raw capture: Paste / jot bullet lines (no polishing, mark unclear items with ??).
4. Tag glossary terms inline while they FIRST appear:
   Example lines:
   Stakeholder analysis clarifies influence vs interest. #gloss:stakeholder analysis
   Communication cadence prevents surprise risk surfacing. #gloss:communication cadence
5. Bold 1–2 top definitions (only after first micro-block review):
   **Stakeholder analysis:** systematic review of influence vs interest. #gloss:stakeholder analysis
6. Prompt (Chat): Tag glossary candidates 'stakeholder analysis' 'communication cadence' in module 3 transcripts (dry run).
   - Tool: `sTag-GlossaryCandidates.ps1 -DryRun`
   - If output looks right, re-run without `-DryRun`.

Optional risk check:


### Module 3 Naming & Formatting Conventions (NEW)

| Seq | Example Raw Filename | Include in Sources? | Classification if Excluded | Notes |
|-----|----------------------|----------------------|-----------------------------|-------|
| 3.1 | 3.1.Introduction The project management life cycle and methodologies.txt | Yes | - | Video/readable content |
| 3.2 | 3.2.Exploring the phases of the project life cycle.txt | Yes | - |  |
| 3.3 | 3.3.Case study The significance of each project phase.txt | Yes | - |  |
| 3.4 | 3.4.Test your knowledge Understanding the project life cycle.txt | No | ASSESSMENT | List under Uncited Raw Artifacts |
| 3.5 | 3.5.Phases in action Initiating and planning.txt | Yes | - |  |
| 3.6 | 3.6.Phases in action Executing and closing.txt | Yes | - |  |
| 3.7 | 3.7.Summary of the project phases.txt | Yes | - |  |
| 3.8 | 3.8.Identify Phases of the project life cycle.txt | No | OTHER (activity) | Uncited activity artifact |
| 3.9 | 3.9.Test your knowledge Analyzing the different project phases.txt | No | ASSESSMENT |  |
| 3.10 | 3.10.Introduction to project management methodologies.txt | Yes | - |  |
| 3.11 | 3.11.Overview of Waterfall and Agile.txt | Yes | - |  |
| 3.12 | 3.12.Comparing Waterfall and Agile approaches.txt | Yes | - |  |
| 3.13 | 3.13.Introduction to Lean and Six Sigma.txt | Yes | - |  |
| 3.14 | 3.14.Lean and Six Sigma methodologies.txt | Yes | - |  |
| 3.15 | 3.15.Common project management approaches and how to select one.txt | Yes | - |  |
| 3.16 | 3.16.Identify Project management methodologies.txt | No | OTHER (activity) |  |
| 3.17 | 3.17.Wrap-up.txt | Yes | - |  |
| 3.18 | 3.18.Module 3 Challenge.txt | No | ASSESSMENT | Graded; uncited |

Rules:
1. Predictive learning artifacts (quizzes, graded assignments, plugin-driven activities) are never cited: list under "Uncited Raw Artifacts" with proper classification.
2. If a transcript is unavailable: create `3.x.MISSING.txt` placeholder (classification MISSING_PLACEHOLDER; never cited).
3. Filenames: numeric prefix, period, title words (spaces allowed). Avoid double spaces; replace any platform punctuation (":" "/" "?") with a single space.
4. Normalize smart punctuation to plain ASCII to prevent path mismatch in validation script.
5. Do not retro-edit filenames once cited—stability > cosmetic changes (open a governance update if truly needed).

Raw Capture DO:
- One concept / definition per line (brevity > prose).
- Use `#gloss:<term>` only on first occurrence in a module.
- Bold at most 1–3 definitions per micro-block: `**Term:** short definition #gloss:term`.
- Mark uncertainty with trailing `??` (resolved before synthesis ideally).

Raw Capture AVOID:
- Embedding reflections or synthesis paragraphs.
- Re-tagging glossary terms repeatedly for emphasis.
- Introducing heading hashes inside raw transcript files.

Mini Capture Draft Pattern (inside Course_1_Foundations.md):
```
### Module 3 Mini Capture (Draft)
- Lifecycle phases: initiate → plan → execute → close (control overlays)
- Value: early scope clarity reduces downstream change churn
- Predictive vs adaptive: Waterfall linear / Agile iterative feedback loops
- Lean vs Six Sigma: waste elimination vs variation reduction (process focus)
```

Module 3 Section Stub (prior to full synthesis):
```
# Module 3

Sources:

Uncited Raw Artifacts (Module 3 – assessments / activities / placeholders):
- src/Course1-Module3/3.4.Test your knowledge Understanding the project life cycle.txt
- src/Course1-Module3/3.8.Identify Phases of the project life cycle.txt
- src/Course1-Module3/3.9.Test your knowledge Analyzing the different project phases.txt
- src/Course1-Module3/3.16.Identify Project management methodologies.txt
- src/Course1-Module3/3.18.Module 3 Challenge.txt

### Module 3 Mini Capture (Draft)
*(Bullets to be transformed during synthesis)*
```

Synthesis Conversion Mapping:
- Each Mini Capture bullet → Key Concepts (if definitional), or Examples (if scenario), or Tools (if method/framework) section.
- Reflection content sourced from micro-goal outcomes + blockers noted in weekly journal.

Validation Expectation Pre-Synthesis:
- All Module 3 content files should appear under uncited list until the Sources block is populated.
- Placeholder / assessment / activity files remain in uncited list after synthesis—this is correct.

---

## 2. Micro Block Review (After 2–3 Lectures)

Goal: Convert raw noise into early signal and prep for synthesis momentum.

Actions:

1. Add a temporary “Mini Capture” bullet list under `# Module 3` placeholder in Course_1_Foundations.md (if Module 3 section doesn’t exist yet—create header + placeholder).
2. Prompt: Extract glossary candidates now.
   - Tool: Glossary-Extract.ps1
   - Add any high-value term to glossary.md (only after confirming definition clarity).
3. Prompt: Update weekly journal with note: Completed first Module 3 micro-block (3.1–3.3).
   - Tool: `sUpdate-WeeklyJournal.ps1 -TaskNote "Completed micro-block (3.1–3.3 stakeholder mapping draft defs)"`

---

## 3. Mid-Module Iteration (Lectures 3.4–3.8)

Cycle:

1. Opening: Add new daily micro-goal (e.g., “Clarify escalation path + risk trigger terms”).
2. Capture transcripts (3.4–3.6).
3. Tag new terms (#gloss:escalation path, #gloss:risk trigger) only the first time they appear.
4. Run Tag script with those terms (limit with -Paths if focusing on specific files).
5. Run Glossary-Extract to confirm they register as “New candidate”.
6. If backlog of >5 un-added #gloss terms emerges → escalate risk R06 (Glossary backlog) note in Risk_Register.md (if not already managed).

Edge Case Handling:

- Missed day? Next day’s micro-goal: “Recovery: close capture gap for 3.5–3.6 (no new terms unless essential).”

---

## 4. Pre-Synthesis Gate (All Module 3 Raw Captured)

Checklist (before polishing):

- All numbered Module 3 transcript files exist (gap? create `3.x.MISSING.txt`).
- At most 1–2 unclear ?? flags per file remaining (resolve or leave with explicit follow-up note).
- Glossary tags present for unique candidate terms (no duplicates needed).
- Mini Capture bullets reflect each subtopic (not yet full narrative).

Run:

1. Prompt: Validate sources before module 3 synthesis.
   - Tool: Validate-Sources.ps1
   - Expect: Module 3 transcripts appear as unreferenced (not yet cited).
2. Prompt: Extract glossary candidates (final pre-synthesis view).
   - Compare with glossary.md; add missing high-value ones.

---

## 5. Synthesis (Transform Mini Capture → Structured Sections)

File: Course_1_Foundations.md

1. Add `# Module 3` if not present.
2. Sections to create:
   - Overview (1 concise paragraph)
   - Key Concepts (bullets; each concept tied to a source)
   - Tools / Techniques (if new)
   - Examples / Scenarios
   - Reflection (What clicked / Struggle / Adjustment)
   - Sources: list every used Module 3 transcript path in order.
   - Uncited Raw Artifacts: subtitle / placeholder / unused assessment dumps.
3. Ensure every definition pulled has a corresponding transcript filename in Sources.

Post-edit Validation:

- Run: Validate-Sources.ps1 (expect referenced count increases; only subtitles & placeholders remain unreferenced).
- Run: Glossary-Extract.ps1 (should show zero truly “new” terms if you’ve added them to glossary).

---

## 6. End of Module Admin

Actions:

1. Weekly Journal: Add reflection bullet (Module 3 outcomes, adjustment going forward).
2. Project Plan: Update progress snapshot (Course 1 modules completed / total; variance).
3. Risk Register: Close any mitigated risks (e.g., glossary backlog controlled) or add new one (e.g., “Context drift if Module 4 delayed”).
4. Progress Log: Add top-level date entry summarizing Module 3 synthesis + next step (Module 4 capture or assessment prep).

Commit:

- Message format: feat(module3): synthesize & reflect (Course 1 Foundations)

---

## 7. Weekly Checkpoint (If Week Boundary Crossed)

Sequence:

1. Run Update-WeeklyJournal.ps1 (auto-inserts new week template).
2. Add a task note: “Module 3 synthesis complete; glossary aligned.”
3. Re-baseline if slip >7 days (add Change Log entry in `Project_Plan.md`).
4. Add review line to resources.md if you purposely chose to add none:
   Review Log: 2025-09-10: Reviewed – no additions (maintaining relevance).

---

## 8. Variants & Recovery Scenarios

Scenario A: Forgot to tag terms earlier

- Run Tag script retroactively with -Paths limited to affected files.
- Then run Glossary-Extract and incorporate into glossary.md before synthesis.

Scenario B: Mid-module interruption (3-day break)

- New micro-goal: “Re-orient: skim 3.1–3.4 notes; resume capture at 3.5 with 2 definitions.”
- Add journal note (“Recovered continuity after gap; no schedule slip.”)

Scenario C: Detected numbering gap (missing 3.7)

- Create `3.7.MISSING.txt` placeholder.
- Do NOT cite in Sources; list under Uncited Raw Artifacts.

Scenario D: Glossary duplication risk

- If Glossary-Extract shows term multiple times, keep only one canonical row in glossary.md; leave tags in raw—no cleanup needed.

---

## 9. Tools & When (Condensed Table)

| Phase                 | Script / Action                 | Purpose                      |
| --------------------- | ------------------------------- | ---------------------------- |
| Daily opening         | Add-DailyMicroGoal              | Insert micro-goal line       |
| Raw capture           | Manual + Tag-GlossaryCandidates | Tag emerging terms           |
| Micro block           | Glossary-Extract                | Review new terms             |
| Pre-synthesis         | Validate-Sources                | Identify uncited transcripts |
| Synthesis commit prep | Validate-Sources (again)        | Confirm sources aligned      |
| Post-synthesis        | Update-WeeklyJournal            | Reflection/task note         |
| Weekly boundary       | Update-WeeklyJournal            | Insert new week section      |
| Ongoing               | Glossary-Extract                | Ensure glossary sync         |

---

## 10. Recommended Prompt Templates (Ready to Reuse)

Daily:
Generate daily micro-goal for Module 3 lectures 3.4–3.5: 2 definitions + 1 risk example

Tag Terms:
Tag glossary candidates 'risk trigger' 'communication cadence' in Module 3 transcripts and list new glossary candidates

Validate:
Validate sources before finalizing Module 3 synthesis

Journal Update:
Journal note: Captured Module 3 3.4–3.6; tagged risk trigger + escalation path

Synthesis Kickoff:
Prepare Module 3 synthesis outline sections (Overview, Key Concepts, Examples) from tagged transcripts (no reflection yet)

Finalization:
Add Module 3 sources + reflection and re-run validation

---

## 11. Quality Gate Before Commit

Pass checklist:

- All Module 3 sources listed + validated.
- Reflection present (insight + adjustment).
- No “OTHER” unreferenced items except intentional (subtitle/placeholder).
- Glossary extraction shows zero new uncaptured terms.
- Progress snapshot updated.

---

## 12. Quick Failure Troubleshooting

Problem → Fix:

- Validation still shows unreferenced proper transcript: Confirm file path casing & UTF-8 characters; re-run validator.
- Glossary-Extract shows term but you don’t want it: Leave tag (harmless) or manually remove #gloss:term from raw file.
- Duplicate week headers: Remove the accidental extra header manually; script will increment next time correctly.

---

You can trigger any phase just by asking with one of the prompt templates—scripts are module-agnostic, so the same flow applies straight through Courses 2–6 with only folder names and numbering changing. Let me know if you want an actual Module 3 header stub inserted now. GitHub Copilot
