# PM Brain — UI, ICP & Positioning Deliberations

Source: external Claude session feedback, 2026-04-26

---

## 1. ICP — חדד

**היפותזה נוכחית (רחבה מדי):** "PMs who use Claude Code"

**היפותזה חדה יותר:**
👉 AI-native builders שעובדים בתוך Claude Code לפחות 2–3 שעות ביום

**פרופיל מדויק:**
- בונים לבד או בצוות קטן (0–5 אנשים)
- משתמשים ב-Claude כ-core workflow — לא ניסוי
- כותבים PRDs / specs בתוך Claude
- מרגישים pain של context (לא תאורטי)

**מי לא ICP (חשוב):**
- PMים קלאסיים בארגון גדול
- אנשים שמשתמשים ב-AI כ-"assistant"
- מי שעובד ב-Notion/Jira כ-source of truth

**ההתלבטות:** האם לכוון רחב (יותר TAM) או צר (יותר PMF)?
→ דעת: אם נכוון רחב מדי — נאבד product-market fit מוקדם. כווני צר קודם.

---

## 2. Killer Use Case

**לא:** "memory" — כללי מדי, לא כואב

**כן:**
👉 "prevent bad decisions from repeating"

**התרחיש:**
- PM מתחיל פיצ'ר חדש
- Claude מזהה: "ניסינו משהו דומה לפני חודש ונכשל בגלל X"

**למה זה חזק:**
- value מיידי — לא 90 יום
- emotional hit — "איך שכחתי את זה?"
- קשה לשכפל בלי memory אמיתי

**איך למדוד שזה עובד:**
- ✓ משתמש אומר: "זה חסך לי טעות"
- ✗ לא: "זה עוזר לי לחשוב"

**השאלה הפתוחה:** האם `/brain-init` + `/decision-log` מספיקים כדי לייצר את הרגע הזה, או שצריך את ה-UI כדי שהמשתמש "יראה" את זה?

---

## 3. Positioning — חדד

**נוכחי:** "Git for product knowledge" — טוב, אבל abstract

**אופציה 1 (חדה יותר):**
👉 "Never repeat a product mistake twice"
ברור, כואב, קונקרטי

**אופציה 2 (יותר accessible):**
👉 "Claude that remembers your product decisions"
קל להבין, פחות חד

**מה להימנע:**
- "memory system" — נשמע כמו עוד כלי
- "product OS" — too broad
- "knowledge base" — boring

**ההתלבטות:** האם הפוזישנינג צריך למשוך technical PMs (אופציה 1) או broader audience (אופציה 2)?

---

## 4. UI — כן או לא?

**ההתלבטות המרכזית:**
UI זה leverage על competitors — אבל רק אם הוא מראה משהו שאי אפשר להבין מקריאה של markdown.

**מה כן נותן leverage (3 דברים):**

1. **Decision Timeline (הכי חשוב)**
   - Timeline כרונולוגי — למה התקבלה כל החלטה + מה קרה אחר כך
   - הופך "history" ל-"learning system"

2. **Hypothesis Engine**
   - כמה hypotheses: active / validated / killed
   - הופך discovery למדיד

3. **"You are repeating yourself"**
   - Highlight: החלטות דומות, הנחות שחזרו
   - זה משהו שאף tool לא עושה היום

**מה לא נותן leverage:**
- Editor
- Dashboard כללי
- Knowledge viewer

**MVP UI של שבוע (לא חודשיים):**

מסך אחד בלבד:
- Section 1: Timeline — רשימת decisions, newest→oldest, expandable
- Section 2: Signals (הכי חשוב) — ⚠️ "you are repeating X" / ⏳ expired hypotheses / 🔁 similar decisions
- Section 3: Stats — decisions / active hypotheses / rules

טכנולוגית: read `.pm-brain/`, parse markdown, display. בלי backend מורכב.

**עקרון:**
👉 read-only first. מציג מה שקורה, לא מחליף את הכתיבה ב-Claude.

---

## 5. ההחלטה שעוד לא התקבלה

**השאלה:** האם לבנות UI בכלל, ומתי?

**הטיעון בעד:**
- Timeline + Signals הם ה-killer moment — רואים "אתה חוזר על עצמך" בצורה ויזואלית
- Read-only MVP אפשרי בשבוע עם Lovable/Next.js
- זה מה שיבדיל אותנו מ-AI-SHIPR ומה-Pawel approach

**הטיעון נגד:**
- פוזישנינג "Claude Code native" הוא היתרון — UI שובר את זה
- ICP הנוכחי (technical PMs) לא צריך UI — markdown מספיק להם
- UI = context switch, בדיוק מה שניסינו לפתור

**הקריטריון להחלטה:**
אם תצליחי לגרום למשתמש לחוות פעם אחת "Claude הציל אותי מטעות" — יש מוצר. אם לא — גם UI יפה לא יעזור.

→ **לכן:** הקדם להגיע ל-killer moment ב-CLI קודם. UI כשיש validation.

---

## 6. השלב הבא המוסכם

1. לחדד ICP — בלי זה הכל יתפזר
2. לזקק killer moment — מה בדיוק קורה step-by-step כדי שמשתמש יחווה "Claude הציל אותי מטעות"
3. UI רק אם הוא משרת את זה — לא "nice to have"
