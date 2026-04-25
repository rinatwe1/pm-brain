---
name: discover
description: Guide product discovery process - user research, competitor analysis, and insights synthesis
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion
---

# /discover - Product Discovery Skill

Guide the product discovery process from research questions to actionable insights.

---

## Usage

```
/discover [product-name]
```

**Example:**
```
/discover spirit
/discover "my-saas-product"
```

---

## What This Skill Does

**Discovery is the phase BEFORE the PRD.** It helps you:
1. Define research questions
2. Conduct user interviews
3. Analyze competitors
4. Synthesize insights
5. Create user personas
6. Identify pain points and opportunities

**Output:** A `research/` folder with all findings, ready for `/create` to build a PRD.

---

## Process

### Step 0: Check Project Folder

**CRITICAL: Always start here!**

1. **Check if product folder exists:**
   ```bash
   # Check Work/[product]/ exists
   ```

2. **If product folder exists:**
   - Read `.product-os.yaml` from `Work/[product]/.product-os.yaml`
   - Check if `research/` OR `02_Research/` folder exists
   - If research exists: ask "האם את רוצה להמשיך research קיים או להתחיל מחדש?"
   - Options: `continue` (add to existing), `restart` (fresh start), `view` (show what exists)

3. **If product folder doesn't exist (NEW):**
   - Will create `Work/[product]/` folder
   - Will create `.product-os.yaml`
   - Will create research structure

---

### Step 1: Define Research Goals

**Ask using AskUserQuestion:**

```json
{
  "questions": [
    {
      "question": "מה השלב של המוצר?",
      "header": "Stage",
      "multiSelect": false,
      "options": [
        {"label": "רעיון ראשוני", "description": "יש לי רעיון, אני רוצה לוודא שיש בעיה אמיתית"},
        {"label": "יש מוצר, צריך לשפר", "description": "המוצר קיים, אני רוצה להבין איך לשפר"},
        {"label": "מתחרים חדשים", "description": "רוצה להבין את השוק והמתחרים"}
      ]
    },
    {
      "question": "איזה סוגי מחקר את רוצה לעשות?",
      "header": "Methods",
      "multiSelect": true,
      "options": [
        {"label": "ריאיונות משתמשים", "description": "שיחות 1-on-1 עם משתמשי יעד"},
        {"label": "ניתוח מתחרים", "description": "בדיקה מעמיקה של competitors"},
        {"label": "מחקר שוק", "description": "industry reports, trends, data"}
      ]
    }
  ]
}
```

**Based on answers:**
- Create `research-plan.md` from template
- Populate with relevant sections

---

### Step 2: Research Plan Creation

**Read template:**
```
_System/product-os/templates/research-plan-template.md
```

**Interactive conversation to fill in:**

1. **Research questions** - מה את רוצה ללמוד?
   - מי המשתמשים?
   - מה הבעיה?
   - למה פתרונות קיימים לא עובדים?

2. **Success criteria** - איך את תדעי שהמחקר הצליח?
   - כמה ריאיונות?
   - כמה מתחרים?
   - אילו insights?

3. **Timeline** - כמה זמן יקח?
   - שבוע? שבועיים? חודש?

**Output:** `Work/[product]/research/research-plan.md`

---

### Step 3: If User Interviews Selected

**Ask:**

```json
{
  "questions": [
    {
      "question": "מי את רוצה לראיין?",
      "header": "Personas",
      "multiSelect": true,
      "options": [
        {"label": "משתמשי קצה", "description": "האנשים שישתמשו במוצר"},
        {"label": "מקבלי החלטות", "description": "מי שמחליט על רכישה"},
        {"label": "מובילי דעה", "description": "experts בתחום"},
        {"label": "אחר", "description": "פרסונה אחרת"}
      ]
    }
  ]
}
```

**For each persona:**
1. שאל: מי הם? איפה למצוא אותם?
2. שאל: כמה לראיין? (ממליץ: 5-8 לכל persona)
3. שאל: מה השאלות הספציפיות לפרסונה הזאת?

**Generate interview guide:**
- Read template: `templates/interview-guide-template.md`
- Customize questions per persona
- Output: `projects/[product]/research/interview-guide.md`

**Create interview tracking:**
- Add table to `research-plan.md`:
  ```
  | Date | Participant | Persona | Status | Notes |
  ```

**Explain next steps:**
```
✅ Interview guide מוכן!

**הצעדים הבאים:**
1. קבעי ריאיונות עם [N] [persona]
2. השתמשי ב-interview guide
3. תעדי הערות בזמן הריאיון
4. אחרי כל ריאיון, תריצי:
   /discover spirit --log-interview

זה יעזור לך לתעד את הממצאים.
```

