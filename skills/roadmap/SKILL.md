---
name: roadmap
description: Create execution roadmap from PRD - breaks into phases, creates tasks (PM-only) or features (full-stack)
allowed-tools: Read, Write, Edit, Glob, AskUserQuestion
---

# /roadmap - Execution Planning

Creates execution roadmap from PRD and bridges to Task Manager.

---

## Usage

```
/roadmap [product-name]
```

**Example:**
```
/roadmap spirit
```

---

## What This Skill Does

**THE BRIDGE:** Product OS (strategy) → Task Manager (execution)

**For PM-only products:**
- Breaks PRD into phases (MVP, V1, V2)
- Identifies dependencies
- Estimates timelines
- **Creates tasks in `_System/tasks/`** ← Integration!
- Next: Use `/today` to work on tasks

**For Full-stack products:**
- Same breakdown into phases
- **Creates `FEAT-XXX.md` files** in project
- Next: Use `/dev` to implement features

---

## Process

### Step 0: Validation

1. **Check project folder exists:** `Work/[product]/`
2. **Read .product-os.yaml** - check type (pm-only vs full-stack)
3. **Check stage** - must be `verified` or `prd-created`
4. **Check PRD.md exists:** `Work/[product]/PRD.md`
5. **Optionally read gaps.md** - consider outstanding issues

**Validation errors:**
- Project not found → show checked path
- No PRD → run /create first
- Wrong stage → show current stage

---

### Step 1: Interactive Planning

**Ask user for scope clarification:**

```json
{
  "questions": [
    {
      "question": "איזה phase את רוצה לתכנן עכשיו?",
      "header": "Scope",
      "multiSelect": false,
      "options": [
        {
          "label": "MVP בלבד (Recommended)",
          "description": "תכנון מפורט רק של MVP, phases הבאים ברמה גבוהה"
        },
        {
          "label": "MVP + V1",
          "description": "תכנון מפורט של שני phases הראשונים"
        },
        {
          "label": "הכל (MVP + V1 + V2)",
          "description": "תכנון מפורט של כל הphases"
        }
      ]
    },
    {
      "question": "מה timeline משוער ל-MVP?",
      "header": "Timeline",
      "multiSelect": false,
      "options": [
        {"label": "2-4 שבועות", "description": "MVP קטן מאוד"},
        {"label": "1-2 חודשים (Recommended)", "description": "MVP סביר"},
        {"label": "3-4 חודשים", "description": "MVP גדול"},
        {"label": "לא בטוחה", "description": "תעזור לי להעריך"}
      ]
    }
  ]
}
```

---

### Step 2: Extract Features from PRD

1. **Read PRD.md** from `Work/[product]/PRD.md`
2. **Parse "Functional Requirements" section**
3. **Identify:**
   - Core features (must-have for MVP)
   - Nice-to-have features (V1, V2)
   - Dependencies between features
   - Technical constraints

4. **Categorize:**
   ```
   MVP (Minimum Viable Product):
   - Feature 1
   - Feature 2

   V1 (First enhancement):
   - Feature 3
   - Feature 4

   V2 (Future):
   - Feature 5
   ```

---

### Step 3: Interactive Feature Prioritization

**For each ambiguous feature, ask:**

```json
{
  "question": "Feature X - MVP או V1?",
  "header": "Priority",
  "options": [
    {"label": "MVP", "description": "הכרחי למוצר"},
    {"label": "V1", "description": "חשוב אבל לא הכרחי"},
    {"label": "V2", "description": "nice-to-have"}
  ]
}
```

**User can override AI suggestions**

---

### Step 4: Break Down MVP into Tasks/Features

**PM-only approach:**

Each feature → multiple tasks:
```
Feature: "User authentication"
→ Tasks:
  1. Research OAuth providers (2h)
  2. Design auth flow (4h)
  3. Implement login UI (8h)
  4. Backend integration (16h)
  5. Testing (8h)
```

**Full-stack approach:**

Each feature → one FEAT file:
```
Feature: "User authentication"
→ FEAT-001.md (complete spec for /dev)
```

---

### Step 5: Create roadmap.md

