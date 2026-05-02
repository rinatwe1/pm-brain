---
type: usability-audit
product: PM Brain
date: 2026-05-02
auditor: Claude (simulated new user walkthrough)
---

# Usability Issues — PM Brain

*Simulated walkthrough: user who didn't build the system. Steps: install → brain-init → brain-import → decision-log → hypothesis.*

---

## CRITICAL — בלוקים להשלמת ה-flow

### C1: brain-init שואל "איפה תיקיית המוצר?" כשהמשתמש כבר שם
**קובץ:** `skills/brain-init/SKILL.md` — Step 1  
**הבעיה:** הוראות ה-QUICKSTART אומרות "Open Claude Code in your product directory" ואז הרץ `/brain-init`. כשהמשתמש עושה בדיוק את זה — הskill שואלת "איפה נמצאת תיקיית המוצר?". מבלבל ומנוגד להוראות.  
**תיקון:** אם אין `.pm-brain/` ב-current directory — השתמש ב-`pwd` כברירת מחדל. שאל רק אם המשתמש אומר שהוא בתיקייה הלא נכונה.

---

### C2: knowledge-base לא נטענת בפועל
**קובץ:** `skills/brain-init/SKILL.md` — Step 3-5  
**הבעיה:** brain-init יוצר 7 תיקיות domain ריקות. ה-value prop המרכזי — "19 קבצים מ-13 ספרי PM מיום ראשון" — לא מועבר בפועל. `knowledge-base/` קיים בפרויקט אבל הskill אף פעם לא מעתיקה ממנו.  
**תיקון:** brain-init צריך לאחזר את תוכן `knowledge-base/` ולהזריק אותו לdomains הרלוונטיים בזמן הinit.

---

### C3: hook לא עובד — single quotes מונעות variable expansion
**קובץ:** `.claude/settings.local.json` — PostToolUse command  
**הבעיה:** `echo '$CLAUDE_TOOL_INPUT'` — single quotes ב-bash מונעות הרחבת משתנה. `FILE` תמיד ריק. `validate-pm-brain.sh` רץ עם ארגומנט ריק ויוצא עם exit 0. Hook לא מאמת שום דבר לעולם.  
**תיקון:** שנה ל-`echo "$CLAUDE_TOOL_INPUT"`.

---

### C4: decision-log ו-hypothesis — אין guard לאי-קיום .pm-brain/
**קבצים:** `skills/decision-log/SKILL.md`, `skills/hypothesis/SKILL.md`  
**הבעיה:** שתי ה-skills מניחות ש-`.pm-brain/` קיים וצוללות ישירות לעבודה. אם המשתמש מריץ אותן ללא brain-init — שגיאה לא ברורה (grep על תיקייה לא קיימת, או `meta.json` לא נמצא).  
**תיקון:** שורה ראשונה בכל skill — "בדוק שיש `.pm-brain/`. אם לא: 'לא מצאתי .pm-brain/ — פתחת Claude Code בתיקיית המוצר שלך? הרץ /brain-init קודם.'"

---

## HIGH — גורמים לבלבול או ציפיות שגויות

### H1: QUICKSTART — [repo-url] placeholder
**קובץ:** `QUICKSTART.md` — שורה 7  
**הבעיה:** `git clone [repo-url]` — לא ניתן לביצוע. URL לא אמיתי.  
**תיקון:** החלף ב-`https://github.com/rinatwe1/pm-brain.git`

---

### H2: QUICKSTART — "Claude reads .pm-brain/ automatically" — לא מדויק
**קובץ:** `QUICKSTART.md` — Step 4  
**הבעיה:** Claude קורא `.pm-brain/` רק אם `CLAUDE.md` עודכן עם ה-memory block (ש-brain-init עושה). QUICKSTART לא מסביר את הקישור הזה.  
**תיקון:** שנה ל-"brain-init מוסיף block ל-CLAUDE.md שלך — זה מה שגורם לClaude לקרוא את .pm-brain/ בתחילת כל session."

---

### H3: QUICKSTART — תיאור מצבים הפוך
**קובץ:** `QUICKSTART.md` — Step 2  
**הבעיה:** "Choose Quick mode (existing product with docs) or Deep mode (new product, full discovery)" — הפוך. Quick = מוצר חדש 4 שאלות, PATH A = מוצר קיים עם docs.  
**תיקון:** "brain-init יזהה אם יש לך docs קיימים. אם כן — יקרא אותם ויגזור מהם. אם לא — ישאל 4 שאלות (Quick) או 10 שאלות (Deep)."