---

### Step 4: If Competitor Analysis Selected

**Ask:**

```json
{
  "question": "אילו מתחרים לנתח?",
  "header": "Competitors",
  "multiSelect": false,
  "options": [
    {"label": "אני יודעת בדיוק", "description": "יש לי רשימה מוכנה"},
    {"label": "צריכה עזרה", "description": "תעזור לי למצוא מתחרים"},
    {"label": "כבר יש לי research", "description": "רק צריכה לארגן"}
  ]
}
```

**If "אני יודעת בדיוק":**
1. שאל: מי המתחרים? (list)
2. לכל competitor:
   - שאל: מה חשוב לנתח? (features, UX, pricing, positioning)
   - Create placeholder: `Work/[product]/research/competitors/[competitor]-analysis.md`

**If "צריכה עזרה":**
1. שאל: מה קטגוריית המוצר? (e.g., "wellness platform")
2. שאל: מי משתמש קצה? (e.g., "yoga instructors")
3. Suggest competitors based on context (if possible)
4. או: תן לה מבנה איך לחפש (Google, industry lists, ask users)

**Generate competitor analysis template:**
- For each competitor, create from template: `templates/competitor-analysis-template.md`
- Output: `Work/[product]/research/competitors/[competitor]-analysis.md`

**Explain next steps:**
```
✅ Competitor analysis templates מוכנים!

**המתחרים לנתח:**
1. [Competitor 1] - [URL]
2. [Competitor 2] - [URL]
3. [Competitor 3] - [URL]

**הצעדים הבאים:**
1. גלשי לכל אתר
2. נסי את המוצר (sign up, explore)
3. צלמי screenshots (שמרי ב-`competitors/screenshots/`)
4. מלאי את הטמפלייט

**Tip:** התמקדי במה שרלוונטי! לא צריך למלא הכל, רק מה שחשוב למוצר שלך.
```

---

### Step 5: If Market Research Selected

**Ask:**
- אילו שאלות את רוצה לענות? (market size, trends, opportunities)
- אילו מקורות יש לך? (reports, articles, data)

**Create market research section:**
- Add to `research-plan.md`
- או: create separate `market-research.md`

---

### Step 6: Create Project Structure

**Create folders:**
```
Work/[product-name]/
├── .product-os.yaml
└── research/
    ├── research-plan.md          ✅ Created
    ├── interview-guide.md        ✅ If interviews
    ├── interviews/               📁 Placeholder
    │   └── .gitkeep
    ├── competitors/              📁 If competitor analysis
    │   ├── [competitor-1]-analysis.md
    │   ├── [competitor-2]-analysis.md
    │   └── screenshots/
    │       └── .gitkeep
    └── insights.md               📝 Empty (will fill in Step 7)
```

**Create .product-os.yaml:**
```yaml
name: [Product Name]
type: [pm-only or full-stack - ask!]
owner: [User's name]
created: [today]
last_updated: [today]

stage: discovery
status: research-in-progress

discovery:
  methods:
    - user_interviews: [true/false]
    - competitor_analysis: [true/false]
    - market_research: [true/false]
  target_completion: [date]

files:
  - research/research-plan.md
  - research/interview-guide.md  # if applicable

next_action: "Complete research, then run /discover [product] --synthesize"
```

**Validation:**
- YAML syntax correct
- All required fields present
- Methods array not empty

---

### Step 7: Display Summary & Next Steps

