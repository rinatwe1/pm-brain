---
type: quality-criteria
product: PM Brain
updated: 2026-05-01
---

# Quality Criteria — PM Brain

## Category: Skills
### Criteria:
- [ ] כל skill מתחילה עם guard clause ברור
- [ ] כל skill מייצרת JSON output + human message
- [ ] אין silent fail — כל מקרה שגיאה מוסבר למשתמש
### Severity: blocking
### Source: usability audit + design principles
### Last triggered: never

## Category: Synthesis
### Criteria:
- [ ] Synthesis לעולם לא מעדכן SNAPSHOT אוטומטית — רק מציע
- [ ] Synthesis לעולם לא כותב ל-decisions/ ישירות — רק מציע
- [ ] Quotes נשמרים verbatim — לא מנוסחים מחדש
### Severity: blocking
### Source: conservative automation principle
### Last triggered: never

## Category: Memory Structure
### Criteria:
- [ ] כל קובץ ב-.pm-brain/ מכיל YAML frontmatter עם type ו-date
- [ ] Decisions מתועדות עם alternatives + rationale
- [ ] Hypotheses מתועדות עם test method + expiry
### Severity: warning
### Source: data structure principles
### Last triggered: never

## Category: Development Process
### Criteria:
- [ ] לפני build — spec מוסכם (כמו synthesize-meeting-spec.md)
- [ ] לפני כל ביצוע — לפרט מה הובן ולחכות לאישור
- [ ] לא נוגעים בקוד לפני שusability validated
### Severity: warning
### Source: working agreements this session
### Last triggered: never
