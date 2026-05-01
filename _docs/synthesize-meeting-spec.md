# synthesize-meeting — Spec

**Version:** 1.0  
**Date:** 2026-05-01  
**Status:** approved

---

## Input

Raw meeting notes — כל אחד מהפורמטים הבאים:
- Transcript מלא עם דיאלוג
- Bullet notes (גם קצרות, 10 שורות)
- Email summary של פגישה
- הערות חופשיות

---

## Output — YAML Frontmatter

```yaml
---
type: meeting-synthesis
date: YYYY-MM-DD
title: [3-5 מילים — תיאור קצר של הפגישה]
participants: [תפקידים, לא שמות]
meeting_type: strategy | product | technical | stakeholder | other
source: [optional — שם הקובץ המקורי אם הוזן]
links:
  - .pm-brain/decisions/YYYY-MM-DD-slug.md
  - .pm-brain/hypotheses/HYP-001-slug.md
---
```

---

## Output — Body Sections

### Summary
2-3 שורות. מה דובר, מה יצא, מה לא נפתר.

### Key Decisions
כל החלטה שהתקבלה:
```
- **[כותרת ההחלטה]** — [הסבר קצר]. Owner: [תפקיד]
```

### Open Questions
שאלות שעלו ולא נענו:
```
- [שאלה] — Context: [למה זה חשוב]
```

### Action Items
| מה | מי | מתי |
|----|----|----|

### Assumptions Surfaced
דברים שנאמרו כעובדה אבל לא מוכחים:
```
- "[ציטוט או תיאור]" — לא מוכח, שווה לlog כ-hypothesis
```

### Evidence / Quotes
```
- "[ציטוט מדויק]" — [תפקיד הדובר]
```

### Suggested Links
קשרים ל-decisions/ ו-hypotheses/ קיימים ב-.pm-brain/:
```
- [[decisions/YYYY-MM-DD-slug]] — [למה רלוונטי]
- [[hypotheses/HYP-001-slug]] — [למה רלוונטי]
```

### Recommended SNAPSHOT Update
מה כדאי לעדכן ב-SNAPSHOT.md — הצעה בלבד, לא אוטומטי:
```
שורה מוצעת: "[עדכון קצר למצב הנוכחי]"
```

---

## Storage

**Path:** `.pm-brain/meetings/YYYY-MM-DD-[slug].md`  
**Slug:** 2-4 מילים מכותרת הפגישה, kebab-case  
**Auto-create:** אם `.pm-brain/meetings/` לא קיים — יוצר אוטומטית

---

## Guard Clauses

**אין `.pm-brain/`:**  
יוצרת `.pm-brain/meetings/` ושומרת, אבל מודיעה:  
> "לא מצאתי `.pm-brain/` — brain-init לא הורץ. שמרתי ב-meetings/, אבל בלי brain-init חסר לך decisions/, hypotheses/, knowledge/. כדאי להריץ /brain-init."

**Input קצר מ-50 מילה:**  
שואלת לאישור: "ה-input קצר מאוד — זה הכל? להמשיך בכל זאת?"

---

## Linking Scope (החלטה זמנית — 2026-05-01)

סורקת כל `.pm-brain/` — decisions/, hypotheses/, knowledge/.  
לבחון מחדש תוך שבוע אחרי שימוש ראשוני (ראה T07 בtasks.md).

---

## מה לא עושה

- לא מעדכנת SNAPSHOT אוטומטית
- לא כותבת ל-decisions/ ישירות (רק מציעה)
- לא שואלת confirmation לפני ריצה (אלא אם input קצר)
