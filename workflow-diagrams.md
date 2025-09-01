# Workflow Diagrams (Internal Reference)

> Purpose: Visual quick reference of the structured study & curation workflow defined in `setup.md` and forthcoming `workflow.json` (machine-readable spec). These diagrams are for internal process alignment and may be selectively redrawn for any future public blog—do **not** publish raw transcript references.

## Legend
- Circle = Trigger / Start
- Rounded Rectangle = Activity / Ritual
- Diamond = Decision / Gate
- Parallelogram = Artifact (Input/Output)
- Hexagon = Automation Script
- Document Icon (Markdown) = Curated File
- Terminator = End / Stable State

(Shapes implied via labels; Mermaid standard nodes used.)

---

## 1. Overall Study Flow
```mermaid
graph TD
  A((Start Study Block)) --> B[Select Next Transcript]
  B --> C[Capture Raw Notes]
  C --> D{Every 2-3 Lectures?}
  D -->|Yes| E[Mini Capture Bullets]
  D -->|No| B2[Next Transcript]
  E --> F{End of Module?}
  B2 --> F
  F -->|No| B
  F -->|Yes| G[Module Synthesis]
  G --> H[Add Sources Block]
  H --> I[Update Weekly Journal]
  I --> J[Update Plan and Risks]
  J --> K{Week Boundary?}
  K -->|Yes| L[New Week Section]
  K -->|No| M[Quality Gate Checks]
  L --> M
  M --> N{All Gates Pass?}
  N -->|No| R[Rework Gaps]
  R --> M
  N -->|Yes| O[Commit and Push]
  O --> P{Course Complete?}
  P -->|No| B
  P -->|Yes| Q[Course Completion Steps]
  Q --> B
```

## 2. Daily Ritual (Focused Micro-Loop)
```mermaid
graph LR
  A((Start Day)) --> B[Open Previous Summary Subsection]
  B --> C[Set Micro Goal]
  C --> D[Open Next Transcript]
  D --> E[Capture Raw Notes + #gloss:]
  E --> F{Time Remaining?}
  F -- Yes --> D
  F -- No --> G[Close Ritual: Journal Quick Entry]
  G --> H[Stage if Coherent Change]
  H --> I((End))
```

## 3. Module Lifecycle
```mermaid
graph TD
  A((Module End Trigger)) --> B[Consolidate Mini Bullets]
  B --> C[Promote to Sections]
  C --> D[Insert Sources]
  D --> E[Module Reflection]
  E --> F[Update Plan Variance]
  F --> G[Update Risk Register]
  G --> H[Validate Sources]
  H --> I[Extract Glossary]
  I --> J[Risk Aging Report]
  J --> K{Issues Found?}
  K -->|Yes| L[Resolve Issues]
  L --> H
  K -->|No| M[Commit Synthesis]
  M --> N((Return to Intake))
```

## 4. Weekly Checkpoint
```mermaid
graph TD
  A((Week Boundary)) --> B[Add Week Section]
  B --> C[Review Plan vs Actual]
  C --> D{Variance > 7 days?}
  D -->|Yes| E[Re-baseline and Log]
  D -->|No| F[Proceed]
  E --> G[Risk Hygiene]
  F --> G
  G --> H[Curate New Resources]
  H --> I[Optional Snapshot Export]
  I --> J((Resume Study))
```

## 5. Artifact Promotion Pipeline
```mermaid
graph LR
  A((Idea or Raw Content)) --> B[Transcript Capture]
  B --> C[Mini Capture Bullets]
  C --> D[Structured Module Sections]
  D --> E[Course Summary]
  E --> F[Lessons Learned Draft]
  F --> G[Public Blog Post]
  B --> D
  D --> F
  E --> G
```

## 6. Risk Management Flow
```mermaid
graph TD
  A((Identify Signal)) --> B[Create Provisional Note]
  B --> C{Recurring Twice?}
  C -- No --> D[Monitor]
  C -- Yes --> E[Formalize in Risk_Register]
  E --> F[Assign Probability & Impact]
  F --> G[Compute Score]
  G --> H{Score High?}
  H -- Yes --> I[Mitigation Action Logged]
  H -- No --> J[Periodic Review]
  I --> K[Risk-Aging-Report.ps1 Flags Stale]
  J --> K
  K --> L{Mitigation Effective?}
  L -- No --> M[Escalate / Re-score]
  L -- Yes --> N[Close Risk]
  N --> O((Archive State))
```

## 7. Automation Scripts Interaction Map
```mermaid
graph TD
  subgraph Intake_Capture
    A1[Raw Transcripts]
  end
  subgraph Curation
    B1[Course Notes]
    B2[Risk_Register.md]
    B3[Weekly_Project_Journal.md]
  end
  subgraph Automation_Scripts
    S1[Validate-Sources.ps1]
    S2[Glossary-Extract.ps1]
    S3[Risk-Aging-Report.ps1]
    S4[Export-PublicSnapshot.ps1]
    S5[PrePushGuard.ps1]
    S6[Add-JournalWeek.ps1]
  end
  A1 --> B1
  B1 --> S1
  B1 --> S2
  B2 --> S3
  B3 --> S4
  B3 --> S6
  S5 -->|Manual pre-push check| A1
  S4 --> OUT[(public snapshot)]
```

---

## Sources & Alignment
Derived from governance rules in `setup.md`, operational workflow spec (pending `workflow.json`), and previously supplied Mermaid diagrams.

## Maintenance Notes
- Update diagrams if workflow.json structure materially changes.
- Keep this file internal: no direct transcript text; only process abstractions.
- When adding new automation, extend Section 7 instead of altering historic nodes.
