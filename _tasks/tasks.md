---
project: PM-Brain
type: task-board
updated: 2026-05-02
owner: רינת
phases: [1.5-usability, 2a-synthesize-meeting, 2b-synthesize-types, 2c-hooks, 2d-router]
---

# PM-Brain — Task Board

---

## Phase 1.5 — Usability

---

### T01 — Usability Audit

```yaml
due: 2026-05-04
priority: critical
status: done
completed: 2026-05-02
tags: [usability, phase-1.5]
```

הלך על כל ה-flow כמשתמש חדש שלא בנה את המערכת:

1. install.sh — האם עובד על path נקי? מה קורה אם PM-Brain בתיקייה אחרת?
2. `/brain-init` — מה קורה אם מריצים מתיקייה לא נכונה? אם knowledge-base לא נגיש?
3. `/brain-import` — מה קורה אם אין `.pm-brain/`? אם אין קבצי markdown?
4. `/decision-log` — מה קורה בלי `.pm-brain/`?
5. QUICKSTART — האם ניתן לבצע step by step ללא ידע קודם?

**Output:** `_docs/usability-issues.md` — רשימת כשלים ממוינת לפי חומרה.
**Criterion:** רשימה מלאה לפני שממשיכים לתיקונים.

---

### T02 — תיקון QUICKSTART + README

```yaml
due: 2026-05-05
priority: critical
status: done
completed: 2026-05-02
tags: [usability, phase-1.5]
blockedBy: T01
```

בעיות ידועות לתיקון:

1. `[repo-url]` — placeholder ללא URL אמיתי
2. "Claude now reads `.pm-brain/` automatically" — **לא נכון**, לתקן לניסוח מדויק
3. Troubleshooting — להוסיף: skills לא נמצאות, שגיאת YAML, תיקייה לא נכונה
4. Daily workflow — להוסיף `/synthesize-meeting` ברגע שנבנה

**Output:** QUICKSTART.md + README.md מעודכנים.

---

### T03 — Audit Skills לError Messages

```yaml
due: 2026-05-06
priority: high
status: done
completed: 2026-05-02
tags: [usability, phase-1.5]
blockedBy: T01
```

לבדוק בכל skill: מה קורה כשמשהו לא תקין?

- [ ] מה קורה כשמריצים ללא `.pm-brain/`?
- [ ] מה קורה כשמריצים מתוך PM-Brain במקום תיקיית המוצר?
- [ ] האם יש הודעת שגיאה ברורה?

**Skills לבדוק:** brain-init, brain-import, decision-log, hypothesis, brain-review

**Output:** הוספת guard clause ברור לכל skill עם silent fail.
**דוגמה:** "לא מצאתי .pm-brain/ — פתחת Claude Code בתיקיית המוצר? הרץ /brain-init קודם."

---

### T04 — Fix: market/ domain לא נוצר ב-brain-init

```yaml
due: 2026-05-06
priority: high
status: done
completed: 2026-05-02
tags: [usability, phase-1.5, bug]
```

**נסגר בaudit (T01):** brain-init כבר יוצר market/ כחלק מ-7 ה-domains. הבאג לא קיים.

---

## Phase 2 — Synthesis Pipeline

---

### T05 — עיצוב /synthesize-meeting

```yaml
due: 2026-05-08
priority: high
status: done
tags: [synthesis, phase-2]
```

**לפני שכותבים — מגדירים את התבנית.**

#### Output template:

```yaml
---
type: meeting-synthesis
date: YYYY-MM-DD
title: [קצר — 3-5 מילים]
participants: []
meeting_type: strategy / product / technical / stakeholder / other
---
```

#### סעיפים ב-body:
- **Summary** (2-3 שורות)
- **Key Decisions** (מה, למה, owner)
- **Open Questions** (לא נפתרו + context)
- **Action Items** (מה | מי | מתי)
- **Assumptions Surfaced** (נאמרו כעובדה אבל לא מוכחים)
- **Evidence / Quotes** (ציטוטים + speaker)
- **Suggested Links** (קשרים ל-decisions/ ו-hypotheses/ קיימים)
- **Recommended SNAPSHOT update** (הצעה בלבד — לא אוטומטי)

#### החלטות שהתקבלו (2026-05-01):
1. **שמירה:** אוטומטית ב-`.pm-brain/meetings/YYYY-MM-DD-[slug].md` — ללא שאלה
2. **linking scope:** סורקת כל `.pm-brain/` — החלטה זמנית, ראה T07
3. **confirmation:** לא. מתחיל מייד

#### Guard clauses:
- **אין `.pm-brain/`:** יוצרת `.pm-brain/meetings/` ומודיעה ש-brain-init לא הורץ + מסבירה למה כדאי. הבדיקה הזו צריכה להיות עקבית בכל ה-skills (ראה T03).
- **input < 50 מילה:** שואלת לאישור לפני שממשיכת

**Output:** `_docs/synthesize-meeting-spec.md` עם template מוסכם.

---

### T06 — Build: /synthesize-meeting skill

```yaml
due: 2026-05-12
priority: high
status: done
tags: [synthesis, phase-2]
blockedBy: T05
```

**Input:** raw meeting notes — transcript, bullet points, או email summary.

