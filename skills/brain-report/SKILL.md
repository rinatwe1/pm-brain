---
name: brain-report
description: Generate a static HTML report from .pm-brain/ — a ready-to-share management briefing with snapshot, decisions timeline, active hypotheses, recent insights, and key rules. Run before any stakeholder meeting.
---

# /brain-report — Generate Product Brain Report

## When to use
- Before a stakeholder or management meeting
- When you want a shareable snapshot of the product's memory
- Monthly alongside /brain-review

## Guard clause

Check that `.pm-brain/` exists in the current directory.

If it doesn't exist:
```
לא מצאתי .pm-brain/ בתיקייה הזו.
פתח/י Claude Code בתיקיית המוצר שלך והרץ /brain-init קודם.
```
Stop. Do not continue.

---

## Process

### Step 1: Read all .pm-brain/ content

Read these files (silently — do not display raw content to user):

1. `.pm-brain/SNAPSHOT.md` — current state
2. `.pm-brain/meta.json` — product name, stage, counts
3. All files in `.pm-brain/decisions/` — sort by date, newest first
4. All files in `.pm-brain/hypotheses/` — filter by status: unvalidated + validated (skip invalidated)
5. All files in `.pm-brain/meetings/`, `.pm-brain/interviews/`, `.pm-brain/research/` — filter to last 30 days only
6. All `rules.md` files in `.pm-brain/knowledge/*/` — skip empty files

### Step 2: Create reports directory

Create `.pm-brain/reports/` if it doesn't exist.

### Step 3: Generate HTML

Generate a single self-contained HTML file with inline CSS. No external dependencies.

