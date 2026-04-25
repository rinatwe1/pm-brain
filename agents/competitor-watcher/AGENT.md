---
name: competitor-watcher
schedule: weekly
trigger: manual or cron
output: .pm-brain/knowledge/market/ + .pm-brain/agents/logs/
---

# Competitor Watcher Agent

Monitors defined competitors and updates market knowledge in .pm-brain/.

## What it does
1. Reads competitor list from `.pm-brain/agents/agents.yaml`
2. Fetches public information about each competitor (website, pricing page, feature announcements)
3. Compares with existing knowledge in `.pm-brain/knowledge/market/`
4. Extracts new insights, features, pricing changes
5. Updates `.pm-brain/knowledge/market/knowledge.md`
6. If significant change found → creates entry in `.pm-brain/decisions/` as a flag
7. Writes standard JSON log to `.pm-brain/agents/logs/`

## Input (from agents.yaml)
```yaml
competitor-watcher:
  enabled: true
  schedule: weekly-sunday
  config:
    competitors:
      - name: CompetitorName
        url: https://competitor.com
        watch: [pricing, features, blog]
```

## Output format
Updates `.pm-brain/knowledge/market/knowledge.md`:
```markdown
## Competitor Update — {date}
### {CompetitorName}
- [NEW] {observation}
- [CHANGED] {what changed}
Source: {url} | Checked: {date}
```

Writes to `.pm-brain/agents/logs/competitor-watcher-{date}.json`:
```json
{
  "agent": "competitor-watcher",
  "product": "{product from meta.json}",
  "run_date": "YYYY-MM-DD",
  "status": "success|failed|skipped",
  "changes": {
    "files_updated": [".pm-brain/knowledge/market/knowledge.md"],
    "insights_added": 3
  },
  "summary": "Found 2 pricing changes at CompetitorName",
  "next_run": "YYYY-MM-DD"
}
```

## Trigger (manual)
To run manually from Claude Code:
> "Run the competitor-watcher agent using the config in .pm-brain/agents/agents.yaml"

## Notes
- Only reads public information (no scraping that violates ToS)
- If competitor URL is inaccessible, mark as skipped and log
- Focus on: pricing changes, new feature announcements, positioning shifts
