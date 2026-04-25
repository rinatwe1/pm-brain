---
name: decision-log
description: Record a product decision with full reasoning. Saves to .pm-brain/decisions/. Run whenever you make a decision that affects more than today's task. Claude searches prior decisions before recommending anything in this area.
---

# /decision-log — Record a Decision

## When to use
- Choosing between two product approaches
- Deciding to kill or delay a feature
- Tech architecture choices
- Pricing or packaging decisions
- Any decision where "why did we do this?" will matter in 3 months

## Process

### Step 1: Search for prior decisions
Grep `.pm-brain/decisions/` for files related to the topic.
If found: show user. Ask if this supersedes a prior decision.

### Step 2: Gather decision details
Ask these questions one at a time — conversationally, not as a form:

1. "מה ההחלטה? (משפט אחד)"
2. "למה זה עלה עכשיו?"
3. "מה האלטרנטיבות ששקלת? (לפחות 2)"
4. "למה בחרת באפשרות הזו?"
5. "מה ויתרת כשבחרת בזה?"
6. "מתי תדע שזו הייתה ההחלטה הנכונה?"

### Step 3: Determine domain
Assign to: discovery | strategy | growth | metrics | ux | roadmap

### Step 4: Write decision file
Path: `.pm-brain/decisions/YYYY-MM-DD-{slug}.md`
Slug = 2-4 words from the decision, kebab-case.

Content:
```
# Decision: {title}

**Date:** YYYY-MM-DD  
**Domain:** {domain}  
**Status:** active

## Decision
{one clear sentence}

## Context
{why this came up}

## Alternatives Considered
1. **{Option A}** — {why rejected}
2. **{Option B}** — {why rejected}
3. **{Chosen}** — selected

## Reasoning
{the core logic}

## Trade-offs Accepted
{what was given up}

## Success Signal
{how you will know this was right — in 30/90 days}

## Supersedes
{path to prior decision file, or "none"}
```

### Step 5: Update meta.json
Increment `decision_count`. Update `last_active` to today.

### Step 6: Offer to create hypothesis
If the decision is based on an assumption: 
"ההחלטה הזו מבוססת על הנחה — כדאי לעקוב אחריה עם /hypothesis?"

### Step 7: Output

JSON (always write this):
```json
{
  "status": "logged",
  "file": ".pm-brain/decisions/YYYY-MM-DD-{slug}.md",
  "domain": "{domain}",
  "decision_count": {new total},
  "supersedes": null
}
```

Human message:
```
החלטה נרשמה: {title}
Domain: {domain}
קובץ: .pm-brain/decisions/{filename}
Success signal: {signal} — תבדוק/י בעוד 90 יום
```

## Notes
- Always search before logging — avoid duplicate decisions
- If user is in a hurry: accept a brief answer for each question, don't push for elaboration
- The file MUST exist before reporting success
