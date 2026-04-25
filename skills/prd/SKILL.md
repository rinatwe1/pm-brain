---
name: prd
description: Write a PRD through interactive conversation. One question at a time. Covers problem, users, functionality, user stories, success metrics, scope, design, dependencies, and edge cases. Outputs a clean markdown PRD. Saves to .pm-brain/ if initialized.
---

# /prd — Write a PRD Interactively

## When to use
- Starting a new feature or initiative
- Formalizing something already in progress
- Before any dev work begins

## Opening

**First time / new feature:**
```
ברוך הבא ל-/prd 👋

הנה הדרך:
• קודם — מה רוצים לבנות ולמה
• אחר כך — שאלה אחת בכל פעם: מטרה, משתמשים, פונקציונליות, הצלחה
• בסוף — PRD נקי ומוכן

👉 משפט אחד: מה רוצים לבנות?
```

**If .pm-brain/ exists:** Before starting, check `.pm-brain/knowledge/` for relevant context. Reuse anything relevant (primary user, stage, known constraints) instead of re-asking.

## Rules throughout the process

1. **One question at a time** — never ask two questions in one message
2. **Summarize before moving on** — after each answer, echo back in 1-2 sentences: "אז המטרה היא X, נכון?"
3. **Cross-section reuse** — if the user already mentioned something, don't re-ask. Confirm instead: "ציינת קודם X — האם זה נכון כאן גם?"
4. **Vague answer → clarify** — if answer is too broad (e.g., "כל המשתמשים"), offer 2-3 examples to sharpen it
5. **Escape hatch** — user can say "המשך בלעדי" at any point → Claude fills remaining sections from context and generates

## Questions (9 areas)

### 1. Problem / Goal
*"איזו בעיה הפיצ'ר הזה פותר? מה המטרה העיקרית?"*

⚠️ Always open question. No suggestions.

**Optional strategic follow-up (always ask, always optional):**
> "אופציונלי: יש לך מטרות עסקיות שזה קשור אליהן (retention, revenue, differentiation)?
> זה מה שהופך PRD מטקטי לאסטרטגי. אפשר לדלג ולהוסיף אחר כך."

### 2. Target User
*"למי הפיצ'ר הזה מיועד?"*

If vague: "Got it — כדי לדייק, האם זה לכל המשתמשים, למנויים פרמיום, או לסגמנט כמו [example]?"

### 3. Core Functionality
*"מה הפעולות הבסיסיות שהמשתמש חייב להיות מסוגל לעשות?"*

After answer: suggest 2-3 bullets → "האם זה נכון, או לשנות?"

### 4. User Stories
*"תן/י דוגמאות בפורמט: 'כ-[משתמש], אני רוצה ל-[פעולה] כדי ש-[תועלת]'"*

After approval: 
> 🚀 יופי — כיסינו יותר ממחצית הדרך! עוד קצת ויש PRD מלא.

### 5. Success Criteria
*"איך נדע שהפיצ'ר הצליח?"*

After answer: compare to Core Functionality. If misaligned: "שמתי לב שה-success metrics לא מתיישרים עם הפונקציונליות שהגדרנו — רוצה לחזור ולעדכן אחד מהם?"

**Optional strategic follow-up:**
> "אופציונלי: לחבר את ה-metrics להשפעה עסקית רחבה יותר (NPS, churn, revenue)?
> זה מה שהופך את ה-PRD לאסטרטגי. אפשר לדלג."

### 6. Scope / Out of Scope
*"מה הפיצ'ר הזה לא יעשה?"*

After answer: suggest 2-3 boundaries → "האם זה נכון?"

### 7. Design / UI
*"יש מוקאפים או העדפות UI ספציפיות?"*

Optional — user can skip.

### 8. Dependencies / Setup
*"יש תלויות, אינטגרציות, או הנחות טכניות? (auth, DB, email provider, etc.)"*

**Optional follow-up:**
> "יש הנחות או סיכונים שכדאי לתעד כאן? (API חיצוני, פרטיות, זמינות)
> תמיד אשאל — כדי שלא תפספסי. אפשר לדלג."

### 9. Edge Cases
*"אילו מקרי קצה או שגיאות צריך לקחת בחשבון?"*

Default: 2-3 bullets. If user asks for more: 6-8 bullets.

---

## Generate PRD

After all questions (or escape hatch), generate the full PRD:

```markdown
# PRD: [Feature Name]

**Date:** YYYY-MM-DD
**Status:** Draft
**Author:** [from meta.json if available]

---

## 1. Overview
[Brief description + problem it solves + goal]

## 2. Goals
[Specific, measurable objectives. Include business goals if answered.]

## 3. User Stories
[User narratives from Q4]

## 4. Functional Requirements
1. [Requirement — clear, unambiguous]
2. [Requirement]
...

## 5. Out of Scope
- [Explicit boundary]
- [Explicit boundary]

## 6. Design Considerations
[Mockups, UI notes, or "TBD"]

## 7. Dependencies & Assumptions
[Technical constraints, integrations, risks]

## 8. Success Metrics
[How success is measured. Include strategic impact if answered.]

## 9. Open Questions
- [Remaining unknowns]
```

**Always generate full PRD by default.** Don't shorten unless user asks.

## Save PRD

If `.pm-brain/` exists:
- Save to `.pm-brain/decisions/YYYY-MM-DD-prd-[feature-slug].md`
- Update meta.json `decision_count`

Always offer to also save as standalone file: `prd-[feature-name].md` in current directory.

## Closing

**If strategic sections (1.1 + 5.1) were answered:**
```
🎉 יש לך PRD מלא ואסטרטגי.

הצעד הבא:
1. גרסה קלה לשיתוף עם stakeholders
2. פירוק למשימות dev
3. לוג ה-PRD כהחלטה → /decision-log
```

**If strategic sections were skipped:**
```
🎉 יש לך PRD בסיסי.

רוצה לשדרג אותו?
- להוסיף מטרות עסקיות + השפעה אסטרטגית
- לפרק למשימות dev
- או להמשיך ככה
```

## Notes
- Always read .pm-brain/ before starting — reuse known context
- PRD target reader: dev team or vibe-coding platform (explicit, unambiguous)
- Filename convention: `prd-[meaningful-feature-name].md`
