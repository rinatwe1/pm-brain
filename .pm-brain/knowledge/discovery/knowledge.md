---
type: knowledge
domain: discovery
updated: 2026-05-01
---

## Product Description
PM Brain הוא PM memory system. מתקין פעם אחת, יוצר `.pm-brain/` בכל תיקיית מוצר — כמו git. נותן ל-Claude זיכרון מוצרי לאורך זמן שמצטבר session אחרי session.
Source: brain-init / product-story.md

## Primary User
Technical PM שמשתמש ב-Claude Code יומיומית. כותב specs, PRDs, מחליט החלטות מוצריות. מרגיש את ה-context tax — מסביר לClaude שוב ושוב את אותם דברים. טכני מספיק בשביל git clone + bash installer.
Source: brain-init / PRD.md

## Core Job-to-be-Done
להפסיק להסביר לClaude את ה-context מחדש בכל שיחה. "Claude שיזכור את המוצר שלי כמו senior team member שהיה בכל פגישה."
Source: product-story.md

## ICP (מחודד — 2026-04-26)
AI-native builders שעובדים בתוך Claude Code לפחות 2-3 שעות ביום. בונים לבד או בצוות קטן (0-5). משתמשים ב-Claude כcore workflow, לא ניסוי.
**מי לא ICP:** PMים קלאסיים בארגון גדול, מי שעובד ב-Notion/Jira כsource of truth.
Source: ui-and-positioning.md

## Killer Use Case
"prevent bad decisions from repeating" — PM מתחיל פיצ'ר, Claude מזהה "ניסינו משהו דומה לפני חודש ונכשל בגלל X."
Source: ui-and-positioning.md

## Killer Use Case — Success Criteria
✓ משתמש אומר: "זה חסך לי טעות"
✗ לא מספיק: "זה עוזר לי לחשוב"

השאלה הפתוחה: האם brain-init + decision-log מספיקים לייצר את הרגע הזה, או שצריך UI?
החלטה (2026-04-26): CLI קודם — UI רק אחרי שה-killer moment נחווה.
Source: ui-and-positioning.md / DEC-002
