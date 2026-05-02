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

### Step 3: Scan + בחירת עומק

Claude סורק את התיקייה ושואל **תמיד** Quick או Deep — בלי קשר לאם יש docs או לא.

**אם נמצאו docs:**
```
מצאתי [N] מסמכים.

איך תרצה/י להמשיך?

A) Quick — אקרא את ה-docs ואשאל רק מה חסר (1-3 שאלות).
B) Deep — אקרא את ה-docs, אאמת מה שמצאתי, ואחפור לעומק.
   מומלץ אם הdocs ישנים, חלקיים, או שאת/ה לא בטוח/ה שהם מכסים הכל.
```

**אם לא נמצאו docs:**
```
לא מצאתי מסמכים קיימים.

A) Quick — 4 שאלות, 2 דקות.
B) Deep — discovery session מלא, 15 דקות.
```

**Quick (עם docs):** קורא docs + שואל 1-3 שאלות על מה שחסר.
**Quick (ללא docs):** 4 שאלות בסיסיות (מוצר, משתמש, שלב, הדבר הכי חשוב).
**Deep (עם או בלי docs):** 10 שאלות בשלושה רבדים — מוצר → מדדים → מתחרים + הנחות → אופציונלי. שאלות שכבר ידועות מ-docs — מדולגות.

**למה תמיד בוחרים?** כי Claude לא יכול לדעת כמה ה-docs שלך אמינים. אתה/את כן.

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