**מה ה-skill עושה:**
1. מקבל raw input (paste ישיר או שם קובץ)
2. מחלץ לפי template שהוגדר ב-T05
3. סורקת כל `.pm-brain/` — מחפשת קשרים (זמני — ראה T07)
4. יוצרת קובץ ב-`.pm-brain/meetings/YYYY-MM-DD-[slug].md`
5. מציגה "Recommended SNAPSHOT update" — לא מעדכנת לבד

**בדיקה על 3 inputs:**
1. Transcript מלא עם דיאלוג
2. Bullet notes קצרות (10 שורות)
3. Email summary של פגישה

**Output:** `skills/synthesize-meeting.md` עובד + 3 output examples.

---

### T07 — Review: טווח סריקת Linking Engine

```yaml
due: 2026-05-15
priority: medium
status: blocked
tags: [synthesis, linking, phase-2, review]
blockedBy: T06
context: לבצע שבוע אחרי שימוש ראשוני ב-synthesize-meeting
```

**ההחלטה הנוכחית (2026-05-01):** סריקת כל `.pm-brain/`.

**למה צריך לבחון:** בפרויקט גדול (50+ decisions, 40+ hypotheses, 19 קבצי knowledge) הסריקה תייצר רעש ותעלה memory. ייתכן שצריך לצמצם.

**לבדוק:**
- [ ] כמה קישורים מוצעים בממוצע לכל synthesis?
- [ ] כמה מהם רלוונטיים לעומת רעש?
- [ ] האם knowledge/ מוסיף ערך אמיתי לlinking?

**אופציות:**
- א) רק decisions/ + hypotheses/ (ברירת מחדל)
- ב) smart routing לפי גודל פרויקט
- ג) להשאיר כמו שזה

**Output:** החלטה מתועדת + עדכון T06 אם צריך.

---

## Phase 2b — סוגי Synthesis נוספים

---

### T08 — Build: /synthesize-interview skill

```yaml
due: 2026-05-01
priority: high
status: done
tags: [synthesis, phase-2b]
blockedBy: T06
```

**מה זה:** synthesis לשיחות משתמש — Teresa Torres continuous discovery style.

**שונה מmeeting בכך ש:**
- מחלץ: quotes, jobs-to-be-done, pain points, behavioral patterns
- לא מחלץ: action items, decisions (אלה לא נוצרים בinterview)
- מציע hypotheses חדשות לlog על בסיס מה שנאמר

**Output template:**
```yaml
type: interview-synthesis
date: YYYY-MM-DD
interviewee: [תפקיד — לא שם]
product_stage: [שלב המוצר בזמן הinterview]
```

**סעיפים:** Summary | Jobs To Be Done | Pain Points | Quotes | Behavioral Patterns | Suggested Hypotheses | Suggested Links

**Output:** `skills/synthesize-interview.md` עובד.

---

### T09 — Build: /synthesize-research skill

```yaml
due: 2026-05-01
priority: medium
status: done
tags: [synthesis, phase-2b]
blockedBy: T08
```

**מה זה:** synthesis לחומר חיצוני — מאמרים, ניתוח מתחרים, ניסויים, שיחות AI.

**מחלץ:** insights, implications, evidence רלוונטי למוצר, suggested decisions/hypotheses

**Output template:**
```yaml
type: research-synthesis
date: YYYY-MM-DD
source_type: article / competitor / experiment / ai-conversation
source: [שם/URL]
```

**סעיפים:** Summary | Key Insights | Implications for Product | Evidence | Suggested Links

**Output:** `skills/synthesize-research.md` עובד.

---

## Phase 2c — Hooks (מכניים בלבד)

> להריץ אחרי שT06 עובד ונוסה. Hooks מגנים על המערכת בלי לפרש כלום.

---

### T10 — Mechanical Hooks

```yaml
due: 2026-05-01
priority: high
status: done
tags: [hooks, automation, phase-2c]
blockedBy: T06
```

**מה לבנות ב-Claude Code settings.json:**

**Hook 1 — post-edit על `.pm-brain/**`:**
- validates YAML frontmatter תקין
- בודק required fields חסרים
- בודק broken links

**Hook 2 — session-start:**
- מזכיר לקרוא SNAPSHOT.md אם לא נקרא

**מה לא לבנות:**
- ❌ hook שמעדכן SNAPSHOT אוטומטית — זה semantic, לא מכני
- ❌ hook שמחליט מה חשוב — זה תפקיד האדם

**עיקרון:** auto-fix structure. surface judgment. לעולם לא לשנות תוכן בלי אישור.

**Output:** `.claude/settings.json` מעודכן + בדיקה שה-hooks מופעלים.

---

## Phase 2d — Router

> להריץ רק אחרי שיש 3 סוגי synthesis טובים (T06 + T08 + T09). Router לפני עומק = אשליית חוכמה.

---

### T11 — Build: /synthesize router

```yaml
due: 2026-05-01
priority: high
status: done
tags: [synthesis, router, phase-2d]
blockedBy: T09
```

**מה זה:** skill אחת שמחליפה את T06 + T08 + T09 כentry point יחיד.

**מה הrouter עושה:**
1. מקבל raw input
2. מזהה סוג: meeting / interview / research / competitor / experiment
3. מנתב לskill המתאימה
4. PM מדביק — לא צריך לדעת את המערכת

**למה רק עכשיו:**
router לפני שיש התמחויות טובות = output בינוני בכל סוג. עומק לפני רוחב.

**Output:** `skills/synthesize.md` — router בלבד, הlogic נשאר בskills הייעודיות.