**Structure:**
```markdown
# [Product Name] - Product Roadmap

**Created:** [Date]
**Owner:** [Name]
**Type:** [PM-only / Full-stack]

---

## Phases Overview

### MVP - [Timeline]
**Goal:** [What makes this minimal and viable?]

**Core Features:**
- [ ] Feature 1
- [ ] Feature 2

**Success Criteria:**
- Metric 1
- Metric 2

**Dependencies:**
- External service X
- Resource Y

---

### V1 - [Timeline]
**Goal:** [What does V1 add?]

**Features:**
- [ ] Feature 3
- [ ] Feature 4

---

### V2 - [Timeline]
**Goal:** [Future vision]

**Features:**
- [ ] Feature 5

---

## MVP Detailed Breakdown

[PM-only: Link to tasks]
[Full-stack: Link to FEAT files]

### Feature 1: [Name]
**Why:** [Problem it solves]
**What:** [What it does]
**Tasks:** [Link to task files]

---

## Dependencies

### External
- Service X (need API key)
- Provider Y (integration required)

### Internal
- Design system
- Backend API

### Blockers
- [ ] Blocker 1
- [ ] Blocker 2

---

## Timeline Estimate

**MVP:** [X weeks/months]
- Week 1-2: [Milestone]
- Week 3-4: [Milestone]

**V1:** [X weeks/months]
**V2:** [X weeks/months]

**Total:** [X months]

⚠️ **Note:** These are estimates, not commitments

---

## Next Steps

[PM-only:]
Tasks created in `_System/tasks/[product]-*.md`
→ Run `/today` to see today's plan

[Full-stack:]
Features created in `Work/[product]/features/FEAT-*.md`
→ Run `/dev [product] FEAT-001` to start coding
```

**Save to:** `Work/[product]/roadmap.md`

---

### Step 6: Create Tasks (PM-only) or Features (Full-stack)

#### A. PM-only Track

**For each task, create:** `_System/tasks/[product]-XXX.md`

**Task file format (Teresa Torres style):**
```markdown
---
project: [product]
type: task
priority: high
status: pending
due: [date]
tags: [product, feature-name]
---

# [Task Title]

## Context
[Why this task exists]

## What to do
[Specific action items]

## Definition of Done
- [ ] Criterion 1
- [ ] Criterion 2

## Resources
- Link to PRD section
- Link to research

## Estimates
~[X] hours

## Dependencies
- Blocked by: [task-id]
- Blocks: [task-id]
```

**Task naming:**
- `spirit-001.md` - Research OAuth providers
- `spirit-002.md` - Design auth flow
- `spirit-003.md` - Implement login UI

**Integration with Task Manager:**
- Tasks appear in `_System/tasks/`
- `/today` will pick them up
- Use Teresa Torres + Carl Pullein 2+8 method

#### B. Full-stack Track

**For each feature, create:** `Work/[product]/features/FEAT-XXX.md`

**Feature file format:**
```markdown
# FEAT-001: [Feature Name]

**Status:** pending
**Priority:** high
**Phase:** MVP

---

## Overview
[What this feature does]

## Acceptance Criteria
- [ ] AC 1
- [ ] AC 2

## Technical Spec
[Implementation details]

## UI/UX Notes
[Design considerations]

## Testing
[What to test]

## Dependencies
- Depends on: FEAT-XXX
- Blocks: FEAT-XXX

---

**For /dev skill to implement**
```

---

### Step 7: Update .product-os.yaml

**Update project metadata:**
```yaml
stage: planned
status: ready-for-execution
last_updated: "[today]"

roadmap:
  created: "[today]"
  phases:
    - name: MVP
      timeline: "[X weeks]"
      features: [N]
    - name: V1
      timeline: "[X weeks]"
      features: [M]

  # PM-only:
  tasks_created: [N]
  tasks_location: "_System/tasks/"

  # Full-stack:
  features_created: [N]
  features_location: "features/"  # relative to project

files:
  - PRD.md
  - gaps.md
  - roadmap.md  # Added

# PM-only:
next_action: "Use /today to work on tasks"

# Full-stack:
next_action: "Run /dev [product] FEAT-001"
```

**Validation:**
- Read current .product-os.yaml
- Preserve existing fields
- Update only roadmap-related fields

---

### Step 8: Display Summary