```
🎉 Discovery research מתוכנן!

**מה יצרנו:**
✅ Research plan - `research/research-plan.md`
✅ Interview guide - `research/interview-guide.md` [if applicable]
✅ Competitor templates - `research/competitors/*.md` [if applicable]
✅ Project config - `config.yaml`

**הצעדים הבאים:**

📋 **השלב הזה (Discovery):**
1. בצעי ריאיונות ותעדי הערות ב-`research/interviews/`
2. נתחי מתחרים ומלאי את הטמפלייטים
3. כשמסיימת איסוף מידע, תריצי:
   /discover [product] --synthesize

🔍 **השלב הבא (Synthesis):**
אחרי שתסיימי לאסוף מידע, `/discover --synthesize` יעזור לך:
- לסכם את כל הממצאים
- ליצור user personas
- לזהות pain points
- לבנות insights.md

📝 **השלב אחרי (PRD):**
אחרי synthesis, תריצי:
/create [product]
זה יקרא את insights.md ויבנה PRD מבוסס-research!

---

**רוצה לראות את research plan?**
```

---

## Sub-Command: `/discover [product] --synthesize`

**Purpose:** Synthesize research findings into insights.

**When to use:** After completing interviews and competitor analysis.

### Process:

1. **Check research completeness:**
   - Count interview files in `interviews/`
   - Check competitor analysis files
   - Ask: "האם סיימת את כל המחקר? (כן/לא/חסרים עוד...)"

2. **Read all research:**
   - Read `research-plan.md`
   - Read all `interviews/*.md`
   - Read all `competitors/*.md`

3. **Interactive synthesis conversation:**
   - מה הדפוסים שראית בריאיונות?
   - מה הכאבים החוזרים?
   - מה הפתעה/למדת?
   - מה המתחרים עושים טוב/לא טוב?
   - מה ההזדמנויות?

4. **Ask structured questions:**

```json
{
  "questions": [
    {
      "question": "מה הכאב הכי גדול שראית אצל משתמשים?",
      "header": "Top Pain",
      "multiSelect": false,
      "options": [
        {"label": "[Pain from interviews]", "description": "נזכר ב-X ריאיונות"},
        {"label": "[Pain from interviews]", "description": "נזכר ב-Y ריאיונות"},
        {"label": "אחר", "description": "משהו אחר"}
      ]
    }
  ]
}
```

5. **Generate insights.md:**
   - Read template: `templates/insights-template.md`
   - Fill in based on research + conversation
   - Output: `Work/[product]/research/insights.md`

6. **Create user personas:**
   - Based on interview patterns
   - 2-3 personas max
   - Include in insights.md

7. **Prioritize pain points:**
   - List top 5 pain points
   - Rate by frequency + severity
   - Include in insights.md

8. **Update .product-os.yaml:**
   ```yaml
   stage: discovery-complete
   status: ready-for-prd
   last_updated: [today]

   discovery:
     completed: [today]
     synthesis_completed: [today]

   files:
     - research/research-plan.md
     - research/interview-guide.md
     - research/insights.md  # Added!

   next_action: "Run /create [product] to build PRD"
   ```

9. **Display summary:**
   ```
   ✅ Research synthesis הושלם!

   **ממצאים מרכזיים:**
   🎯 [N] User personas
   🔴 [N] Critical pain points
   💡 [N] Opportunity areas
   📊 [N] Competitors analyzed

   **הקובץ המרכזי:**
   `research/insights.md` - כל הממצאים מסוכמים פה

   **הצעד הבא:**
   /create [product]
   זה ייקרא את insights.md ויבנה PRD מבוסס-research! 🚀
   ```

---

## Sub-Command: `/discover [product] --log-interview`

**Purpose:** Quick helper to log an interview after it happens.

**Process:**

1. Ask: מי ראיינת? (name/role)
2. Ask: מה הפרסונה? (which persona)
3. Ask: מה הממצאים המרכזיים? (bullet points)

4. Create file: `Work/[product]/research/interviews/interview-[N].md`
   - Use template structure
   - Fill in based on answers
   - Add to tracking table in research-plan.md

5. Suggest: "רוצה לתעד עוד ריאיון?"

---

## Important Notes

### Conversation Style
- **Supportive, not prescriptive**
  - "מה שעובד בשבילך" not "עשי ככה"
  - Suggestions, not commands

- **Flexible**
  - Not every research needs everything
  - Skip what's not relevant

- **Practical**
  - Give templates, not theory
  - Clear next steps

### Integration with /create
- Discovery creates `research/insights.md`
- `/create` reads insights.md automatically
- PRD will be research-backed, not assumptions

### When to Skip Discovery
**Ask at the start:**
```json
{
  "question": "האם כבר עשית discovery?",
  "header": "Research",
  "options": [
    {"label": "כן, יש לי research", "description": "קפצי ישר ל-/create"},
    {"label": "לא, בואי נתחיל", "description": "הדרכה מלאה"},
    {"label": "חלקי", "description": "יש חלק, צריך להשלים"}
  ]
}
```

If they already have research:
- Option to import/organize existing files
- Or skip to `/create`

---

## Success Criteria

Discovery is successful when:
- ✅ Research plan created
- ✅ [N] interviews completed (if applicable)
- ✅ [N] competitors analyzed (if applicable)
- ✅ insights.md created with:
  - User personas (2-3)
  - Pain points (prioritized)
  - Opportunity areas
  - Validated assumptions
- ✅ Ready for `/create`

---

**Created:** 11 February 2026
**Updated:** 15 February 2026 - v1.0.0 Architecture
**Status:** ✅ Updated for v1.0.0
