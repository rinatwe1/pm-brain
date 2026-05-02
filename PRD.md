# PM Brain — Product Requirements Document

**Version:** 0.2 (Synthesis Pipeline)
**Date:** 2026-05-02
**Status:** Phase 1.5 + Phase 2 Complete — Not Yet Shipped Publicly

---

## 1. Problem

Claude שוכח הכל. כל שיחה מתחילה מאפס.

A PM working with Claude today faces a daily context tax: re-explaining why a feature was killed last sprint, re-stating tech constraints, re-briefing on competitor positioning. After 90 days, that PM has told Claude the same things hundreds of times — and Claude still doesn't know.

Existing tools don't solve this:
- **AI-SHIPR / verve-pm** — 20+ PM skills for Claude Code, but zero memory. Each session is stateless.
- **Squad AI** — web-based platform with a "foresight engine," but it's a separate tool, not Claude-native.
- **ChatGPT Projects / Memory** — shallow memory for personal preferences, not product knowledge.
- **Notion AI / Confluence AI** — embedded in docs, not in the decision-making workflow.

The gap: no tool gives Claude longitudinal, product-specific memory that accumulates over time. A PM's institutional knowledge — why decisions were made, what was invalidated, what patterns emerged — lives in their head, not in Claude.

---

## 2. Vision

When PM Brain is successful, Claude acts like a senior team member who was in every meeting.

A PM opens Claude Code in their product directory. Without being asked, Claude knows: "We decided not to build X because of Y — should this initiative reconsider that?" It surfaces an expired hypothesis before a sprint starts. It applies discovery rules that were validated six months ago. After 90 days of use, the PM stops re-explaining context and starts having a different quality of conversation — one where Claude challenges assumptions rather than just accepting them.

PM Brain is invisible infrastructure, like git. Install once. It accumulates in the background. The product gets smarter every session.

---

## 3. ICP (Ideal Customer Profile)

**Primary:** Solo or lead PM working on a product in Claude Code — uses Claude daily for writing specs, discovery, decisions, and strategy. Has been frustrated by Claude's statelessness. Technical enough to clone a repo and run `./install.sh`.

**Secondary:** Small PM team (2-4 people) where one PM sets up PM Brain and the team shares `.pm-brain/` via git. Context is now in the repo, not in someone's head.

