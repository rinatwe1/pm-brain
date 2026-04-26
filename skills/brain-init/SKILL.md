---
name: brain-init
description: Initialize PM Brain memory for a product. Creates .pm-brain/ with knowledge architecture, decision journal, quality gate, and agent config. Pre-loaded with PM frameworks from 17 books. Run once per product from the product directory.
---

# /brain-init — Initialize Product Memory

## When to use
Run this once from your product directory. After init, Claude reads .pm-brain/ automatically every session.

## Usage
```
/brain-init
```

Run this from your product directory. Not from PM-Brain.

## Step 1: Find or create product directory

Check if `.pm-brain/` already exists in the current directory.

**If yes:** Tell the user:
```
PM Brain כבר מופעל למוצר זה.
הזיכרון נמצא ב-.pm-brain/

מה תרצה/י לעשות?
A) המשך — פשוט המשך לעבוד
B) עדכן — הוסף מידע לזיכרון הקיים
```
If A → stop, no further action.
If B → skip to Step 2 (choose mode), use existing .pm-brain/.

**If no:** Ask:
```
שלום! בוא נגדיר את הזיכרון של Claude למוצר שלך.

איפה נמצאת תיקיית המוצר?
(לדוגמה: /Users/rinatweiss/Documents/Spirit)

אם אין לך תיקייה עדיין — פשוט תגיד/י את שם המוצר ואצור אותה.
```

If the user provides a full path → use it.
If the user provides only a name (e.g. "Spirit") → confirm:
```
אצור את התיקייה כאן:
/Users/[username]/Work/[product-name]/

מאשר/ת? (כן / מיקום אחר)
```
Create the directory, then proceed.

## Step 2: Scan for existing documents

Before asking anything — scan the product directory for existing files:
- Count markdown files: specs, PRDs, decisions, research, policies
- Look for: CLAUDE.md, any folder named decisions/, specs/, research/, prd/

**If docs found (1+ relevant files):** → PATH A (docs-first)
**If no docs found:** → PATH B (questions)

---

## PATH A — Docs First (existing product)

Tell the user:
```
מצאתי [N] מסמכים. אקרא אותם ואגזור ממה שיש.
```

Read the documents (or a representative sample if many). Extract silently:
- What the product does
- Primary user
- Stage
- Key decisions already made
- Risks or assumptions mentioned

Then ask **only what's missing** — maximum 3 questions. Use this format:
```
קראתי את המסמכים. כמה דברים שלא מצאתי:

1. [שאלה על מה שחסר]
2. [שאלה על מה שחסר]
```

**Cross-section reuse rule:** If the user already answered something in a previous question — don't re-ask. Confirm instead: "ציינת קודם [X] — נכון?"

Proceed to Step 3.

---

## PATH B — No docs (new product)

Ask the user:
```
איך תרצה/י להתחיל?

A) Quick — 4 שאלות, 2 דקות.
   Claude ידע את הבסיס ויתחיל לצבור זיכרון מיד.

B) Deep — discovery session מלא, 15 דקות.
   Claude ישאל לעומק על המוצר, המשתמשים, ההנחות והמתחרים.
   הזיכרון יתחיל מלא יותר.

אפשר תמיד להשלים ל-Deep אחרי Quick — פשוט הרץ /brain-init שוב.
```

### Quick mode (A)

Ask one at a time:
1. "מה המוצר עושה? (משפט אחד)"
2. "מי המשתמש העיקרי?"
3. "באיזה שלב אתם? Discovery / Build / Growth / Scale"
4. "מה הדבר הכי חשוב שאני צריך לדעת על המוצר?"
5. "מי 3 המתחרים הכי רלוונטיים? (אפשר לדלג)"

### Deep mode (B)

Tell the user: "נעשה mini discovery session — התשובות שלך ייזרעו ישירות לזיכרון."

Apply cross-section reuse rule throughout: if the user already mentioned something — confirm, don't re-ask.

Ask one at a time, with a short example per question:

**Tier 1 — Required:**
1. "מה המוצר עושה?" — Example: "Spirit מחברת בין אנשים לסדנאות well-being"
2. "מי המשתמש העיקרי בפירוט?" — Example: "אישה 35-45, תל אביב, מחפשת פעילות משמעותית"
3. "מה הבעיה שאתם פותרים? (JTBD)" — Example: "קשה למצוא חוויה אמינה ורלוונטית"
4. "באיזה שלב אתם? Discovery / Build / Growth / Scale"
5. "מה המדד הראשי להצלחה?" — Example: "bookings per month / retention / MRR"

**Tier 2 — Competitors & Assumptions:**
6. "מי 3 המתחרים הכי רלוונטיים? (שם + URL)"
7. "מה ההנחה הכי גדולה שהמוצר מבוסס עליה?"
8. "מה הסיכון הכי גדול?"

**Tier 3 — Optional** (ask "רוצה לענות על עוד שאלות?"):
9. "מה כבר ניסיתם ולא עבד?"
10. "מה את/ה הכי לא בטוח/ה לגביו?"

