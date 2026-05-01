---
name: synthesize
description: Router — detects input type and routes to the right synthesis skill. Use this instead of /synthesize-meeting, /synthesize-interview, or /synthesize-research. Paste any raw input and Claude will figure out the rest.
---

# /synthesize — Synthesis Router

## When to use
Any time you have raw product context to process — meeting notes, interview transcript, article, competitor info, experiment result, or AI conversation. Paste it in and the router detects what it is.

## Process

### Step 1: Detect input type

Read the input and determine which type applies:

| Signal | Type | Routes to |
|--------|------|-----------|
| דיאלוג / agenda / action items / פגישה | meeting | /synthesize-meeting |
| "הם אמרו" / "המשתמש" / interview / user research | interview | /synthesize-interview |
| מאמר / מתחרה / competitor / ניסוי / AI conversation | research | /synthesize-research |

**If unclear:** ask one question: "זה notes מפגישה, שיחת משתמש, או חומר חיצוני (מאמר/מתחרה/ניסוי)?"

### Step 2: Confirm and route

Tell the user what was detected:
> "זיהיתי: [type]. מעבד עם /synthesize-[type]..."

Then execute the full logic of the appropriate skill (synthesize-meeting / synthesize-interview / synthesize-research).

## Notes
- The router is a thin dispatcher — all logic lives in the sub-skills
- Never guess if genuinely ambiguous — one clarifying question is better than a wrong synthesis
- If the user explicitly specifies the type (e.g. "זה interview"), trust them over the auto-detection
