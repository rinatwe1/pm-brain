# PM Brain — Product Requirements Document

**Version:** 0.1 (MVP)
**Date:** 2026-04-25
**Status:** MVP Built, Not Yet Shipped

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

**Mode A: New product**
Run `/brain-init` in an empty product directory. Claude asks 3 questions (one-line description, primary user, stage). Creates full `.pm-brain/` structure with pre-loaded knowledge from 17 PM books. Appends a PM Brain block to existing CLAUDE.md if present.

**Mode B: Existing product with local docs**
Run `/brain-init` then `/brain-import`. The import skill scans recursively for `.md` files, classifies them by type (PRD/spec, policy, tech, flow, research), extracts decisions and knowledge, and maps them to the 6 domains. Appends to existing `.pm-brain/` content — never overwrites.

**Mode C: Existing product with docs in Notion or Confluence**
Status: NOT SUPPORTED in v0.1.
Workaround: export pages to markdown manually, then run `/brain-import`.

---

### Skills

**`/brain-init`**
- Sets up the full `.pm-brain/` memory structure for a product. Pre-populates 6 knowledge domains from the `PM-Brain/knowledge-base/`. Writes `meta.json`, `agents/agents.yaml`, `quality/criteria.md`, and `knowledge/INDEX.md`.
- Use it: once per product, when starting work or when Claude has no product context.
- Input: optional product name. Output: directory structure + JSON summary + human-readable confirmation.
- Limitations: if `PM-Brain/knowledge-base/` is not accessible, writes minimal starter content instead of full frameworks. Does not automatically detect an existing CLAUDE.md in nested directories.

**`/brain-import`**
- Scans current directory for `.md` files, classifies by type, extracts knowledge and decisions, writes to `.pm-brain/` by domain. Shows file count and type breakdown before proceeding.
- Use it: after `/brain-init` when the product has existing specs, PRDs, policy docs, or research files.
- Input: current directory (scans recursively). Output: knowledge appended per domain, decision files created in `decisions/`, `meta.json` updated with import record.
- Limitations: markdown only — no PDF, no Notion, no Confluence. Classification is heuristic (filename-based). Rough import by design; manual cleanup expected.

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

### Knowledge Base

Pre-loaded from 17 PM books, distilled into frameworks, rules, and hypotheses per domain.

| Domain | Frameworks | Rules | Hypotheses | Key books |
|--------|------------|-------|------------|-----------|
| discovery | 6 | 6 | 7 | Mom Test, Continuous Discovery Habits, JTBD, Value Prop Design |
| strategy | 6 | 4 | 6 | INSPIRED, Escaping Build Trap, Lean Startup, Strategize |
| metrics | 5 | 4 | 6 | OKRs Done Right, Lean Product Playbook, Hacking Growth |
| growth | 5 | 4 | 6 | Hacking Growth, Product-Led Growth, Lean Startup |
| ux | 5 | 5 | 6 | Don't Make Me Think, Lean Product Playbook, Value Prop Design |
| roadmap | 5 | 5 | 6 | Strategize, INSPIRED, Escaping Build Trap, OKRs Done Right |

Content is copied from `PM-Brain/knowledge-base/` into `.pm-brain/knowledge/` on `/brain-init`. After that, it accumulates with product-specific content.

---

## 7. Roadmap

### Phase 1 — MVP (v0.1) ✅ Done
- `/brain-init`, `/brain-import` (markdown only)
- `/decision-log`, `/hypothesis`, `/brain-review`
- `competitor-watcher` agent (manual trigger only)
- `install.sh` — symlinks skills to `~/.claude/skills/pm-brain/`
- Orchestrator skeleton (`run.sh` + `setup.sh` — no real invocation yet)
- Knowledge base from 17 PM books across 6 domains

### Phase 1.5 — Usability (pre-v0.2) ← עכשיו
**מטרה:** לפני כל קוד חדש — לוודא שכל אחד יכול להשתמש במערכת ללא כשלים.

