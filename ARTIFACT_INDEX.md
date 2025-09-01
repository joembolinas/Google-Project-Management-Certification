# Artifact Index

Centralized map of key project artifacts with purpose and update cadence.

| Artifact | Path | Purpose | Update Cadence | Source Inputs |
|----------|------|---------|----------------|---------------|
| Project Charter | `1_Project_Files/01_Initiation/Project_Charter.md` | Defines purpose, goals, stakeholders, milestones | Once then on major scope change | N/A (author intent) |
| Project Plan | `1_Project_Files/02_Planning/Project_Plan.md` | Baseline schedule & monitoring approach | Weekly review / on slip | Charter, Journal |
| Risk Register | `1_Project_Files/02_Planning/Risk_Register.md` | Track risks & mitigations | Weekly scan | Plan, Journal |
| Weekly Journal | `1_Project_Files/03_Execution/Weekly_Project_Journal.md` | Reflection & progress log | Weekly (top insertion) | Daily study notes |
| Course 1 Summary | `1_Project_Files/03_Execution/Course_Notes/Course_1_Foundations.md` | Structured foundational concepts | Iterative during Course 1 | `src/1.*.txt` |
| Course 2–6 Summaries | `1_Project_Files/03_Execution/Course_Notes/` | Subsequent course structured notes | As each course progresses | Raw transcripts |
| Lessons Learned Draft | `1_Project_Files/04_Closing/Lessons_Learned_Report_Blog_Draft.md` | Narrative for public blog | After Course 3 midpoint; finalize at end | Charter, Plan, Journal |
| Legacy Reviews (Archived) | `archive/legacy_notes/*.md` | Historical pre-structure summaries | No further expansion (read-only) | Historical |
| Course 1 Progress Log (Archived) | `Foundations of Project Management/progress-log.md` | Original per-course chronological log (superseded by Weekly Journal) | None (archived) | Raw study sessions |
| Archive Plan | `ARCHIVE_PLAN.md` | Migration governance | When phase changes | Repo evolution |
| Copilot Instructions | `.github/copilot-instructions.md` | AI contribution guardrails | When conventions shift | Setup, Charter |
| Setup Guide | `setup.md` | Structural / process blueprint | As process evolves | All artifacts |

## Relationships Diagram (Textual)
```
Raw Transcripts (src) -> Course Notes -> Lessons Learned Draft -> Public Blog Post
             |                |                   ^
             |                v                   |
             +-> Risk & Plan Updates <- Weekly Journal (progress reflection)
```

## Update Workflow Snapshot
1. Capture raw notes (src)
2. Summarize (Course Notes)
3. Reflect (Journal)
4. Adjust Plan/Risks
5. Iterate until all courses complete
6. Finalize Lessons Learned -> Publish externally

---
Status: v0.1 – expand with links to future course summaries as they are created.
