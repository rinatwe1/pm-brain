# PM Brain — Strengths & Weaknesses

*Updated: 2026-05-01 | Source: comparative analysis vs. Ido Halevi's system + internal review*

---

## חוזקות

### 1. PM knowledge base מוכן מהיום הראשון
19 קבצים מ-13 ספרי PM (Mom Test, INSPIRED, Continuous Discovery Habits ועוד).
המתחרים לא מציעים זה — AI-SHIPR stateless, Pawel Huryn manual. PM שמתקין מקבל frameworks מגובשים מייד.

### 2. Hypothesis lifecycle מלא
log → validate → kill → auto-promote (3x validations → rule).
אידו הלוי לא מתאר מנגנון כזה. זה היכולת הכי ייחודית — הנחות מתות או מתחזקות, לא מתגלגלות לנצח כ"אולי".

### 3. Monthly pruning מובנה (`/brain-review`)
מנגנון לסילוק ידע מיושן, החלטות שפגו, hypotheses שפגו. ללא זה memory הופכת לרעש.

### 4. Install חכם — 3 פקודות, אחר כך שוכח
`git clone + ./install.sh` — הskills מקושרים, מוכן לעבודה. אידו דורש Obsidian vault, CODEOWNERS, TypeScript hooks — overhead משמעותי.

### 5. CLI-native, zero context switch
עובד בתוך Claude Code. PM לא עוזב את IDE. מתחרים כמו Squad AI, Notion AI מצריכים switch לכלי אחר.

### 6. SNAPSHOT.md — session state אוטומטי
כל session נפתח עם תמונת מצב עדכנית. PM לא צריך לעדכן context ידנית.

---

## חולשות

### 1. אין synthesis pipeline — הפער הגדול ביותר
PM-Brain מכנסת ידע שכבר עיכלת. אין יכולת לקחת raw input (transcript פגישה, notes interview, מאמר מחקר) ולהפוך אותו ל-structured knowledge.
**השלכה:** compounding לא קורה. כל decision log הוא נקודתי, לא מבוסס evidence base שצומח.

### 2. אין document linking (graph)
קבצים ב-`.pm-brain/` לא מחוברים זה לזה. decision לא מקושר ל-hypothesis שמשך אותו, hypothesis לא מקושר ל-interview שתמך בו.
**השלכה:** "why did we decide X?" עונה על מה, לא על למה ובאיזה evidence.

### 3. הכל manual — אין hooks
שום דבר לא קורה בלי invocation מפורשת. YAML שנשבר לא מתגלה. SNAPSHOT שלא עודכן — לא מישהו יזהיר.
**השלכה:** infrastructure שדורש discipline הוא לא infrastructure.

### 4. אין router — friction גבוה לmulti-PM
PM חדש חייב ללמוד: `/decision-log` לא `/hypothesis`, `/brain-import` לא `/brain-review`.
**השלכה:** team adoption קשה. barrier to entry גבוה ממה שצריך.

### 5. Agents — skeleton בלבד
`competitor-watcher` קיים אבל manual. אין orchestrator אמיתי. אין scheduling.
**השלכה:** הבטחת "Claude that runs while you sleep" לא מתקיימת בv0.1.

### 6. אין visibility לcompounding
PM לא רואה "יש לך 12 decisions, 8 rules, 3 hypotheses active". הצבירה קורה, אבל אנשים לא מרגישים אותה.
**השלכה:** hard to sell the value internally. UI decision עדיין פתוחה (ראה ui-and-positioning.md).

---

## סיכום תמציתי

| מימד | PM-Brain | מה חסר |
|------|---------|---------|
| ידע מוכן | ✅ חזק | — |
| hypothesis lifecycle | ✅ ייחודי | — |
| install friction | ✅ נמוך | — |
| synthesis pipeline | ❌ לא קיים | `/synthesize` skill |
| document graph | ❌ חסר | WikiLinks / linking |
| automation | ❌ manual only | hooks |
| team adoption | ⚠️ friction | router pattern |
| agents | ⚠️ skeleton | orchestrator |
