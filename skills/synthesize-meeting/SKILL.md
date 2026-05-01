---
name: synthesize-meeting
description: Turn raw meeting notes into structured product memory. Extracts decisions, action items, assumptions, and links to existing .pm-brain/ knowledge. Saves to .pm-brain/meetings/.
---

# /synthesize-meeting — Meeting Synthesis

## When to use
After any meeting relevant to the product — strategy, product, technical, stakeholder, or team sync. Input can be a transcript, bullet notes, or an email summary.

## Process

### Step 1: Guard clauses

**Check input length:**  
If input is under 50 words — ask: "ה-input קצר מאוד — זה הכל? להמשיך בכל זאת?"  
Wait for confirmation before proceeding.

**Check for `.pm-brain/`:**  
If `.pm-brain/` does not exist in the current directory:
- Create `.pm-brain/meetings/` directory
- Warn: "לא מצאתי `.pm-brain/` — brain-init לא הורץ. שמרתי ב-meetings/, אבל בלי brain-init חסר לך decisions/, hypotheses/, knowledge/. כדאי להריץ /brain-init."

If `.pm-brain/` exists but `.pm-brain/meetings/` does not — create it silently.

### Step 2: Extract structured data

Read the raw input and extract:

- **Meeting type:** strategy / product / technical / stakeholder / other
- **Participants:** roles only (not names)
- **Date:** from input if mentioned, otherwise today's date
- **Title:** 3-5 words describing the meeting

Then extract content for each section:
- **Summary** — 2-3 sentences: what was discussed, what came out of it
- **Key Decisions** — each decision with owner (role) and brief rationale
- **Open Questions** — unresolved questions with context on why they matter
- **Action Items** — what, who (role), by when
- **Assumptions Surfaced** — things said as fact that are actually unvalidated
- **Evidence / Quotes** — notable quotes with speaker role

### Step 3: Search for connections

Search all of `.pm-brain/` — decisions/, hypotheses/, knowledge/ — for files related to topics discussed in the meeting.

For each match found, prepare a suggested link with a one-line reason why it's relevant.

If `.pm-brain/` only has `meetings/` (brain-init not run) — skip this step silently.

### Step 4: Build SNAPSHOT recommendation

Based on what was discussed, draft one sentence that could update SNAPSHOT.md.  
Do not write to SNAPSHOT.md — only present the suggestion.

### Step 5: Write artifact

**Path:** `.pm-brain/meetings/YYYY-MM-DD-[slug].md`  
**Slug:** 2-4 words from the meeting title, kebab-case

```
---
type: meeting-synthesis
date: YYYY-MM-DD
title: [3-5 מילים]
participants: [roles]
meeting_type: [type]
links:
  - [path if any]
---

## Summary
[2-3 sentences]

## Key Decisions
- **[Decision title]** — [rationale]. Owner: [role]

## Open Questions
- [Question] — Context: [why it matters]

## Action Items
| מה | מי | מתי |
|----|----|----|
| [action] | [role] | [date] |

## Assumptions Surfaced
- "[statement]" — לא מוכח, שווה לlog כ-/hypothesis

## Evidence / Quotes
- "[quote]" — [speaker role]

## Suggested Links
- [[decisions/YYYY-MM-DD-slug]] — [why relevant]

## Recommended SNAPSHOT Update
> "[suggested update line]"
```

### Step 6: Output to user

JSON (always write):
```json
{
  "status": "synthesized",
  "file": ".pm-brain/meetings/YYYY-MM-DD-[slug].md",
  "decisions_found": [count],
  "links_suggested": [count],
  "assumptions_surfaced": [count]
}
```

Human message:
```
סינתזה נשמרה: [title]
קובץ: .pm-brain/meetings/[filename]

[if assumptions found]: ⚠️ [N] הנחות עלו — שווה לlog אותן כ-/hypothesis
[if links found]: 🔗 [N] קשרים הוצעו — בדקי אם רלוונטיים

עדכון SNAPSHOT מוצע:
"[suggested update]"
```

## Notes
- Never auto-update SNAPSHOT.md — always suggest only
- Never write to decisions/ or hypotheses/ directly — only surface suggestions
- If the meeting had no clear decisions, say so explicitly rather than inventing them
- Preserve quotes verbatim — do not paraphrase
