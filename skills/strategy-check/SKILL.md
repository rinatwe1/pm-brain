---
name: strategy-check
description: Monthly strategic check-in — validates ICP, competitive landscape, and core assumptions for any product. Based on Pichler's continuous strategizing framework.
allowed-tools: Read, Write, Glob, WebFetch
---

# /strategy-check — Strategic Check-In

**מבוסס על:** Roman Pichler, "Continuous Strategizing" — האסטרטגיה לא נעצרת בהשקה. השוק זז, ה-ICP משתנה, מתחרים חדשים נכנסים. הסקירה הזו מכריחה לשאול: מה השתנה מאז הפעם האחרונה?

**מתי להריץ:** פעם בחודש, בתחילת חודש חדש.

---

## Usage

```
/strategy-check spirit
/strategy-check recipehub
/strategy-check          ← שואל איזה פרויקט
```

---

## Process

### Step 0: זיהוי פרויקט + קריאת context

1. אם לא הועבר שם פרויקט → שאל: "על איזה פרויקט?"
2. קרא `projects-overview.md` מ-Work/ לרקע בסיסי
3. נסה לקרוא את קובץ ה-CLAUDE.md של הפרויקט אם קיים
4. נסה לקרוא קובץ אסטרטגיה קיים: `[project]/strategy-check-log.md`
5. אם יש לוג קודם — מציג "נבדק לאחרונה: [תאריך]. מה השתנה מאז?"

---

### Step 1: שבע שאלות Pichler

הצג כל שאלה בתור-אחד. אחרי כל תשובה — אם התשובה מעלה flag (ראה להלן), סמן אותו.

---

**שאלה 1 — Vision**
> האם הסיבה לקיום המוצר עדיין נכונה?

הצג את ה-vision הנוכחי (מה-context). שאל:
- "האם נשאר נכון? האם ראית משהו שמאתגר אותו?"

---

**שאלה 2 — ICP (Target Group)**
> האם אנחנו עדיין מדברים עם האנשים הנכונים?

הצג את ה-ICP הנוכחי. שאל:
- "מי השתמש במוצר לאחרונה? האם הם מי שחשבנו?"
- "האם נוצר segment חדש שלא ציפינו לו?"
- "האם ה-ICP הצהרתי = ה-ICP האמיתי?"

🚩 **Flag אם:** יש פער בין מי שאנחנו מדברים עליו לבין מי שמשתמש בפועל.

---

**שאלה 3 — User Needs**
> האם הבעיות שאנחנו פותרים עדיין כואבות?

שאל:
- "האם שמעת feedback מלקוחות/משתמשים לאחרונה?"
- "האם יש כאב שגדל? כאב שנעלם?"
- "האם גילינו צורך חדש שלא היה ב-PRD?"

🚩 **Flag אם:** יש צורך מרכזי שלא עונים לו, או need שהפך לפחות חשוב.

---

**שאלה 4 — Key Features / Bets**
> האם ה-features שאנחנו בונים עדיין ההימורים הנכונים?

הצג features מרכזיות מה-MVP. שאל:
- "האם יש feature שנראה פחות חשוב ממה שחשבנו?"
- "האם יש feature חדש שכדאי להוסיף ל-scope?"
- "האם גילינו ש-feature מסוים = must-have ולא nice-to-have?"

🚩 **Flag אם:** תעדוף ה-features נראה שגוי לאור מידע חדש.

---

**שאלה 5 — Business Goals**
> האם יעדי העסק עדיין רלוונטיים?

הצג יעדים מרכזיים (מה-context). שאל:
- "האם יש לחץ חדש מהחברה/שותפים על לוח הזמנים?"
- "האם המודל העסקי (עמלות, subscription) עדיין נכון?"
- "האם נוצרה הזדמנות הכנסה חדשה?"

🚩 **Flag אם:** יש misalignment בין מה שבונים לבין מה שהעסק צריך עכשיו.

---

**שאלה 6 — Competitive Landscape**
> האם הנוף התחרותי השתנה?

הצג מתחרים ידועים. שאל:
- "האם נכנס מתחרה חדש לתחום?"
- "האם מתחרה קיים עשה move משמעותי (פיצ'ר חדש, funding, שינוי מחיר)?"
- "האם יש כלי/פלטפורמה חדשה שמאיימת על ה-differentiation שלנו?"

🚩 **Flag אם:** יש מתחרה חדש רלוונטי, או שה-differentiation נחלש.

---

**שאלה 7 — Core Assumptions**
> אילו הנחות אנחנו עדיין מניחים שצריכות לעבור בדיקה?

שאל:
- "מה ההנחה הגדולה ביותר שעוד לא אימתנו?"
- "האם הנחה מרכזית הוכחה כשגויה לאחרונה?"
- "מה ה-riskiest assumption שעומד בפנינו?"

🚩 **Flag אם:** יש הנחה שנבדקה ונמצאה שגויה — זה signal לשינוי אסטרטגי.

---

### Step 2: סיכום + flags

אחרי 7 השאלות, הצג:

```
## סיכום Strategic Check-In — [פרויקט] — [תאריך]

### 🚩 Flags שעלו (דברים שדורשים תשומת לב):
- [flag 1]
- [flag 2]

### ✅ תקין (לא השתנה):
- [item 1]
- [item 2]

### 📋 המלצות:
- [המלצה קונקרטית לפעולה]
```

אם **0 flags** — "האסטרטגיה נראית יציבה לחודש הבא."
אם **1-2 flags** — "יש דברים שכדאי לבחון לפני הספרינט הבא."
אם **3+ flags** — "יש מספיק signals לסשן strategy מעמיק."

---

### Step 3: שמירה

שאל: "לשמור את הסיכום?"

אם כן — הוסף את הסיכום ל: `[project-folder]/strategy-check-log.md`

פורמט לוג:
```markdown
---

## Check-In: [תאריך]

**Flags:** [מספר]

### שאלות ותשובות
[תמלול קצר]

### סיכום
[הסיכום מ-Step 2]
```

---

## Scheduling (חודשי)

להפעיל פעם בחודש. אפשר להגדיר תזכורת ב-tasks:
```bash
# להוסיף ל-_System/tasks/:
# type: task
# due: [ראשון לחודש הבא]
# tags: [strategy, spirit, monthly]
# title: Strategy Check-In — Spirit
```

---

## Notes

- **לא** מחפש תשובות "נכונות" — מחפש שינויים לעומת הפעם הקודמת
- **לא** צריך לענות על כל שאלה בהרחבה — "לא השתנה" זו תשובה תקפה
- הערך הוא בשאלת השאלה, לא רק בתשובה
- אחרי 3 check-ins יש pattern — אפשר לזהות טרנד

---

**Created:** 22 אפריל 2026
**Based on:** Roman Pichler — Continuous Strategizing
**Source:** https://romanpichler.medium.com/how-to-use-ai-to-create-a-winning-product-strategy-921a71043621
