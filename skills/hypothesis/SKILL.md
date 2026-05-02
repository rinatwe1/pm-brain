---
name: hypothesis
description: Log a product hypothesis with confidence score, test method, and expiry date. Saves to .pm-brain/hypotheses/. Run when building based on an assumption — so it gets validated or killed. Claude surfaces unvalidated hypotheses during /brain-review.
---

# /hypothesis — Log a Hypothesis

## When to use
- "אני מניח שמשתמשים יעשו X"
- "אם נוסיף Y, ה-retention יעלה"
- "הסגמנט הזה מוכן לשלם Z"
- Any belief you're building on that hasn't been validated yet

## Guard clause

Before doing anything — check that `.pm-brain/` exists in the current directory.

If it doesn't exist:
```
לא מצאתי .pm-brain/ בתיקייה הזו.

פתחת Claude Code בתיקיית המוצר שלך? (לא בתיקיית PM-Brain)
אם כן — הרץ /brain-init קודם כדי להפעיל את הזיכרון.
```
Stop. Do not continue.

---

## Commands
- `/hypothesis` — log a new hypothesis
- `/hypothesis validate HYP-001` — mark a hypothesis as validated
- `/hypothesis kill HYP-001` — mark as invalidated with reason

## Process: Log new hypothesis

### Step 1: Gather details
Ask one at a time:

1. "מה ההנחה? (נסה/י: אנחנו מאמינים ש-X כי Y ונמדוד ב-Z)"
2. "מה רמת הביטחון שלך? (1-10)"
   - 1-3 = ניחוש
   - 4-6 = הנחה סבירה
   - 7-9 = אמונה מבוססת
3. "איך תבדוק את זה? (interviews / A-B test / analytics / fake-door)"
4. "מתי יפוג? כמה ימים/שבועות עד שהיא stale?"

### Step 2: Assign category
retention | acquisition | monetization | engagement | usability | technical

### Step 3: Get next hypothesis ID
Read `.pm-brain/meta.json` → `hypothesis_count` → next ID = count + 1, zero-padded to 3 digits (HYP-001).

### Step 4: Write hypothesis file
Create `.pm-brain/hypotheses/` if it doesn't exist.
Path: `.pm-brain/hypotheses/HYP-{NNN}-{slug}.md`

Content:
```
# HYP-{NNN}: {short title}

**Date:** YYYY-MM-DD  
**Category:** {category}  
**Confidence:** {score}/10  
**Status:** unvalidated  
**Expires:** YYYY-MM-DD

## Hypothesis
We believe that {X}
Because {Y}
We will measure success by {Z}

## Test Method
{how to validate}

## Definition of Validated
{what specific result counts as confirmed}

## Definition of Invalidated
{what specific result counts as false}

## Validation Log
(updated when evidence arrives)

## Links
- Related decision: {path or "none"}
```

### Step 5: Warnings
- Confidence < 4: "זו הנחה חלשה מאוד — כדאי לא לבנות על זה לפני שתאמת."
- No concrete test method: "מה בדיוק תעשה השבוע כדי לבדוק?"
- Expiry > 90 days: "90+ יום זה הרבה. האם ניתן לקצר?"

### Step 6: Update meta.json
Increment `hypothesis_count`. Update `last_active`.

### Step 7: Output

JSON:
```json
{
  "status": "logged",
  "id": "HYP-{NNN}",
  "file": ".pm-brain/hypotheses/HYP-{NNN}-{slug}.md",
  "category": "{category}",
  "confidence": {score},
  "expires": "YYYY-MM-DD",
  "hypothesis_count": {new total}
}
```

## Process: Validate hypothesis (/hypothesis validate HYP-001)

1. Read the hypothesis file
2. Ask: "מה הראיה שמאששת אותה?"
3. Append to Validation Log section
4. Change Status to: `validated`
5. Ask: "האם להעביר ל-rules.md בdomain הרלוונטי?" 
   - If yes: append to the relevant domain's rules.md in knowledge/
   - Format: `### Rule (from HYP-{NNN}): {hypothesis as rule}\n**Source:** validated hypothesis\n**Exception:** {when not to apply}`
6. Update JSON output with status: "validated"

## Process: Kill hypothesis (/hypothesis kill HYP-001)

1. Read the hypothesis file
2. Ask: "מה הראיה שמפריכה אותה?"
3. Append to Validation Log section
4. Change Status to: `invalidated`
5. Note: invalidated hypotheses stay in the file — they are still valuable data

## Notes
- Never delete hypotheses — validated/invalidated are both valuable
- Hypotheses that expire without validation → flagged in /brain-review
- A validated hypothesis confirmed 3+ times → promote to rules.md automatically