File path: `.pm-brain/reports/YYYY-MM-DD.html` (today's date)

Use this template:

```html
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[Product Name] — Product Brain Report — [Date]</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    font-size: 15px;
    line-height: 1.6;
    color: #1a1a1a;
    background: #f8f8f8;
    padding: 32px 16px;
  }
  .container { max-width: 860px; margin: 0 auto; }

  /* Header */
  .report-header {
    background: #1a1a2e;
    color: white;
    padding: 32px 40px;
    border-radius: 12px;
    margin-bottom: 24px;
  }
  .report-header h1 { font-size: 26px; font-weight: 700; margin-bottom: 6px; }
  .report-header .meta { opacity: 0.7; font-size: 14px; }
  .report-header .stage {
    display: inline-block;
    background: rgba(255,255,255,0.15);
    padding: 3px 12px;
    border-radius: 20px;
    font-size: 13px;
    margin-top: 10px;
  }

  /* Sections */
  .section {
    background: white;
    border-radius: 10px;
    padding: 28px 32px;
    margin-bottom: 20px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
  }
  .section h2 {
    font-size: 17px;
    font-weight: 700;
    color: #1a1a2e;
    margin-bottom: 18px;
    padding-bottom: 10px;
    border-bottom: 2px solid #f0f0f0;
  }

  /* Snapshot */
  .snapshot-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
  .snapshot-item { background: #f8f8f8; border-radius: 8px; padding: 14px 18px; }
  .snapshot-item .label { font-size: 12px; color: #888; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
  .snapshot-item .value { font-size: 15px; color: #1a1a1a; }
  .snapshot-item.risk { border-right: 3px solid #e74c3c; }
  .snapshot-item.next { border-right: 3px solid #2ecc71; }

  /* Decisions */
  details { margin-bottom: 10px; }
  details summary {
    cursor: pointer;
    padding: 12px 16px;
    background: #f8f8f8;
    border-radius: 8px;
    font-weight: 600;
    font-size: 14px;
    list-style: none;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  details summary::-webkit-details-marker { display: none; }
  details summary::after { content: '＋'; color: #aaa; font-weight: 400; }
  details[open] summary::after { content: '－'; }
  details summary .date { font-weight: 400; color: #888; font-size: 13px; }
  .decision-body { padding: 14px 16px; font-size: 14px; color: #444; line-height: 1.7; }
  .decision-body strong { color: #1a1a1a; }

  /* Hypotheses */
  .hypothesis-card {
    border: 1px solid #eee;
    border-radius: 8px;
    padding: 14px 18px;
    margin-bottom: 10px;
  }
  .hypothesis-card .hyp-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 6px; }
  .hypothesis-card .hyp-title { font-weight: 600; font-size: 14px; }
  .confidence {
    font-size: 12px;
    padding: 2px 10px;
    border-radius: 12px;
    font-weight: 600;
  }
  .conf-high { background: #d4edda; color: #155724; }
  .conf-mid  { background: #fff3cd; color: #856404; }
  .conf-low  { background: #f8d7da; color: #721c24; }
  .hyp-meta { font-size: 12px; color: #888; margin-top: 4px; }

  /* Insights */
  .insight-item {
    padding: 12px 16px;
    border-right: 3px solid #3498db;
    margin-bottom: 10px;
    background: #f8fbff;
    border-radius: 0 8px 8px 0;
  }
  .insight-item .insight-source { font-size: 12px; color: #888; margin-bottom: 4px; }
  .insight-item .insight-text { font-size: 14px; }

  /* Rules */
  .rule-item {
    padding: 10px 14px;
    background: #f0faf0;
    border-radius: 6px;
    margin-bottom: 8px;
    font-size: 14px;
    border-right: 3px solid #2ecc71;
  }

  /* Stats bar */
  .stats-bar {
    display: flex;
    gap: 16px;
    margin-bottom: 24px;
  }
  .stat-pill {
    background: white;
    border-radius: 8px;
    padding: 12px 20px;
    text-align: center;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    flex: 1;
  }
  .stat-pill .num { font-size: 24px; font-weight: 700; color: #1a1a2e; }
  .stat-pill .lbl { font-size: 12px; color: #888; margin-top: 2px; }

  /* Footer */
  .footer { text-align: center; color: #aaa; font-size: 12px; margin-top: 24px; }

  @media print {
    body { background: white; padding: 0; }
    .section { box-shadow: none; border: 1px solid #eee; }
    details { page-break-inside: avoid; }
    details[open] { break-inside: avoid; }
  }
</style>
</head>
<body>
<div class="container">

  <!-- Header -->
  <div class="report-header">
    <h1>[Product Name] — Product Brain</h1>
    <div class="meta">דוח נוצר: [DD Month YYYY] | על ידי PM Brain</div>
    <div class="stage">[Stage: Discovery / Build / Growth / Scale]</div>
  </div>

  <!-- Stats Bar -->
  <div class="stats-bar">
    <div class="stat-pill">
      <div class="num">[N]</div>
      <div class="lbl">החלטות</div>
    </div>
    <div class="stat-pill">
      <div class="num">[N]</div>
      <div class="lbl">הנחות פעילות</div>
    </div>
    <div class="stat-pill">
      <div class="num">[N]</div>
      <div class="lbl">כללים מאומתים</div>
    </div>
    <div class="stat-pill">
      <div class="num">[N]</div>
      <div class="lbl">תובנות (30 יום)</div>
    </div>
  </div>

  <!-- Snapshot -->
  <div class="section">
    <h2>📍 מצב נוכחי</h2>
    <div class="snapshot-grid">
      <div class="snapshot-item">
        <div class="label">עכשיו</div>
        <div class="value">[from SNAPSHOT ## עכשיו]</div>
      </div>
      <div class="snapshot-item next">
        <div class="label">הצעד הבא</div>
        <div class="value">[from SNAPSHOT ## הצעד הבא]</div>
      </div>
      <div class="snapshot-item risk">
        <div class="label">הסיכון הכי גדול</div>
        <div class="value">[from SNAPSHOT ## הסיכון הכי גדול]</div>
      </div>
      <div class="snapshot-item">
        <div class="label">ההנחה הכי גדולה</div>
        <div class="value">[from SNAPSHOT ## ההנחה הכי גדולה]</div>
      </div>
    </div>
  </div>

  <!-- Decisions Timeline -->
  <div class="section">
    <h2>🗂 החלטות — Timeline</h2>
    <!-- Repeat for each decision, newest first -->
    <details>
      <summary>
        [Decision title]
        <span class="date">[YYYY-MM-DD] · [domain]</span>
      </summary>
      <div class="decision-body">
        <strong>ההחלטה:</strong> [Decision one-liner]<br>
        <strong>למה:</strong> [Reasoning]<br>
        <strong>ויתרנו על:</strong> [Trade-offs]<br>
        <strong>סיגנל הצלחה:</strong> [Success signal]
      </div>
    </details>
    <!-- /repeat -->
  </div>

  <!-- Active Hypotheses -->
  <div class="section">
    <h2>🔬 הנחות פעילות</h2>
    <!-- Repeat for each unvalidated/validated hypothesis -->
    <div class="hypothesis-card">
      <div class="hyp-header">
        <span class="hyp-title">[HYP-NNN: title]</span>
        <span class="confidence conf-mid">[confidence]/10</span>
      </div>
      <div class="hyp-meta">פג תוקף: [date] · קטגוריה: [category] · שיטת בדיקה: [test method]</div>
    </div>
    <!-- /repeat -->
  </div>

  <!-- Recent Insights -->
  <div class="section">
    <h2>💡 תובנות אחרונות (30 יום)</h2>
    <!-- Repeat for each meeting/interview/research from last 30 days -->
    <div class="insight-item">
      <div class="insight-source">[meeting/interview/research] · [date] · [title]</div>
      <div class="insight-text">[Summary — 1-2 sentences from the artifact's Summary section]</div>
    </div>
    <!-- /repeat -->
    <!-- If no insights in last 30 days: -->
    <!-- <p style="color:#aaa;font-size:14px">אין תובנות מ-30 הימים האחרונים. הרץ /synthesize אחרי פגישה או interview.</p> -->
  </div>

  <!-- Key Rules -->
  <div class="section">
    <h2>✅ כללים מאומתים</h2>
    <!-- Repeat for each rule in knowledge/*/rules.md — skip empty domains -->
    <div class="rule-item">[Rule text] <span style="color:#aaa;font-size:12px">— [source/domain]</span></div>
    <!-- /repeat -->
    <!-- If no rules yet: -->
    <!-- <p style="color:#aaa;font-size:14px">אין כללים עדיין. כשhypothesis מאומתת 3 פעמים — היא הופכת לכלל.</p> -->
  </div>

  <div class="footer">
    Generated by <strong>PM Brain</strong> · <a href="https://github.com/rinatwe1/pm-brain" style="color:#aaa">github.com/rinatwe1/pm-brain</a>
  </div>

</div>
</body>
</html>
```

### Step 4: Fill in the template

Replace all `[placeholders]` with actual data from the files read in Step 1:

- **Confidence badge class:** conf-high = 7-10, conf-mid = 4-6, conf-low = 1-3
- **Decisions:** include all decisions. If more than 10 — include all, they are collapsible.
- **Hypotheses:** only status `unvalidated` or `validated`. Skip `invalidated`.
- **Insights:** only files dated within last 30 days. Extract only the `## Summary` section (1-2 sentences).
- **Rules:** skip domains where rules.md is empty or has only the header line.
- **Stats bar counts:** decisions = count of files in decisions/, hypotheses = count of unvalidated, rules = count across all rules.md, insights = count of files in last 30 days.

### Step 5: Output

JSON:
```json
{
  "status": "generated",
  "file": ".pm-brain/reports/YYYY-MM-DD.html",
  "counts": {
    "decisions": N,
    "hypotheses_active": N,
    "rules": N,
    "insights_30d": N
  }
}
```

Human message:
```
דוח נוצר ✓

📄 .pm-brain/reports/YYYY-MM-DD.html

פתח/י בדפדפן לשיתוף או הדפסה.

סיכום:
├── [N] החלטות
├── [N] הנחות פעילות
├── [N] תובנות (30 יום)
└── [N] כללים מאומתים
```

## Notes
- Always append, never overwrite existing reports (each run creates a new dated file)
- If a section has no data — show a placeholder message, don't hide the section
- The HTML is self-contained — no internet connection needed to open it
- Print-friendly by default (CSS @media print included)
