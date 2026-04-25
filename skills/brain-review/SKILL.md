---
name: brain-review
description: Monthly knowledge review. Prunes stale rules, surfaces expired hypotheses, reviews old decisions, updates quality criteria. Run once a month or after a major product milestone. Takes 10-15 minutes.
---

# /brain-review — Monthly Knowledge Review

## When to use
- Once a month (check meta.json → last_review date)
- After a major release or pivot
- When /brain-init suggests it (after 30+ days)

## Process

### Step 1: Check if review is due
Read `.pm-brain/meta.json` → `last_review`.
If null or > 30 days ago: proceed.
If < 14 days ago: "הביקורת האחרונה הייתה לפני X ימים — האם לבצע בכל זאת?"

### Step 2: Scan hypotheses
Read all files in `.pm-brain/hypotheses/`.
Categorize:
- **Expired** (past expiry date, still unvalidated) → surface to user
- **Near expiry** (within 7 days) → warn
- **Long-running unvalidated** (>60 days, no expiry) → flag

For expired hypotheses, ask: "HYP-001 פגה — אמת/י, הרג/י, או הארכ/י את התוקף?"

### Step 3: Scan decisions
Read all files in `.pm-brain/decisions/` with Status: active.
Flag decisions older than 90 days: "ההחלטה הזו מ-{date} — האם היא עדיין נכונה?"

If user says it's outdated:
- Change Status to: `superseded`
- Ask if they want to log a new decision with /decision-log

### Step 4: Scan rules
Read all `rules.md` files across knowledge domains.
For each rule, check: was it applied recently? (look for mentions in decisions/)
Flag rules with no recent application as potentially stale.
Ask: "הכלל הזה לא יושם מ-{date} — האם הוא עדיין רלוונטי?"

### Step 5: Update quality criteria
Read `.pm-brain/quality/criteria.md`.
Ask: "האם יש קריטריון שתפסת בעיה אמיתית לאחרונה? נוסיף אותו."
Add new criteria if user identifies a pattern.
Flag criteria with `Last triggered: never` after 10+ evaluations for pruning.

### Step 6: Promote hypotheses to rules
List all hypotheses with Status: validated.
For each: "HYP-{NNN} אומתה — להעביר ל-rules.md?"
If yes: append to relevant domain's rules.md.

### Step 7: Update meta.json
```json
{
  "last_review": "YYYY-MM-DD",
  "review_count": {incremented}
}
```

### Step 8: Output summary

JSON:
```json
{
  "status": "completed",
  "review_date": "YYYY-MM-DD",
  "hypotheses": {
    "expired": 2,
    "validated": 1,
    "promoted_to_rules": 1
  },
  "decisions": {
    "reviewed": 5,
    "superseded": 1
  },
  "rules": {
    "flagged_stale": 0,
    "new_added": 1
  },
  "next_review": "YYYY-MM-DD"
}
```

Human summary:
```
/brain-review הושלם — {date}

הנחות:
├── פגו: 2 (טפל/י בהן)
├── אומתו: 1 → הועברה ל-rules
└── פעילות: X

החלטות: 5 נסקרו, 1 הוחלפה
כללים: +1 חדש

הביקורת הבאה: {date}
```

## Notes
- Never delete anything — mark as superseded/invalidated/stale
- The goal is 10-15 minutes, not a deep audit
- If the user is short on time: focus only on expired hypotheses + decisions > 90 days
- /brain-review is a conversation, not a form — adapt to what the user wants to focus on
