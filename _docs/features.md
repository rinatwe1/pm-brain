# PM Brain — Features

## Built (v0.1 — shipped 2026-04-25)

### Memory Skills (6)
| Skill | What it does |
|-------|-------------|
| `/brain-init` | Sets up `.pm-brain/` for a product. Scans existing docs first, asks only what's missing. Creates SNAPSHOT.md, 7 knowledge domains, quality criteria, agents config. |
| `/brain-import` | Scans current directory for markdown files, classifies by type, extracts decisions and knowledge, maps to domains. Append-only — never overwrites. |
| `/decision-log` | Guides PM through 6 questions to capture a decision with full reasoning. Searches prior decisions first to avoid duplicates. ADR format. |
| `/hypothesis` | Logs an assumption with confidence score, test method, category, expiry. Supports log / validate / kill. Validated 3x → auto-promoted to rule. |
| `/brain-review` | Monthly: surfaces expired hypotheses, flags old decisions, promotes validated hypotheses to rules, updates quality criteria. |
| `/prd` | Ninja PRD v2.17 adapted for Claude Code. One question at a time, cross-section reuse rule, saves to `.pm-brain/` if initialized. |

### Product OS Skills (6) — inherited from Product OS framework
| Skill | What it does |
|-------|-------------|
| `/discover` | Structured product discovery process — user research, competitor analysis, insights synthesis |
| `/create` | Interactive PRD builder — asks edge cases, identifies NFRs |
| `/verify` | Gap analysis on an existing PRD — scores and suggests improvements |
| `/roadmap` | Execution roadmap from PRD — phases, tasks (PM-only) or features (full-stack) |
| `/dashboard` | Status overview of all products — stage, status, next actions, blockers |
| `/strategy-check` | Monthly strategic review — ICP, competitors, core assumptions (Pichler framework) |

### Agents (1)
| Agent | What it does |
|-------|-------------|
| `competitor-watcher` | Reads competitors from agents.yaml, fetches public info, updates market knowledge. Manual trigger in v0.1 — scheduling is Phase 2. |

### Knowledge Base
- 19 files across 7 domains: discovery, strategy, growth, metrics, ux, roadmap, market
- Sourced from 13 PM books: Mom Test, INSPIRED, Lean Startup, OKRs Done Right, Continuous Discovery Habits, Hacking Growth, Escaping the Build Trap, Product-Led Growth, Strategize, Value Proposition Design, Don't Make Me Think, Lean Product Playbook, Competing Against Luck
- Original synthesis — no verbatim quotes
- Pre-loaded into `.pm-brain/knowledge/` on `/brain-init`

### Infrastructure
- `install.sh` — creates per-skill symlinks to `~/.claude/skills/`
- `tests/` — 3 test scripts, 104 checks (happy path)
- `SNAPSHOT.md` — auto-updated each session, always read first
- `quality/criteria.md` — evolving quality gate per product

---

## Planned

### Phase 2 — Integrations (v0.2)
- Notion API import
- Confluence API import
- `/brain-import` from URL
- `knowledge-updater` agent (Lenny + PM blogs weekly)
- `decision-reviewer` agent (flags outdated decisions monthly)
- Real orchestrator (cron + headless Claude CLI)
- **MCP integrations:** Slack, WhatsApp, Notion, Confluence, Jira, Linear, Monday, Figma
- Local file access (any folder on disk)

### Phase 3 — Team & Distribution (v0.3)
- Multi-PM support (`.pm-brain/` in git, shared)
- `/share` — export brain summary for stakeholders
- npm / brew install (no git clone required)
- Public GitHub release with community outreach

### Phase 4 — Interface (v0.4)
- Web interface (Lovable / Next.js) — visualize `.pm-brain/`
- Dashboard: decisions, hypotheses, knowledge graph
- Agent control panel
- Paid tier consideration

### Phase 5 — Scale (v1.0)
- Cross-product insights
- Mobile-friendly interface
- Decision outcome analytics

---

## Known Limitations (v0.1)
- Markdown import only — no Notion, Confluence, PDF
- Orchestrator is a skeleton — agents need manual trigger
- No proactive memory injection — Claude reads `.pm-brain/` only when invoked
- No UI — CLI only, requires git clone + bash
- Hypothesis expiry is passive — only surfaced during `/brain-review`
