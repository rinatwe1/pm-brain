---
name: brain-init
description: Initialize PM Brain memory for a product. Creates .pm-brain/ with knowledge architecture, decision journal, quality gate, and agent config. Pre-loaded with PM frameworks from 17 books. Run once per product from the product directory.
---

# /brain-init — Initialize Product Memory

## When to use
Run this once from your product directory. After init, Claude reads .pm-brain/ automatically every session.

## Usage
```
/brain-init [product-name]
```

## Step 1: Check if already initialized
If `.pm-brain/` exists: show current state and ask "לאתחל מחדש או לעדכן?"
If not: proceed.

## Step 2: Choose mode

Ask the user:
```
שני מצבים:

A) Quick (2 דקות) — 4 שאלות בסיסיות. מתאים למוצר קיים שיש לו docs.
B) Deep (15 דקות) — discovery session מלא. מתאים למוצר חדש.

מה עדיף לך? (A/B)
```

---

## QUICK MODE (Mode A)

Ask these 4 questions, one at a time:

1. "מה המוצר עושה? (משפט אחד)"
2. "מי המשתמש העיקרי?"
3. "באיזה שלב אתם? Discovery / Build / Growth / Scale"
4. "מה הדבר הכי חשוב שClaudie צריך לדעת על המוצר?"

Then proceed to Step 3 (create directories).

---

## DEEP MODE (Mode B)

Tell the user: "נעשה mini discovery session — התשובות שלך ייזרעו ישירות לזיכרון."

### Cross-section reuse rule
If the user already mentioned something relevant in a previous answer — don't re-ask. Instead confirm:
"ציינת קודם [X] — האם זה נכון כאן גם, או לשנות?"

Apply this throughout all 10 questions. If Q1 already covered the problem, Q3 doesn't re-ask. If Q2 named a segment, Q7 reuses it.

Ask these questions, one at a time. For each question, give a short example to help junior PMs.

**Tier 1 — Required:**

1. "מה המוצר עושה? (משפט אחד)"
   Example: "Spirit מחברת בין אנשים לסדנאות ואירועי well-being"

2. "מי המשתמש העיקרי — תאר/י בפירוט"
   Example: "אישה בת 35-45, תל אביב, עובדת, מחפשת פעילות משמעותית בשעות הפנאי"

3. "מה הבעיה שאתם פותרים? (JTBD — מה הם רוצים להשיג)"
   Example: "רוצים חיבור חברתי + התפתחות אישית, אבל קשה למצוא משהו רלוונטי ואמין"

4. "באיזה שלב אתם? Discovery / Build / Growth / Scale"

5. "מה המדד הראשי להצלחה?"
   Example: "bookings per month / retention after 3 sessions / MRR"

**Tier 2 — Competitors & Assumptions:**

6. "מי 3 המתחרים הכי רלוונטיים? (שם + URL אם יש)"
   Example: "Eventbrite, Momence, פייסבוק אירועים"

7. "מה ההנחה הכי גדולה שמוצר זה מבוסס עליה?"
   Example: "אנחנו מאמינים שאנשים ישלמו פרמיום עבור well-being אם המדריך מאומת"

8. "מה הסיכון הכי גדול שיכול להטביע את המוצר?"
   Example: "שהמדריכים לא יצליחו לגייס משתמשים בכוחות עצמם"

**Tier 3 — Optional (ask "רוצה לענות על עוד שאלות לעומק?"):**

9. "מה כבר ניסיתם ולא עבד?"
10. "מה אתה/את הכי לא בטוח/ה לגביו עכשיו?"

**Escape hatch:** At any point the user can say "המשך בלעדי" — Claude fills in the remaining questions based on context and proceeds to Step 3.

---

## Step 3: Create directory structure

Create this exact structure in the current directory:

```
.pm-brain/
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

## Step 4: Write meta.json

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

## Step 5: Pre-populate knowledge from Deep mode answers (Deep mode only)

If Mode B was used, seed the knowledge files with actual answers:

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
Before starting any task, read the relevant domain in `.pm-brain/knowledge/`.
After any significant decision, run `/decision-log`.
When working on an assumption, run `/hypothesis`.
Monthly: run `/brain-review`.

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

.pm-brain/ נוצר עם 7 domains.
הצעד הבא: /brain-import — ייבוא docs קיימים.
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
