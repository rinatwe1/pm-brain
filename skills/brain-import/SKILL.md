---
name: brain-import
description: Import existing product documentation into PM Brain memory. Scans the current directory for PRDs, specs, policies, flows, and tech docs. Extracts decisions, rules, and knowledge. Run after /brain-init when your product has existing documentation.
---

# /brain-import — Import Existing Docs

## When to use
Run this after `/brain-init` if your product has existing documentation:
- PRD files or feature specs
- Decision documents
- Policy files
- User research notes
- Tech stack or architecture docs
- Flow diagrams or process docs

## Process

### Step 1: Check .pm-brain/ exists
If `.pm-brain/` doesn't exist, tell user to run `/brain-init` first.

### Step 2: Scan for documentation

Scan the current directory recursively for:
- `*.md` files
- `*.docx` files (Word documents)

**Skip these directories** — they contain code, not product docs:
`.pm-brain/`, `node_modules/`, `.git/`, `archive/`, `src/`, `app/`, `lib/`, `components/`, `tests/`, `test/`, `dist/`, `build/`, `.next/`, `__pycache__/`, `vendor/`, `coverage/`

**Prefer these directories** — likely to contain product docs:
root level files, `docs/`, `_docs/`, `specs/`, `research/`, `decisions/`, `prd/`, `notes/`

Build a list with: filename, path, estimated type.

**If 0 files found:**
```
לא מצאתי מסמכים לייבוא בתיקייה הזו.

אם יש לך מסמכים בפורמטים אחרים:
• Google Docs — יצא/י כ-Word (.docx) או Markdown ואז הרץ שוב
• Notion — יצא/י עמוד כ-Markdown ואז הרץ שוב
• PDF — לא נתמך עדיין

אם המוצר חדש לגמרי — התחל/י לעבוד ישירות.
/decision-log כשתחליט/י משהו.
```
Stop.

Show user:
```
Found 23 documents to import:
├── PRD/specs (13 files)
├── Flows (4 files)  
├── Policies (1 file)
├── Word docs (2 files)
└── Other (3 files)

This will take ~2 minutes. Proceed? (y/n)
```

### Step 2b: Convert .docx files

For each `.docx` file found, convert to plain text before processing:

Run: `textutil -convert txt "[file].docx" -stdout`

If `textutil` is not available (non-Mac):
- Try: `pandoc "[file].docx" -t plain`
- If neither available: skip the file and tell user:
  ```
  דילגתי על [filename].docx — לא נמצא כלי המרה.
  התקן/י pandoc (brew install pandoc) ואז הרץ שוב, או יצא/י כ-Markdown ידנית.
  ```

Treat the converted text as the file content for all steps below.

### Step 3: Process each file by type

**For PRD/spec files** (contain: "spec", "prd", "feature", "requirements" in name):
- Extract: what was decided (the feature/behavior)
- Extract: any stated rationale or constraints
- Map to domain: features → discovery/knowledge.md + strategy/knowledge.md
- If decision has clear rationale → create entry in decisions/

**For policy files** (contain: "policy", "policies", "rules" in name):
- Extract rules and constraints
- Map to: strategy/rules.md

**For tech stack files** (contain: "tech", "stack", "architecture" in name):
- Extract: tech choices + constraints
- Map to: strategy/knowledge.md

**For flow files** (contain: "flow", "flows", "journey" in name):
- Extract: user behaviors and pain points
- Map to: discovery/knowledge.md

**For research/user files** (contain: "user", "research", "interview", "feedback" in name):
- Extract: user insights, validated behaviors
- Map to: discovery/knowledge.md and discovery/rules.md (if validated)

### Step 4: Write to .pm-brain/

For each domain, APPEND (never overwrite) to the existing files:

discovery/knowledge.md:
```markdown
## Imported from existing docs — {date}

### From: {filename}
{extracted content}
**Source:** {file path}
```

decisions/ — create one file per significant decision found:
```
decisions/{date}-imported-{topic}.md
```
Use the decision template format. Mark as `## Source: imported` so it's distinguishable from future decisions.

### Step 5: Update meta.json
Add import record:
```json
"imports": [
  {
    "date": "YYYY-MM-DD",
    "files_processed": 23,
    "decisions_extracted": 8,
    "knowledge_entries_added": 15
  }
]
```

### Step 6: Update knowledge/INDEX.md
Update the counts in the index table to reflect new entries.

### Step 7: Output summary (JSON + human readable)

```json
{
  "status": "success",
  "imported": {
    "files_processed": 23,
    "decisions_extracted": 8,
    "knowledge_entries": {
      "discovery": 6,
      "strategy": 5,
      "metrics": 2,
      "ux": 2
    }
  }
}
```

Human readable:
```
Import complete.

Processed: 23 files
├── Decisions extracted: 8 → decisions/
├── Discovery knowledge: 6 entries → .pm-brain/knowledge/discovery/
├── Strategy knowledge: 5 entries → .pm-brain/knowledge/strategy/
├── UX knowledge: 2 entries → .pm-brain/knowledge/ux/
└── Metrics knowledge: 2 entries → .pm-brain/knowledge/metrics/

Review imported decisions: ls .pm-brain/decisions/
```

## Notes
- Always APPEND, never overwrite existing .pm-brain/ content
- Mark all imported content with source file path
- If unsure which domain — default to discovery/knowledge.md
- Don't try to be perfect — a rough import is better than no import
- User can clean up manually after import
