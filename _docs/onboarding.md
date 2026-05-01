# PM Brain — Onboarding Flow (current state, v0.1)

## Install (once, 3 commands)

```bash
git clone https://github.com/rinatwe1/pm-brain.git ~/PM-Brain
cd ~/PM-Brain
./install.sh
```

Output:
```
✓ 12 skills linked to ~/.claude/skills/
Done. You can close this directory now.
To start:
  1. Open Claude Code in your product directory
  2. Type: /brain-init
```

---

## First Use — /brain-init

Open Claude Code in your **product directory** (not PM-Brain).

Type: `/brain-init`

### Step 1: Check existing state

If `.pm-brain/` already exists:
```
PM Brain כבר מופעל למוצר זה.
מה תרצה/י לעשות?
A) המשך — פשוט המשך לעבוד
B) עדכן — הוסף מידע לזיכרון הקיים
```

If not — proceed.

### Step 2: Find / create product directory

```
שלום! בוא נגדיר את הזיכרון של Claude למוצר שלך.

איפה נמצאת תיקיית המוצר?
(לדוגמה: /Users/rinatweiss/Documents/Spirit)

אם אין לך תיקייה עדיין — פשוט תגיד/י את שם המוצר ואצור אותה.
```

If only a name given (e.g. "Spirit") → creates `/Users/[username]/Work/Spirit/` after confirmation.

### Step 3: Scan for existing docs

Claude scans the directory silently.

**If docs found (Path A):**
```
מצאתי [N] מסמכים. אקרא אותם ואגזור ממה שיש.
```
Reads docs, extracts: product description, users, stage, decisions, risks.
Then asks only what's missing — max 3 questions.

**If no docs (Path B):**
```
איך תרצה/י להתחיל?

A) Quick — 4 שאלות, 2 דקות.
   Claude ידע את הבסיס ויתחיל לצבור זיכרון מיד.

B) Deep — discovery session מלא, 15 דקות.
   Claude ישאל לעומק על המוצר, המשתמשים, ההנחות והמתחרים.
   הזיכרון יתחיל מלא יותר.

אפשר תמיד להשלים ל-Deep אחרי Quick — פשוט הרץ /brain-init שוב.
```

Quick: 4 questions (product, user, stage, most important thing) + optional competitors.
Deep: 10 questions across 3 tiers (product → metrics → competitors + assumptions → optional).

### Step 4: Structure created

```
.pm-brain/
├── SNAPSHOT.md          ← read first every session, auto-updated
├── meta.json
├── knowledge/           ← 7 domains × 3 files (knowledge, hypotheses, rules)
├── decisions/
├── hypotheses/
├── quality/criteria.md
└── agents/agents.yaml
```

### Step 5: Confirmation

```
PM Brain initialized for [product].

.pm-brain/ נוצר.
Claude קורא את SNAPSHOT.md אוטומטית בכל session.

הצעד הבא:
→ יש לך docs קיימים? הרץ /brain-import
→ מוצר חדש? התחל לעבוד. /decision-log כשתחליט משהו.
```

---

## Daily Workflow

| מתי | מה לכתוב |
|-----|----------|
| לפני כל החלטה גדולה | `/decision-log` |
| כשעובדים על הנחה לא מוכחת | `/hypothesis` |
| רוצים לכתוב PRD | `/prd` |
| פעם בחודש | `/brain-review` |

Claude מעדכן את SNAPSHOT.md בסוף כל session אוטומטית — ללא הודעה.

---

## What gets smarter over time

- `knowledge/[domain]/rules.md` — hypotheses confirmed 3x get promoted here automatically
- `knowledge/INDEX.md` — tracks rule/hypothesis counts per domain
- `decisions/` — every decision logged here, Claude checks before making new ones
- `SNAPSHOT.md` — always reflects current state of the product
- `quality/criteria.md` — quality gate evolves as new failure patterns emerge