**Not for:** PMs who don't use Claude Code as their primary AI environment. Non-technical PMs who won't run a bash installer. Teams looking for a visual dashboard or PM tool (that's Phase 4, not MVP).

---

## 4. Competitive Landscape

| Tool | What it does | Memory? | Our advantage |
|------|-------------|---------|---------------|
| AI-SHIPR (verve-pm) | Claude Code PM workflows, 20+ skills, free | No | Memory layer on top of Claude — complementary, not competing |
| Squad AI | Web PM platform with foresight engine | No | Claude Code native, zero context-switching |
| genaipm.com | AI PM skills / education content | No | Practical tool in-workflow, not a course |
| ChatGPT Memory | Shallow personal preferences | Partial | Product-specific, structured, git-committed |
| Notion AI | In-doc AI assistance | No | Lives in the PM's IDE, not in a docs tool |

**Key insight:** AI-SHIPR is the closest. PM Brain could be positioned as the memory layer that makes AI-SHIPR skills work better over time — not a competitor, a complement.

---

## 5. Architecture

PM Brain = the package. `.pm-brain/` = per-product memory.

Inspired by Roman Pichler's 3 blocks (product vision → strategy → tactics), the memory is organized in layers: knowledge (frameworks + confirmed facts), decisions (the "why"), and hypotheses (the "we're betting on").

```
PM-Brain/               ← the tool (install once, forget about it)
├── skills/             ← manual Claude commands
├── agents/             ← agent definitions (AGENT.md per agent)
├── knowledge-base/     ← 17 PM books, pre-distilled, copied on init
├── templates/          ← decision and quality criteria templates
└── orchestrator/       ← agent scheduling (skeleton in v0.1)

your-product/
└── .pm-brain/          ← product memory (data only, no code)
    ├── meta.json
    ├── knowledge/       ← 6 domains × 3 files each
    ├── decisions/       ← one file per decision
    ├── hypotheses/      ← one file per hypothesis
    ├── quality/
    └── agents/
        ├── agents.yaml
        └── logs/
```

Like git: `.pm-brain/` is committed to the product repo. The brain travels with the codebase.

---

## 6. MVP — What's Built (v0.1)

### Onboarding Modes

**Mode A: Existing product with docs**
Run `/brain-init` from the product directory. Claude scans for existing docs, reports what it found, then asks: Quick (read docs + fill gaps only) or Deep (read docs + validate + full discovery). After init, run `/brain-import` to extract decisions and knowledge from all docs.

**Mode B: New product, no docs**
Run `/brain-init`. Claude asks Quick (4 questions, 2 min) or Deep (10 questions, 15 min). Both modes pre-load 7 PM knowledge domains from the knowledge base.

**Note:** brain-init always asks Quick or Deep — regardless of whether docs exist. The user knows better than Claude how reliable their docs are.

**Mode C: Docs in Notion or Google Docs**
- Google Docs → export as .docx, then run `/brain-import`
- Notion → export page as Markdown, then run `/brain-import`
- Confluence → export as Markdown, then run `/brain-import`
- .docx files are supported natively via `textutil` (Mac) or `pandoc`

---

### Skills

**`/brain-init`**
- Sets up the full `.pm-brain/` memory structure for a product. Pre-populates 6 knowledge domains from the `PM-Brain/knowledge-base/`. Writes `meta.json`, `agents/agents.yaml`, `quality/criteria.md`, and `knowledge/INDEX.md`.
- Use it: once per product, when starting work or when Claude has no product context.
- Input: optional product name. Output: directory structure + JSON summary + human-readable confirmation.
- Limitations: if `PM-Brain/knowledge-base/` is not accessible, writes minimal starter content instead of full frameworks. Does not automatically detect an existing CLAUDE.md in nested directories.

**`/brain-import`**
- Scans current directory for `.md` and `.docx` files, classifies by type, extracts knowledge and decisions, writes to `.pm-brain/` by domain. Shows file count and type breakdown before proceeding.
- Use it: after `/brain-init` when the product has existing specs, PRDs, policy docs, or research files.
- Input: current directory (scans recursively, skips code dirs). Output: knowledge appended per domain, decision files created in `decisions/`, `meta.json` updated with import record.
- .docx conversion: uses `textutil` (Mac built-in) or `pandoc` fallback. Graceful skip with instructions if neither available.
- Limitations: no PDF, no Notion API, no Confluence API. Classification is heuristic (filename-based). Rough import by design; manual cleanup expected.

**`/decision-log`**
- Guides a PM through 6 conversational questions to capture a decision with full reasoning: what, why now, alternatives, chosen rationale, trade-offs, and success signal. Searches prior decisions before logging to avoid duplicates. Offers to create a linked hypothesis if the decision rests on an unvalidated assumption.
- Use it: any decision where "why did we do this?" will matter in 3 months.
- Input: conversational. Output: `.pm-brain/decisions/YYYY-MM-DD-{slug}.md` + JSON log.
- Limitations: does not auto-surface related decisions during regular sessions — only searches when `/decision-log` is explicitly invoked.

**`/hypothesis`**
- Logs a product assumption with confidence score (1-10), test method, category, and expiry date. Warns on low confidence (<4), vague test methods, and expiry >90 days. Supports three sub-commands: log new, validate (`/hypothesis validate HYP-001`), kill (`/hypothesis kill HYP-001`). Validated hypotheses confirmed 3+ times auto-promote to `rules.md`.
- Use it: any time building on an assumption that hasn't been validated. Especially before A/B tests, fake-door experiments, or interviews.
- Input: conversational (4 questions). Output: `.pm-brain/hypotheses/HYP-{NNN}-{slug}.md` + JSON log. Categories: retention, acquisition, monetization, engagement, usability, technical.
- Limitations: hypothesis IDs are sequential per product — no cross-product deduplication. Expiry enforcement only happens during `/brain-review`, not proactively.

**`/brain-review`**
- Monthly knowledge maintenance: surfaces expired hypotheses, flags decisions older than 90 days, checks rules for staleness, promotes validated hypotheses to `rules.md`, updates `quality/criteria.md`. Designed to take 10-15 minutes. Conversational — not a form.
- Use it: once a month, or after a major release or pivot.
- Input: reads all `.pm-brain/` content. Output: updated files + JSON summary with counts of expired/validated/promoted/superseded items.
- Limitations: depends entirely on Claude's ability to read `.pm-brain/` in context. On large products with many decisions and hypotheses, context window may limit coverage. Rule staleness detection is heuristic (looks for mentions in `decisions/`).

---

### Agents

**`competitor-watcher`**
- Reads competitor list from `agents.yaml`, fetches public information (website, pricing, feature announcements), compares with existing knowledge in `.pm-brain/knowledge/market/`, extracts new insights, and writes structured updates. If a significant change is found, creates a flag entry in `decisions/`.
- Enable it: set `enabled: true` in `.pm-brain/agents/agents.yaml` and add competitors with URLs.
- Output: appends to `.pm-brain/knowledge/market/knowledge.md` with `[NEW]` / `[CHANGED]` tags. Writes JSON log to `.pm-brain/agents/logs/competitor-watcher-{date}.json`.
- Limitations: public information only — no scraping that violates ToS. Orchestrator in v0.1 is a skeleton (`run.sh` prints a placeholder, does not invoke Claude Code). To run in v0.1: manually trigger from Claude Code with a natural language prompt referencing `AGENT.md` and `agents.yaml`. True scheduling (cron + auto-invoke) is Phase 2.

Agents defined but NOT YET BUILT: `knowledge-updater` (reads Lenny + PM blogs), `decision-reviewer` (flags outdated decisions monthly). Both appear in `agents.yaml` template but have no `AGENT.md`.

---

**`/synthesize`** *(new in v0.2)*
- Router skill: detects input type (meeting / interview / research / competitor / experiment) and routes to the right sub-skill. If unclear — asks one clarifying question only.
- Sub-skills: `/synthesize-meeting`, `/synthesize-interview`, `/synthesize-research`

**`/synthesize-meeting`**
- Converts raw meeting notes (transcript, bullets, email summary) into a structured artifact saved to `.pm-brain/meetings/YYYY-MM-DD-[slug].md`. Extracts: key decisions, open questions, action items, assumptions surfaced, verbatim quotes. Scans `.pm-brain/` for related decisions/hypotheses and suggests links. Proposes SNAPSHOT update — never applies it automatically.

**`/synthesize-interview`**
- Teresa Torres continuous discovery style. Extracts: JTBD, pain points, behavioral patterns, verbatim quotes. Suggests new hypotheses based on pain points. Saves to `.pm-brain/interviews/`.

**`/synthesize-research`**
- Handles: articles, competitor analysis, experiments, AI conversations. Different extraction per type. Saves to `.pm-brain/research/`.

---

### Knowledge Base

Pre-loaded from 13 PM books, distilled into frameworks, rules, and hypotheses per domain.

| Domain | Key books |
|--------|-----------|
| discovery | Mom Test, Continuous Discovery Habits, JTBD, Value Prop Design |
| strategy | INSPIRED, Escaping Build Trap, Lean Startup, Strategize |
| metrics | OKRs Done Right, Lean Product Playbook, Hacking Growth |
| growth | Hacking Growth, Product-Led Growth, Lean Startup |
| ux | Don't Make Me Think, Lean Product Playbook, Value Prop Design |
| roadmap | Strategize, INSPIRED, Escaping Build Trap, OKRs Done Right |
| market | populated by competitor-watcher agent + brain-import |

Content is copied from `PM-Brain/knowledge-base/` into `.pm-brain/knowledge/` on `/brain-init` (Step 3b). After that, it accumulates with product-specific content via `/synthesize`, `/decision-log`, and `/brain-import`.

---

## 7. Roadmap

### Phase 1 — MVP (v0.1) ✅ Done
- `/brain-init`, `/brain-import` (markdown only)
- `/decision-log`, `/hypothesis`, `/brain-review`
- `competitor-watcher` agent (manual trigger only)
- `install.sh` — symlinks skills to `~/.claude/skills/pm-brain/`
- Orchestrator skeleton (`run.sh` + `setup.sh` — no real invocation yet)
- Knowledge base from 17 PM books across 6 domains

### Phase 1.5 — Usability ✅ Done (2026-05-02)
**מטרה:** לפני כל קוד חדש — לוודא שכל אחד יכול להשתמש במערכת ללא כשלים.

- [x] Usability audit — 14 בעיות מזוהות ומתועדות ב-`_docs/usability-issues.md`
- [x] תיקון QUICKSTART + README — URL אמיתי, Quick/Deep מוסבר, troubleshooting מורחב
- [x] Guard clauses לכל skills — decision-log, hypothesis, brain-review בודקות `.pm-brain/` לפני הכל
- [x] תיקון hooks — single quotes bug תוקן, date/updated validation תוקן
- [x] brain-init: לא שואל על תיקייה כשהמשתמש כבר שם (C1)
- [x] brain-init: knowledge-base נטענת ב-Step 3b (C2)
- [x] brain-import: מסנן תיקיות קוד, מטפל ב-0 קבצים, תומך ב-.docx
- [x] Quick/Deep עכשיו מוצג תמיד — גם כשיש docs (החלטה מתועדת ב-decisions/)
- [x] market/ domain: קיים ב-brain-init — לא היה צריך תיקון

**Criterion:** ✅ עמד בקריטריון — flow ברור, הודעות שגיאה לכל כשל, docs מדויקים.

### Phase 2 — Synthesis Pipeline ✅ Done (2026-05-01)
**מטרה:** raw product context (פגישות, interviews, מחקר) → structured evidence. זה ה-compounding שחסר.

- [x] `/synthesize-meeting` — raw meeting notes → structured artifact ב-`.pm-brain/meetings/`
- [x] `/synthesize-interview` — Teresa Torres style, extracts JTBD + quotes + suggested hypotheses
- [x] `/synthesize-research` — articles / competitors / experiments → insights + implications
- [x] `/synthesize` — router שמזהה סוג input ומנתב ל-skill המתאים
- [x] Hooks — YAML validation על `.pm-brain/**` אחרי כל עריכה (מכני בלבד)
- [x] Linking engine — סורקת כל `.pm-brain/` ומציעה קישורים (לא מעדכנת בלי אישור)
- [x] SNAPSHOT suggestion — מציע בסיום synthesis, לא מעדכן אוטומטית

### Phase 3 — Integrations (v0.3)
- [ ] Notion import — connect to Notion API, import pages as knowledge
- [ ] Confluence import — connect to Confluence API
- [ ] `/brain-import` from URL — paste a Notion page URL directly
- [ ] `knowledge-updater` agent — reads Lenny + PM blogs weekly, extracts insights
- [ ] `decision-reviewer` agent — flags outdated decisions monthly (auto, not manual)
- [ ] Orchestrator: real Claude Code invocation from `run.sh`
- [ ] Cron setup script for agent scheduling
- [ ] MCP — Slack, WhatsApp, Notion, Confluence, Jira, Linear, Monday, Figma

### Phase 4 — Team and Distribution (v0.4)
- [ ] GitHub public release + README polish for open source
- [ ] Multi-PM support — `.pm-brain/` in git, team members contribute decisions
- [ ] `/share` — export product brain summary for stakeholders (markdown or PDF)
- [ ] npm or brew install option (remove git clone requirement)
- [ ] Submit to skills-il community

### Phase 5 — Interface (v0.5)
- [ ] Web interface (Lovable / Next.js) — visualize `.pm-brain/` content
- [ ] Dashboard: decisions timeline, evidence links, expired hypotheses, repeated themes
- [ ] Agent control panel — enable, disable, schedule, view logs
- [ ] Paid tier consideration (team features, Notion/Confluence sync)

### Phase 6 — Scale (v1.0)
- [ ] Cross-product insights (optional, if demand)
- [ ] Mobile-friendly interface for async review
- [ ] Analytics: decision outcomes tracking over time

---

## 8. Open Questions

1. **Team sharing:** How do PMs want to share `.pm-brain/` with teammates? Committing to git works technically, but will teams want a review flow before decisions are merged?

2. **Context window limits:** On large products with 50+ decisions and 30+ hypotheses, will Claude reliably read all `.pm-brain/` content before each task — or will it cherry-pick? Does the `knowledge/INDEX.md` routing solve this?

3. **Auto-load vs. manual:** Right now, Claude reads `.pm-brain/` only when the PM references it. Should `/brain-init` write a CLAUDE.md instruction that forces Claude to load memory at session start automatically?

4. **Import quality:** `/brain-import` is filename-heuristic-based. How often will it misclassify docs? Is a rough import good enough, or does misclassification undermine trust in the brain?

5. **Agent invocation model:** Should agents remain Claude-Code-skill-based (you ask Claude to run them), or move to a cron + headless Claude CLI model in Phase 2? The headless path is more powerful but requires more infrastructure.

---

## 9. Success Metrics

**Phase 1 (MVP):**
- `/brain-init` runs successfully on Spirit without errors — creates full `.pm-brain/` structure in <2 minutes
- `/brain-import` imports >80% of Spirit's existing specs with correct domain mapping
- After 30 days of use, Claude references prior decisions without being explicitly asked
- At least one hypothesis is validated or killed (not just logged) within 30 days

**Phase 2:**
- Notion import works end-to-end for at least one product
- `competitor-watcher` runs on schedule without manual trigger
- At least one other PM outside Spirit uses PM Brain and reports it useful

**Phase 3:**
- PM Brain is publicly available (GitHub) with >10 stars in first month
- Multi-PM setup works on a 2-person team without conflicts

---

## 10. Known Limitations (v0.2)

- **No Notion / Confluence API** — requires manual export to .docx or .md before `/brain-import`. PDF not supported.
- **Orchestrator is a skeleton** — agents cannot run automatically. Competitor watcher requires manual Claude prompt. Real scheduling is Phase 3.
- **`knowledge-updater` and `decision-reviewer` not built** — coming Phase 3.
- **No proactive memory injection** — Claude reads `.pm-brain/` only when the PM references it or a skill is invoked. A PM who forgets to invoke skills gets no benefit.
- **Hypothesis expiry is passive** — expired hypotheses surfaced only during `/brain-review`. No alert between reviews.
- **`/brain-review` context ceiling** — large products with 50+ decisions/hypotheses may exceed Claude's effective context window during review.
- **No UI** — everything is markdown files and CLI. Non-technical PMs cannot use v0.2.
- **Single product per Claude Code session** — no cross-product query or insight surfacing.
- **Linking scope unvalidated** — `/synthesize` scans all `.pm-brain/` for links. May produce noise on large projects. Under review (T07 — after first 10 synthesis runs).