**Note (internal — do not display):** If the user says "המשך בלעדי" at any point — fill in remaining questions from context and proceed to Step 3.

---

## Step 3: Create directory structure

Create this exact structure in the current directory:

```
.pm-brain/
├── SNAPSHOT.md        ← קרא זה ראשון בכל session
├── meta.json
├── knowledge/
│   ├── INDEX.md
│   ├── discovery/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   ├── strategy/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   ├── growth/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   ├── metrics/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   ├── ux/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   ├── roadmap/
│   │   ├── knowledge.md
│   │   ├── hypotheses.md
│   │   └── rules.md
│   └── market/
│       ├── knowledge.md
│       ├── hypotheses.md
│       └── rules.md
├── decisions/
│   └── .gitkeep
├── hypotheses/
│   └── .gitkeep
├── quality/
│   └── criteria.md
└── agents/
    └── agents.yaml
```

Note: `market/` and `hypotheses/` are critical — create them even if they seem unused. Agents write to `market/`, the `/hypothesis` skill writes to `hypotheses/`.

---

## Step 4: Write SNAPSHOT.md

Create `.pm-brain/SNAPSHOT.md` — the first file Claude reads every session:

```markdown
# [Product] — Snapshot
Last updated: YYYY-MM-DD

## עכשיו
[stage] — [מה קורה כרגע בפועל]

## הסיכון הכי גדול
[מה יכול להטביע את המוצר עכשיו]

## ההנחה הכי גדולה
[מה עדיין לא מוכח שהמוצר מבוסס עליו]

## הצעד הבא
[הדבר הכי חשוב לעשות עכשיו]

## hypotheses פעילות
[מספר] פעילות — הקריטית ביותר: [HYP-XXX]

## החלטות אחרונות
- [תאריך]: [החלטה קצרה]
- [תאריך]: [החלטה קצרה]
```

Fill from the answers given during init. Leave sections empty if unknown — Claude will populate them over time.

---

## Step 5: Write meta.json

```json
{
  "product": "[name]",
  "description": "[answer to Q1]",
  "primary_user": "[answer to Q2]",
  "stage": "[answer to stage question]",
  "init_mode": "quick|deep",
  "initialized": "YYYY-MM-DD",
  "last_review": null,
  "last_active": "YYYY-MM-DD",
  "decision_count": 0,
  "hypothesis_count": 0,
  "rule_count": 0,
  "review_count": 0
}
```

---

## Step 5: Pre-populate knowledge from answers

### Quick Mode (Mode A) — always do this:

**From Q1 (product description) → discovery/knowledge.md:**
```markdown
## Product Description — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From Q2 (primary user) → discovery/knowledge.md:**
```markdown
## Primary User — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From Q4 (most important thing) → strategy/knowledge.md:**
```markdown
## Key Product Context — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From competitors question (if answered) → pre-fill agents.yaml:**
```yaml
competitor-watcher:
  enabled: false  # set to true when ready to monitor automatically
  schedule: weekly-sunday
  config:
    competitors:
      - name: "[Competitor 1]"
        url: ""
      - name: "[Competitor 2]"
        url: ""
```

**If competitors question was skipped → still create agents.yaml template:**
```yaml
competitor-watcher:
  enabled: false
  schedule: weekly-sunday
  config:
    competitors: []  # add competitors here: - name: "X" url: "https://x.com"
```

---

### Deep Mode (Mode B) — also do this:

If Mode B was used, additionally seed:

**From Q2 (primary user) → discovery/knowledge.md:**
```markdown
## Primary User — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From Q3 (problem/JTBD) → discovery/knowledge.md:**
```markdown
## Core Job-to-be-Done — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From Q5 (main metric) → metrics/knowledge.md:**
```markdown
## Primary Success Metric — initialized YYYY-MM-DD
[answer verbatim]
Source: brain-init
```

**From Q7 (biggest assumption) → auto-create HYP-001:**
Create `.pm-brain/hypotheses/HYP-001-[slug].md` using the hypothesis template:
```markdown
# HYP-001: [title from assumption]

**Date:** YYYY-MM-DD
**Category:** strategy
**Confidence:** 5/10
**Status:** unvalidated
**Expires:** [90 days from today]

## Hypothesis
[Q7 answer rewritten as: "We believe that X. Because Y. We will measure by Z."]

## Test Method
[suggest based on the assumption type]

## Definition of Validated
[suggest]

## Definition of Invalidated
[suggest]

## Validation Log

## Links
- Created during: brain-init
```

**From Q8 (biggest risk) → auto-create HYP-002:**
Same format, created from Q8 answer.

**From Q6 (competitors) → pre-fill agents.yaml:**
```yaml
competitor-watcher:
  enabled: false  # set to true when ready
  schedule: weekly-sunday
  config:
    competitors:
      - name: "[Competitor 1]"
        url: "[URL if provided]"
      - name: "[Competitor 2]"
        url: "[URL if provided]"
      - name: "[Competitor 3]"
        url: "[URL if provided]"
```

---

## Step 6: Write quality/criteria.md

```markdown
# Quality Criteria — [product]