- [ ] Usability audit — הליכה על כל ה-flow (install → init → import → daily use) כמשתמש חדש, תיעוד כל נקודת כשל
- [ ] תיקון QUICKSTART — `[repo-url]` placeholder → URL אמיתי, תיקון "reads automatically" (לא נכון לפי PRD section 10)
- [ ] Audit כל skills לerror messages — מה קורה כשמריצים skill בתיקייה לא נכונה? כשאין `.pm-brain/`? כשה-YAML שבור?
- [ ] תיקון `market/` domain gap — brain-init לא יוצר את התיקייה שcompetitor-watcher כותב אליה
- [ ] Test protocol — checklist מוגדר לבדיקת PM Brain על machine חדש

**Criterion to exit:** אדם שלא בנה את המערכת יכול להתקין ולהשתמש בה בלי לשאול שאלות.

### Phase 2 — Synthesis Pipeline (v0.2)
**מטרה:** raw product context (פגישות, interviews, מחקר) → structured evidence. זה ה-compounding שחסר.

**שלב 2a — synthesize-meeting (ראשון, עומק לפני רוחב):**
- [ ] תבנית output מוגדרת — YAML frontmatter, key decisions, open questions, assumptions, quotes, risks, suggested links
- [ ] `/synthesize-meeting` skill — raw meeting notes → structured artifact ב-`.pm-brain/meetings/`
- [ ] Linking engine — skill סורקת decisions/ ו-hypotheses/ קיימים, מציעה קישורים (לא מעדכנת בלי אישור)
- [ ] SNAPSHOT suggestion — בסיום synthesis, מציע מה לעדכן ב-SNAPSHOT, לא מעדכן אוטומטית
- [ ] בדיקה על 3 סוגי meetings שונים

**שלב 2b — synthesis נוספים:**
- [ ] `/synthesize-interview` — user interviews, Teresa Torres style, extracts: quotes, insights, jobs-to-be-done, suggested hypotheses
- [ ] `/synthesize-research` — מאמרים, מחקר מתחרים, תוצרי discovery

**שלב 2c — router:**
- [ ] `/synthesize` — router שמזהה סוג input ומנתב ל-skill המתאים (רק אחרי שיש 3 synthesis types טובים)

**שלב 2d — hooks מכניים:**
- [ ] hook: YAML validation על `.pm-brain/**` אחרי כל עריכה
- [ ] hook: בדיקת required fields חסרים
- [ ] hook: broken links check
- [ ] **לא:** hook שמעדכן SNAPSHOT אוטומטית — זה semantic, לא מכני

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

## 10. Known Limitations (v0.1)

- **No Notion / Confluence support** — markdown import only. Manual export workaround required.
- **Orchestrator is a skeleton** — `run.sh` does not invoke Claude Code. Agents cannot run automatically. Competitor watcher requires manual Claude prompt.
- **`knowledge-updater` and `decision-reviewer` agents are not built** — listed in `agents.yaml` template but no `AGENT.md` exists for either.
- **Skills not auto-loaded** — require `install.sh` to create the symlink. If Claude Code installs to a non-standard path, the symlink may not work.
- **No proactive memory injection** — Claude reads `.pm-brain/` only when the PM references it or a skill is invoked. A PM who forgets to invoke skills gets no benefit.
- **Hypothesis expiry is passive** — expired hypotheses are only surfaced during `/brain-review`. No alert system between reviews.
- **`/brain-review` context ceiling** — large products with many decisions/hypotheses may exceed Claude's effective context window during review.
- **No UI** — everything is markdown files and CLI. Non-technical PMs cannot use v0.1.
- **Single product per Claude Code session** — there is no cross-product query or insight surfacing.
- **`market/` domain not created by `/brain-init`** — competitor-watcher writes to `.pm-brain/knowledge/market/` but this directory is not in the standard init structure. The agent creates it on first run, but the domain is absent from `knowledge/INDEX.md` initially.
