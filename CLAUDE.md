# PM Brain — Project Context

> **Note for Claude:** When a user opens PM-Brain in Claude Code, they are likely here to edit skills or agents — not to run /brain-init. If they want to initialize a product, redirect them: "פתח/י Claude Code בתיקיית המוצר שלך (לא כאן) ורשום /brain-init שם."

**Owner:** רינת ווייס  
**Created:** 2026-04-25

## Architecture

PM Brain = the PACKAGE. `.pm-brain/` = per-product MEMORY.

Like git: install once, `.pm-brain/` appears in each product directory.

```
PM-Brain/           ← this repo (the tool)
├── skills/         ← manual commands
├── agents/         ← agent definitions (the "how")
├── knowledge-base/ ← pre-loaded PM frameworks (copied on init)
├── templates/      ← reusable templates
└── orchestrator/   ← agent scheduling

your-product/
└── .pm-brain/      ← product memory (data only, no code)
    ├── meta.json
    ├── knowledge/
    ├── decisions/
    ├── quality/
    └── agents/agents.yaml
```

## Skills (manual)
| Skill | Description |
|-------|-------------|
| `/brain-init` | Initialize .pm-brain/ for a product |
| `/brain-import` | Import existing docs into .pm-brain/ |
| `/decision-log` | Record a decision with full reasoning |
| `/hypothesis` | Track an assumption through validation |
| `/brain-review` | Monthly pruning + promotion |

## Agents (autonomous)
Agent definitions live in `agents/`. Product-specific config lives in the product's `.pm-brain/agents/agents.yaml`.

Each agent has:
- `AGENT.md` — instructions (what to do, how to do it)
- Standard JSON output schema (see below)

## Standard agent output schema
All agents write this JSON to `.pm-brain/agents/logs/`:
```json
{
  "agent": "agent-name",
  "product": "product-name",
  "run_date": "YYYY-MM-DD",
  "status": "success|failed|skipped",
  "changes": {
    "files_updated": [],
    "insights_added": 0
  },
  "summary": "one line summary",
  "next_run": "YYYY-MM-DD"
}
```

## Design principles
1. Agents are stateless — they read config, do work, write output
2. State lives in .pm-brain/ only
3. Orchestrator is dumb — reads schedule, fires agents, logs
4. All outputs JSON-ready for future UI
5. Self-explanatory — a stranger can clone and use in 3 minutes
