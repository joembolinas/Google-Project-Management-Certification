
# Summarize the public repo: `Lyellr88/MARM-Systems` (MARM v2.0)

**Overview**

- **Project:** MARM (Memory Accurate Response Mode) v2.0
- **Goal:** A structured protocol + reference web chatbot for controlling AI conversation memory, reasoning transparency, and continuity across sessions.
- **Core Idea:** Users manually direct and audit “memory” rather than relying on opaque, automatic model retention—reducing drift and hallucinations.
- **Model Backend:** Meta Llama 4 Maverick via Replicate (expert-mixture, multimodal, cost-focused).
- **License:** MIT (name/versioning reserved for official repo).

**Problem It Solves**

- **Context loss:** Long chats lose coherence; MARM enforces explicit session structure.
- **Hallucination & drift:** Manual logging + reseeding promotes grounded answers.
- **Opaque reasoning:** Commands like `/show reasoning` expose logic trails.
- **Inconsistent reuse across platforms:** `/summary:` emits portable reseed blocks.

**Protocol Concepts**

- **Manual Memory:** Users curate logs (`/log session:` + `/log entry:`).
- **Session Relay Tools:** `/summary:` produces one-line-per-entry digest for re-injection.
- **Knowledge Layer:** `/notebook` stores reusable user directives (add/use/show/status/clear).
- **Accuracy Layer:** `/deep dive` (deliberate contextual answer), `/show reasoning` (trace), `/refresh marm` (reset/reaffirm).
- **Reseeding Workflow:** Summarize → start new chat → paste reseed block → continue with retained context.

**Key Commands (Categories)**

- **Session:** `/start marm`, `/refresh marm`
- **Logging:** `/log session: Name`, `/log entry: [YYYY-MM-DD | Topic | Summary]`
- **Summarizing:** `/summary: SessionName` (generates reseed block)
- **Knowledge:** `/notebook add: key value`, `use:`, `show:`, `status:`, `clear:`
- **Reasoning & Depth:** `/deep dive ...`, `/show reasoning`
- **Advanced:** `/deep dive` + notebook activation + reseeding patterns for multi-day projects.

**Feature Highlights**

- **Session memory kernel** (structured context assembly)
- **Portable summaries** (copy/paste continuity across tools)
- **Notebook memory activation** (selective “knowledge” injection)
- **File upload + analysis** (text/code highlighting)
- **Voice synthesis** (TTS playback)
- **Session persistence & naming** (browser storage)
- **Security:** XSS filtering + sanitized rendering
- **UI:** Glassmorphism chat interface, command menu, dark-mode aesthetics.

**Architecture**

- **Web Frontend:** Static UI (`index.html`, modular CSS, animations).
- **Logic Modules (`webchat/src/logic/`):**
  - `marmLogic.js` (protocol engine)
  - `notebook.js` (KV store semantics)
  - `session.js` (session persistence)
  - https://github.com/lyellr88/marm-systems/tree/main/webchat/src/logic/summary.js#L0-L96 (log + conversation synthesis w/ retry)
  - https://github.com/lyellr88/marm-systems/tree/main/webchat/src/logic/constants.js#L31-L39 (prompt & protocol text)
  - `storage.js` (validated localStorage access)
  - `utils.js` (validation/debounce/helpers)
  - `xssProtection.js` (allowlist-based filtering)
- **Backend (`chatbot/server.js`):** Express server invoking Replicate API via `replicateHelper.js` (request body config: `temperature`, `max_tokens`, `top_p`).
- **Docs Layer:** Extensive Markdown set: `README`, `PROTOCOL`, `HANDBOOK`, `SETUP`, `CHANGELOG`, `ROADMAP`, `DESCRIPTION`, `FAQ`, `CONTRIBUTING`.

**Data & Flow (Typical Session)**

1. `/start marm` initializes protocol state.
2. `/log session: ProjectAlpha` defines scope.
3. `/log entry:` lines accumulate structured trace.
4. `/notebook add:` seeds durable intents/style/facts.
5. Work iterates with `/deep dive` for depth; `/show reasoning` to verify.
6. `/summary: ProjectAlpha` emits concise digest (one line per log entry + conversation synthesis).
7. New environment: paste reseed block → restore working memory.

**Security & Reliability Measures**

- **XSS mitigation:** Centralized sanitization & output filtering.
- **Input validation:** Enforced date/topic format in logs.
- **Graceful fallbacks:** Summary retry path if API shape differs.
- **Manual control:** No hidden auto-memory; transparency prioritized.

**Performance Considerations**

- **Model choice:** Mixture-of-experts (active subset for speed/cost).
- **Response tuning:** Adjustable `temperature`, `top_p`, `max_tokens`.
- **Lazy module loading & modular ES6 separation** (post-refactor).
- **Refactors (v2.0):** Separation of HTML/JS, elimination of memory leaks, improved cache handling.

**Limitations (Stated)**

- No autonomous execution or tool running.
- No persistent “true” memory—user must reseed.
- Long sessions still require periodic summaries to avoid drift.
- Not intended for regulated/high-risk domains without human review.

**Primary Use Cases**

- Long-form analytical threads (research, BI, product planning).
- Multi-session project continuity.
- Accuracy-sensitive drafting (policies, specs) with reasoning inspection.
- Educational scaffolding (teaching structured thinking).
- Cross-LLM context handoff via exported summaries.

**Not Optimized For**

- Casual chit-chat
- Fully automated agent frameworks
- Black-box “set and forget” memory.

**Quick Local Setup (Condensed)**

1. Clone repo.
2. Install Node.js (v16+).
3. Create `.env` with Replicate API token.
4. Install dependencies in `webchat/`.
5. Start server; open browser to local URL.
6. Run commands directly in the chat UI.
   (Full details in SETUP.md.)

**Roadmap Direction (From Docs/Roadmap)**

- Expansion of protocol variants & tooling integrations.
- Enhanced multi-provider or multi-model flexibility.
- Additional automation hooks (n8n/Zapier examples).
- Continued hardening (security & performance).

**Changelog Themes (v2.0)**

- Major protocol overhaul (command syntax clarity).
- Migration to Llama 4 Maverick.
- Security patches (XSS, runtime stability).
- Documentation consolidation & restructuring.
- Removal of ambiguous automation features.

**Differentiators**

- Radical transparency: explicit memory lifecycle.
- Portable session continuity (reseeding paradigm).
- Structured, inspectable reasoning workflow.
- Hybrid of protocol specification + runnable reference implementation.

**License & Name Usage**

- MIT for code.
- Official branding/versioning reserved for canonical repository; forks must signal unofficial status.

**If You Need Deeper Help**

- I can: extract a command quick-reference, outline an adoption workflow, or map protocol concepts to your own project processes. Just ask.

Want a distilled cheat sheet or an adoption guide next? Let me know.