Last updated: [date]

## Category: Discovery
### Criteria:
- [ ] User problem validated with 3+ real interviews before building
- [ ] Jobs-to-be-Done defined for the feature
- [ ] Assumptions listed before solution is proposed
### Severity: blocking
### Source: The Mom Test + Continuous Discovery Habits
### Last triggered: never

## Category: Strategy
### Criteria:
- [ ] Strategic bet documented for each initiative
- [ ] Competitor positioning checked before major feature
- [ ] Success metrics defined before build starts
### Severity: blocking
### Source: INSPIRED + OKRs Done Right
### Last triggered: never

## Category: Decisions
### Criteria:
- [ ] Alternatives considered (min 2) before deciding
- [ ] Trade-offs explicitly documented
- [ ] Decision logged in /decisions/ if affects >1 sprint
### Severity: warning
### Source: Decision Journal architecture
### Last triggered: never

## Category: Roadmap
### Criteria:
- [ ] Each initiative tied to a strategic bet
- [ ] Dependencies identified
- [ ] Kill criteria defined (when to stop)
### Severity: warning
### Source: Strategize + Escaping the Build Trap
### Last triggered: never
```

---

## Step 7: Write knowledge/INDEX.md

Now includes market/ domain:

```markdown
# Knowledge Index — [product]

Last updated: YYYY-MM-DD

## Domains
| Domain | Rules | Hypotheses | Last updated |
|--------|-------|------------|--------------|
| [discovery](discovery/) | 0 | 0 | [date] |
| [strategy](strategy/) | 0 | 0 | [date] |
| [growth](growth/) | 0 | 0 | [date] |
| [metrics](metrics/) | 0 | 0 | [date] |
| [ux](ux/) | 0 | 0 | [date] |
| [roadmap](roadmap/) | 0 | 0 | [date] |
| [market](market/) | 0 | 0 | [date] |

## Hypotheses
- Active: [count from hypotheses/]
- Validated: 0
- Invalidated: 0

## Cross-domain Links
(populated as patterns emerge)
```

---

## Step 8: Append PM Brain block to CLAUDE.md

If CLAUDE.md exists in current directory, append:

```markdown
## PM Brain Memory

**Product:** [name]
**Initialized:** YYYY-MM-DD
**Memory location:** `.pm-brain/`

### How to use this memory
At the start of every conversation: read `.pm-brain/SNAPSHOT.md` first — before doing anything else.
Before suggesting any new feature or approach: check `.pm-brain/decisions/` for conflicts with prior decisions.
Before any task: check the relevant domain in `.pm-brain/knowledge/`.
After any significant decision: run `/decision-log`.
When working on an assumption: run `/hypothesis`.
Monthly: run `/brain-review`.

**Critical:** If `.pm-brain/decisions/` contains a decision related to what the user is discussing, surface it immediately: "ב-[תאריך] החלטנו [X] — האם זה עדיין בתוקף?"

### Auto-update SNAPSHOT
At the end of every session, update `.pm-brain/SNAPSHOT.md`:
- Update "עכשיו" if stage or situation changed
- Update "הצעד הבא" based on what was decided or completed
- Update "החלטות אחרונות" if a decision was logged
- Update "hypotheses פעילות" count if changed
- Update "Last updated" date
Do this silently — no need to announce it.

### Knowledge domains
discovery | strategy | growth | metrics | ux | roadmap | market

### Quick access
- Decisions: `.pm-brain/decisions/`
- Hypotheses: `.pm-brain/hypotheses/`
- Quality criteria: `.pm-brain/quality/criteria.md`
```

---

## Step 9: Output

JSON:
```json
{
  "status": "initialized",
  "product": "[name]",
  "mode": "quick|deep",
  "created": {
    "knowledge_domains": 7,
    "hypotheses_seeded": 0,
    "decisions_folder": true,
    "hypotheses_folder": true,
    "quality_criteria": 4,
    "competitors_in_agent_config": 0
  },
  "next_steps": []
}
```

Human message for Quick mode:
```
PM Brain initialized for [product] (Quick mode).

.pm-brain/ נוצר עם 7 knowledge domains.
הידע שסיפקת נשמר ב-discovery/ ו-strategy/.

הצעד הבא:
→ יש לך docs קיימים (PRDs, specs, פגישות)? הרץ /brain-import — Claude יקרא אותם וייבא לזיכרון.
→ מוצר חדש לגמרי? התחל לעבוד. הרץ /decision-log כשתחליט משהו.

אחרי ה-import, Claude קורא את .pm-brain/ אוטומטית בכל session.
```

Human message for Deep mode:
```
PM Brain initialized for [product] (Deep mode).

.pm-brain/ נוצר עם:
├── 7 knowledge domains
├── [N] hypotheses נוצרו אוטומטית (HYP-001, HYP-002)
├── [N] מתחרים ב-agents.yaml
└── Primary user + JTBD נשמרו ב-discovery/

הצעד הבא:
- מוצר חדש: התחל לעבוד, /decision-log כשתחליט משהו
- מוצר קיים עם docs: /brain-import
```
