---
name: synthesize-interview
description: Turn raw user interview notes into structured discovery memory. Extracts jobs-to-be-done, pain points, behavioral patterns, and verbatim quotes. Teresa Torres continuous discovery style. Saves to .pm-brain/interviews/.
---

# /synthesize-interview — User Interview Synthesis

## When to use
After any user interview, customer call, or user research session. Input can be a transcript, notes, or a recording summary.

## Process

### Step 1: Guard clauses

**Check input length:**  
If input is under 50 words — ask: "ה-input קצר מאוד — זה הכל? להמשיך בכל זאת?"

**Check for `.pm-brain/`:**  
If `.pm-brain/` does not exist:
- Create `.pm-brain/interviews/` directory
- Warn: "לא מצאתי `.pm-brain/` — brain-init לא הורץ. שמרתי ב-interviews/, אבל כדאי להריץ /brain-init."

If `.pm-brain/interviews/` does not exist — create it silently.

### Step 2: Extract structured data

- **Interviewee:** role only, never name
- **Product stage** at time of interview
- **Date:** from input if mentioned, otherwise today

Then extract:
- **Jobs To Be Done** — what the user is trying to accomplish (not features they asked for)
- **Pain Points** — specific friction, frustration, or blockers mentioned
- **Behavioral Patterns** — what they actually do (vs. what they say they do)
- **Quotes** — verbatim, preserved exactly
- **Surprises** — things that were unexpected or contradicted existing assumptions

### Step 3: Surface hypothesis suggestions

For each pain point or behavioral pattern found — check existing `.pm-brain/hypotheses/`.

If a match exists: suggest a link.  
If no match: suggest logging a new hypothesis with `/hypothesis`.

### Step 4: Search for connections

Search `.pm-brain/decisions/` and `.pm-brain/hypotheses/` for related files.  
Prepare suggested links with one-line reasons.

### Step 5: Write artifact

**Path:** `.pm-brain/interviews/YYYY-MM-DD-[slug].md`  
**Slug:** role + 2 keywords, kebab-case (e.g., `pm-context-switching`)

```
---
type: interview-synthesis
date: YYYY-MM-DD
interviewee_role: [role]
product_stage: [stage]
links:
  - [path if any]
---

## Summary
[2-3 sentences: who, what was learned, biggest surprise]

## Jobs To Be Done
- [Job] — [context]

## Pain Points
- [Pain] — [how they described it]

## Behavioral Patterns
- [Pattern] — [evidence from interview]

## Quotes
- "[verbatim quote]"
- "[verbatim quote]"

## Surprises
- [What was unexpected and why]

## Suggested Hypotheses to Log
- "/hypothesis: [assumption to track]" — confidence: [1-10]

## Suggested Links
- [[hypotheses/HYP-NNN-slug]] — [why relevant]
- [[decisions/YYYY-MM-DD-slug]] — [why relevant]
```

### Step 6: Output to user

JSON:
```json
{
  "status": "synthesized",
  "file": ".pm-brain/interviews/YYYY-MM-DD-[slug].md",
  "jobs_found": [count],
  "pain_points_found": [count],
  "hypotheses_suggested": [count],
  "links_suggested": [count]
}
```

Human message:
```
סינתזה נשמרה: interview — [role] — [date]
קובץ: .pm-brain/interviews/[filename]

[if hypotheses suggested]: 💡 [N] הנחות מוצעות לlog — שווה להריץ /hypothesis
[if links found]: 🔗 [N] קשרים הוצעו לתוצאות קיימות
```

## Notes
- Never use interviewee names — roles only
- Preserve quotes verbatim — never paraphrase
- Jobs To Be Done are goals, not feature requests ("I want to track decisions" not "add a dashboard")
- If interview contradicts an existing hypothesis — flag it explicitly
