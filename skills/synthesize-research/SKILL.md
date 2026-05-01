---
name: synthesize-research
description: Turn external material into structured product knowledge. Covers articles, competitor analysis, experiments, and AI conversations. Extracts insights, implications, and evidence. Saves to .pm-brain/research/.
---

# /synthesize-research — Research Synthesis

## When to use
- Reading a relevant article or post (like Ido Halevi's articles)
- Analyzing a competitor
- Reviewing an experiment result
- After a long AI conversation with insights worth keeping

## Process

### Step 1: Identify source type

Determine which type:
- `article` — blog post, paper, newsletter
- `competitor` — competitor website, product, announcement
- `experiment` — A/B test, fake-door, prototype test result
- `ai-conversation` — insight-rich conversation worth keeping

### Step 2: Guard clauses

**Check for `.pm-brain/`:**  
If not found:
- Create `.pm-brain/research/`
- Warn: "לא מצאתי `.pm-brain/` — brain-init לא הורץ. כדאי להריץ אותו."

If `.pm-brain/research/` missing — create silently.

### Step 3: Extract structured data

**For all types:**
- Key insights (what is new or useful)
- Implications for the product (so what?)
- Evidence or data points worth referencing

**For `competitor`:**
- What they do that we don't
- What we do that they don't
- Positioning differences
- Changes since last review (if prior file exists)

**For `experiment`:**
- Hypothesis tested
- Result (validated / invalidated / inconclusive)
- What to do next

**For `ai-conversation`:**
- Key decisions or directions that emerged
- Open questions that surfaced
- Assumptions that should be logged

### Step 4: Search for connections

Search `.pm-brain/` for related decisions, hypotheses, knowledge.  
Prepare suggested links.

### Step 5: Write artifact

**Path:** `.pm-brain/research/YYYY-MM-DD-[slug].md`  
**Slug:** source-type + 2 keywords, kebab-case

```
---
type: research-synthesis
date: YYYY-MM-DD
source_type: article | competitor | experiment | ai-conversation
source: [name or URL]
links:
  - [path if any]
---

## Summary
[2-3 sentences: what this is and why it matters]

## Key Insights
- [Insight] — [why it matters for the product]

## Implications
- [Implication] — [what to do or reconsider]

## Evidence
- "[quote or data point]" — [source]

## [For competitor only] Competitive Gaps
| We have | They have | Gap |
|---------|-----------|-----|

## [For experiment only] Result
- Hypothesis: [what was tested]
- Result: validated / invalidated / inconclusive
- Next step: [what to do]

## Suggested Links
- [[decisions/YYYY-MM-DD-slug]] — [why relevant]
- [[hypotheses/HYP-NNN-slug]] — [why relevant]

## Suggested Decisions or Hypotheses
- [If something should be logged]
```

### Step 6: Output to user

JSON:
```json
{
  "status": "synthesized",
  "file": ".pm-brain/research/YYYY-MM-DD-[slug].md",
  "source_type": "[type]",
  "insights_found": [count],
  "links_suggested": [count]
}
```

Human message:
```
סינתזה נשמרה: [source type] — [title/name]
קובץ: .pm-brain/research/[filename]

[if decisions suggested]: 📋 שווה לlog החלטה — הרצי /decision-log
[if hypotheses suggested]: 💡 שווה לlog hypothesis — הרצי /hypothesis
[if links found]: 🔗 [N] קשרים הוצעו
```

## Notes
- Implications are more valuable than summaries — always answer "so what?"
- For competitors: check if a prior file exists before creating a new one (update > duplicate)
- For experiments: always link to the hypothesis that was tested
