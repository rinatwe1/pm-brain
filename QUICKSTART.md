# PM Brain — Quick Start

## Install (once, 2 minutes)

```bash
git clone [repo-url] ~/PM-Brain
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

Claude will ask 4–5 questions and set up memory for this product.
Choose Quick mode (existing product with docs) or Deep mode (new product, full discovery).

**Step 3:** Type `/brain-import`

Claude scans your directory and imports existing docs (PRDs, specs, decisions) into memory.
Skip this only if you have zero existing docs.

**Step 4:** Start working normally.

Claude now reads `.pm-brain/` automatically every session.
When you make a decision → `/decision-log`
When you're working on an assumption → `/hypothesis`
Once a month → `/brain-review`

---

## Daily workflow

| When | Type |
|------|------|
| Making a significant decision | `/decision-log` |
| Building based on an assumption | `/hypothesis` |
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

Then run:
```bash
~/PM-Brain/orchestrator/setup.sh /path/to/your-product
```

---

## Troubleshooting

**Skills not found?**
Run `install.sh` again from the PM-Brain directory.

**Wrong directory?**
Make sure you opened Claude Code in your PRODUCT directory, not in PM-Brain.

**Already have docs?**
Run `/brain-import` after `/brain-init`.