**PM-only:**
```
✅ Roadmap Created!

**Phases:**
├─ MVP: [X weeks] - [N features]
├─ V1: [X weeks] - [M features]
└─ V2: [X weeks] - [L features]

**Tasks Created:** [N] tasks in _System/tasks/

**MVP Tasks:**
1. spirit-001.md - Research OAuth (2h)
2. spirit-002.md - Design auth flow (4h)
3. spirit-003.md - Implement login (8h)
[... list first 5-10]

**Full roadmap:** Work/spirit/roadmap.md

**Next Steps:**
→ Run /today to see today's plan
→ Tasks will appear in your 2+8 method

**Integration:** Product OS → Task Manager ✅
```

**Full-stack:**
```
✅ Roadmap Created!

**Phases:**
├─ MVP: [X weeks] - [N features]
├─ V1: [X weeks] - [M features]
└─ V2: [X weeks] - [L features]

**Features Created:** [N] in projects/spirit/features/

**MVP Features:**
1. FEAT-001 - User authentication
2. FEAT-002 - Event creation
3. FEAT-003 - Payment integration
[... list all]

**Full roadmap:** Work/spirit/roadmap.md

**Next Steps:**
→ Run /dev spirit FEAT-001 to start coding
→ Features will be implemented one by one
```

---

## Validation Rules

### Before Creating Roadmap

- [ ] Work/[project]/ folder exists
- [ ] .product-os.yaml exists in project
- [ ] PRD.md exists
- [ ] Stage allows roadmap (verified or prd-created)
- [ ] Type defined (pm-only or full-stack)

### During Breakdown

- [ ] All core features identified
- [ ] Dependencies mapped
- [ ] Realistic estimates
- [ ] Phases make sense (MVP is truly minimal)
- [ ] User confirmed prioritization

### Before Writing Files

- [ ] Task/feature files valid
- [ ] No duplicate IDs
- [ ] Naming consistent
- [ ] All fields filled
- [ ] Links work

### Before Updating Metadata

- [ ] Read current .product-os.yaml
- [ ] Validate consistency
- [ ] Count tasks/features correctly
- [ ] Update .product-os.yaml
- [ ] Validate YAML syntax

---

## Error Handling

### Project Not Found
```
❌ Error: Project 'spirit' not found

**Available:** nx2u, linkedin-pm

**Fix:** Check spelling or run /discover spirit
```

### No PRD
```
❌ Error: Cannot create roadmap - no PRD

**Current stage:** discovery-complete

**Fix:** Run /create spirit first
```

### Type Not Defined
```
❌ Error: Project type not set

**Need:** pm-only or full-stack

**Fix:** Update .product-os.yaml with type field
```

### Gaps Score Too Low
```
⚠️  Warning: Verification score is 4/10

**Recommendation:** Fix critical gaps before roadmap

**Continue anyway?** (yes/no)
```

---

## Important Notes

### MVP Philosophy

**MVP is NOT:**
- ❌ "All features but badly built"
- ❌ "Phase 1 of 10"
- ❌ "Everything I want"

**MVP IS:**
- ✅ Smallest thing that delivers value
- ✅ Testable with real users
- ✅ Can be built in weeks, not months

**Guide user to true MVP**

### Task Manager Integration (PM-only)

**Tasks created here:**
- Appear in `_System/tasks/`
- Follow Teresa Torres format
- Work with `/today` skill
- Use 2+8 prioritization method

**Seamless flow:**
```
/roadmap spirit
  ↓ creates tasks
/today
  ↓ picks 2 Critical + 8 Nice-to-Have
Work on tasks!
```

### Estimation Guidelines

**Be realistic:**
- Most teams underestimate by 2-3x
- Add buffer for unknowns
- Account for non-coding time (meetings, reviews)

**Rough estimates:**
- Simple feature: 2-5 days
- Medium feature: 1-2 weeks
- Complex feature: 3-4 weeks

**Warn if estimate seems off**

### Dependencies

**Track carefully:**
- External (APIs, services)
- Internal (design, backend)
- Between features (A blocks B)

**Show in roadmap + task/feature files**

---

## Success Criteria

✅ Roadmap.md created with phases
✅ MVP truly minimal
✅ Tasks (PM-only) or features (full-stack) created
✅ Dependencies identified
✅ Timeline estimated
✅ .product-os.yaml updated
✅ Integration with Task Manager works (PM-only)
✅ Next steps clear

---

**Created:** 13 February 2026
**Updated:** 15 February 2026 - v1.0.0 Architecture
**Status:** ✅ Updated for v1.0.0

**CRITICAL:** This skill bridges Product OS → Task Manager!