---

### H4: hook validation — בודק `date:` אבל knowledge files משתמשים ב-`updated:`
**קובץ:** `hooks/validate-pm-brain.sh` — שורה 33-35  
**הבעיה:** הvalidation דורש שדה `date:`, אבל כל קבצי `knowledge/*/knowledge.md` משתמשים ב-`updated:` לא `date:`. כל קריאת knowledge file תגרום ל-false positive: "missing required field: date".  
**תיקון:** בדוק `date:` OR `updated:`.

---

### H5: brain-init — שני "Step 5" עם תוכן שונה
**קובץ:** `skills/brain-init/SKILL.md` — שורות 231 ו-251  
**הבעיה:** קובץ מכיל "## Step 5: Write meta.json" ואז מיד אחריו שוב "## Step 5: Pre-populate knowledge". Claude ימלא את meta.json ואז לא יהיה ברור איזה Step 5 לבצע.  
**תיקון:** שנה את השני ל-"## Step 5b: Pre-populate knowledge from answers"

---

### H6: README — מפרט agents שלא קיימים
**קובץ:** `README.md` — Agents table  
**הבעיה:** `knowledge-updater` ו-`decision-reviewer` מפורטים כ-agents קיימים. הם לא בנויים.  
**תיקון:** הוסף הערה "coming in v0.3" לשניהם, או הסר.

---

## MEDIUM — rough edges

### M1: brain-init — מניח נתיב ~/Work/ בהצעת תיקייה חדשה
**קובץ:** `skills/brain-init/SKILL.md` — Step 1  
**הבעיה:** כשמשתמש נותן שם מוצר בלי נתיב, הskill מציעה `/Users/[username]/Work/[name]/`. לא כולם שומרים עבודה תחת `Work/`.  
**תיקון:** הצע את ה-home directory ושאל: "תיקיית בית: ~/[name]/ — מתאים? (או ציין נתיב אחר)"

---

### M2: brain-import — לא מסנן תיקיות קוד
**קובץ:** `skills/brain-import/SKILL.md` — Step 2  
**הבעיה:** מסנן `.pm-brain/`, `node_modules/`, `.git/`, `archive/` — אבל לא `src/`, `app/`, `components/`, `lib/`, `tests/`. לפרויקט full-stack, יסרוק אלפי קבצים.  
**תיקון:** הוסף לרשימת ה-skip: `src/`, `app/`, `lib/`, `components/`, `tests/`, `dist/`, `build/`

---

### M3: brain-import — אין טיפול במקרה של 0 קבצים
**קובץ:** `skills/brain-import/SKILL.md` — Step 2  
**הבעיה:** Flow מניח שתמיד ימצא קבצים. מה קורה אם 0 קבצי markdown?  
**תיקון:** הוסף: "לא מצאתי קבצי markdown לייבוא. אם יש לך docs בפורמט אחר (Notion, Confluence) — הם לא נתמכים עדיין."

---

### M4: brain-review — אין guard לאי-קיום .pm-brain/
**קובץ:** `skills/brain-review/SKILL.md` — Step 1  
**הבעיה:** Step 1 קורא meta.json. אם .pm-brain/ לא קיים — שגיאה לא ברורה.  
**תיקון:** אותו guard כמו C4.

---

## סיכום לפי קובץ

| קובץ | בעיות | חומרה |
|------|-------|-------|
| `skills/brain-init/SKILL.md` | C1, C2, H5, M1 | Critical + High |
| `.claude/settings.local.json` | C3 | Critical |
| `skills/decision-log/SKILL.md` | C4 | Critical |
| `skills/hypothesis/SKILL.md` | C4 | Critical |
| `QUICKSTART.md` | H1, H2, H3 | High |
| `hooks/validate-pm-brain.sh` | H4 | High |
| `README.md` | H6 | High |
| `skills/brain-import/SKILL.md` | M2, M3 | Medium |
| `skills/brain-review/SKILL.md` | M4 | Medium |

---

## מה כבר תקין (T04)

`market/` domain — brain-init כבר יוצר אותו כחלק מה-7 domains. T04 נסגר.
