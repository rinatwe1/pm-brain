> **Status:** MVP — actively developed | **Skills:** 12 | **Agents:** 1

# PM Brain

Claude gets smarter about your product every session.

## The problem
Claude forgets everything. Every session starts from scratch. Why did we reject that feature? What did we learn from users last quarter? Claude doesn't know.

## What PM Brain does
PM Brain gives Claude persistent memory for your product. Decisions, knowledge, and patterns accumulate over time. Claude applies them automatically.

## How it works
PM Brain = git for product knowledge.
- Install once (this repo)
- Run `/brain-init` in any product directory
- Claude starts accumulating memory

After 30 days, Claude knows your product history. After 90 days, you stop re-explaining context.

## Install

```bash
git clone https://github.com/rinatwe1/pm-brain.git ~/PM-Brain
cd ~/PM-Brain
./install.sh
```

After `install.sh`, you can close this directory. PM Brain is now invisible infrastructure — like git.

## Quick start

See [QUICKSTART.md](QUICKSTART.md)

Short version:
1. Open Claude Code in your **product directory** (not in PM-Brain)
2. Type `/brain-init`
3. Done

## Skills (run manually)

### Memory skills
| Skill | When to use |
|-------|-------------|
| `/brain-init [product]` | First time setting up a product |
| `/brain-import` | Product has existing docs — import them |
| `/decision-log` | Making a significant decision |
| `/hypothesis` | Tracking an assumption |
| `/brain-review` | Monthly — prune and promote knowledge |

### Product OS skills
| Skill | When to use |
|-------|-------------|
| `/discover` | Start a new product — structured discovery process |
| `/prd` | Write a PRD interactively (Ninja PRD v2.17) |
| `/create` | Build PRD from discovery insights |
| `/verify` | Gap analysis on an existing PRD |
| `/roadmap` | Plan execution from a verified PRD |
| `/dashboard` | Status overview of all products |
| `/strategy-check` | Monthly strategic review (ICP, competitors, assumptions) |

## Agents (run automatically)
Agents run on a schedule and update your product memory without you doing anything.

| Agent | What it does | Default schedule |
|-------|-------------|-----------------|
| `competitor-watcher` | Monitors competitors, updates market knowledge | Weekly |
| `knowledge-updater` | Reads new PM content (Lenny, blogs), extracts insights | Weekly |
| `decision-reviewer` | Reviews old decisions, flags outdated ones | Monthly |

Enable agents per product in `.pm-brain/agents/agents.yaml`

## What gets created in your product
```
your-product/
└── .pm-brain/
    ├── meta.json          ← product info
    ├── knowledge/         ← accumulated knowledge (7 domains)
    ├── decisions/         ← decision journal
    ├── quality/           ← quality criteria
    └── agents/
        └── agents.yaml   ← enable/configure agents
```

## License
MIT
