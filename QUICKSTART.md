# PM Brain — Quick Start

## Install (once, 2 minutes)

```bash
git clone https://github.com/rinatwe1/pm-brain.git ~/PM-Brain
cd ~/PM-Brain
./install.sh
```

Done. Close this directory. You won't need it again.

## Use (per product)

**Step 1:** Open Claude Code in your product directory — not in PM-Brain.

```
Open: Work/Spirit/       ✓
Open: Work/PM-Brain/     ✗ (only for editing skills)
```

**Step 2:** Type `/brain-init`

Claude scans your directory for existing docs, then asks you to choose:

- **Quick** — reads your docs (if any) and fills in only what's missing. 2 minutes.
- **Deep** — reads your docs, validates what it found, and asks 10 questions about users, assumptions, and metrics. Recommended if your docs are old, partial, or you want a thorough start.

You can always run `/brain-init` again to go deeper.

**Step 3:** Type `/brain-import` *(if you have existing docs)*

Claude scans your directory and imports existing docs (PRDs, specs, decisions) into memory.
Skip this if you have zero existing docs.

**Step 4:** Start working normally.

brain-init updated your `CLAUDE.md` with a memory block — that's what causes Claude to read `.pm-brain/` at the start of every session. No magic, just instructions.

When you make a decision → `/decision-log`
When you're working on an assumption → `/hypothesis`
After a meeting or interview → `/synthesize`
Once a month → `/brain-review`

---

## Daily workflow

| When | Type |
|------|------|
| Making a significant decision | `/decision-log` |
| Building based on an assumption | `/hypothesis` |
| After a meeting, interview, or research | `/synthesize` |
| Before a stakeholder meeting | `/brain-report` |
| Once a month | `/brain-review` |

---

## Enable agents (optional)

Agents update your product memory automatically on a schedule.

Edit `.pm-brain/agents/agents.yaml` in your product directory:

```yaml
competitor-watcher:
  enabled: true
  config:
    competitors:
      - name: CompetitorName
        url: https://competitor.com
```

---

## Troubleshooting

**Skills not found?**
Run `./install.sh` again from the PM-Brain directory.

**Wrong directory?**
Make sure you opened Claude Code in your **product** directory, not in PM-Brain.
Good: `Work/Spirit/` — Bad: `Work/PM-Brain/`

**Claude doesn't seem to remember anything?**
Check that your `CLAUDE.md` has a `## PM Brain Memory` section.
If not — run `/brain-init` again from your product directory.

**YAML validation error after editing a .pm-brain/ file?**
Your file is missing required frontmatter. Every `.pm-brain/` file needs:
```
---
type: [decision|hypothesis|knowledge|...]
date: YYYY-MM-DD
---
```

**Already have docs but brain-init didn't find them?**
Run `/brain-import` manually after `/brain-init`.

**Ran /decision-log or /hypothesis and got an error?**
`.pm-brain/` doesn't exist yet. Run `/brain-init` first.
