---
name: verify
description: Validate PRD completeness and identify gaps - scores PRD and suggests improvements
allowed-tools: Read, Write, Edit
---

# /verify - PRD Validation

Validates PRD completeness, identifies gaps, and scores quality.

---

## Usage

```
/verify [product-name]
```

**Example:**
```
/verify spirit
```

---

## What This Skill Does

Analyzes your PRD for:
- ✅ Completeness (all sections present?)
- ✅ Quality (are sections filled in or just placeholders?)
- ✅ Specificity (vague vs specific requirements)
- ✅ Missing NFRs (often overlooked!)
- ✅ Edge cases coverage

**Outputs:**
- Score (1-10)
- gaps.md with findings
- Recommendations for improvement

---

## Process

### Step 0: Validation

1. **Check if project folder exists:**
   ```bash
   # Check Work/[product]/ exists
   ```

2. **If not found:**
   ```
   ❌ Error: Project '[name]' not found

   **Checked:** Work/[name]/

   **Fix:** Check spelling or run /create [name] first
   ```

3. **Read .product-os.yaml:**
   ```
   Work/[product]/.product-os.yaml
   ```

4. **Check stage** - must be `prd-created` or `verified` (can re-verify)
5. **If wrong stage:**
   ```
   ❌ Error: Cannot verify - no PRD yet

   **Current stage:** [stage]
   **Required:** prd-created

   **Fix:** Run /create [product] first to create PRD
   ```

6. **Check PRD.md exists:**
   ```
   Work/[product]/PRD.md
   ```

7. **If missing:**
   ```
   ❌ Error: PRD.md not found

   **Expected:** Work/[product]/PRD.md

   **Fix:** Run /create [product] to create PRD
   ```

---

### Step 1: Read PRD

1. Read `Work/[product]/PRD.md`
2. Parse sections
3. Identify what exists vs missing

---

### Step 2: Analyze Completeness

**Check for required sections:**

| Section | Check | Weight |
|---------|-------|--------|
| Overview | Problem statement, solution, target users | Critical |
| Goals & Success Metrics | Measurable metrics defined | Critical |
| User Personas | 2-3 personas with details | Critical |
| User Flows | Happy path + edge cases | High |
| Functional Requirements | Core features listed | High |
| NFRs | Performance, security, accessibility, etc. | Critical |
| Technical Constraints | Limitations identified | Medium |
| Dependencies | External dependencies listed | Medium |
| Risks | Risks + mitigations | Medium |
| Open Questions | What's still unclear | Low |

**Scoring logic:**
```
Start with 10 points

Missing critical sections: -2 each
Missing high priority: -1 each
Missing medium priority: -0.5 each
Vague/placeholder content: -0.5 per section
```

---

### Step 3: Check NFRs (Common Gap!)

**NFRs often forgotten:**
- Performance (load times, concurrent users)
- Security (authentication, encryption, compliance)
- Accessibility (WCAG, screen readers, keyboard nav)
- Localization (languages, RTL, currencies)
- Mobile (responsive, mobile-first, native)
- Privacy (data retention, GDPR, cookies)

**Check each NFR category:**
- ✅ Present and specific
- ⚠️ Present but vague
- ❌ Missing

---

### Step 4: Check Edge Cases

**Common missing edge cases:**
- User cancels mid-flow
- Payment fails
- Network drops
- Concurrent users conflict
- Invalid data uploaded
- Third-party API failure
- Subscription expires
- User wants refund

**Score:**
- Many edge cases covered: +0.5
- Few/no edge cases: -1

---

### Step 5: Check Specificity

**Vague (bad):**
- "The app should be fast"
- "We need good security"
- "Users want this feature"

**Specific (good):**
- "Pages load in < 2 seconds"
- "OAuth 2.0 + JWT tokens, encrypt PII at rest"
- "87% of interview participants mentioned this pain point"

**For each vague requirement:**
- Flag in gaps.md
- Suggest specific alternative

---

### Step 6: Generate gaps.md

**Structure:**
```markdown
# PRD Verification Report - [Product Name]

**Verified:** [Date]
**Score:** [X]/10

---

## Summary

**Status:** [Excellent / Good / Needs Work / Incomplete]

**Strengths:**
- [What's good]

**Critical Gaps:**
- [What's missing that's critical]

**Recommendations:**
- [Top 3 things to fix]

---

## Detailed Analysis

### ✅ Complete Sections

- Overview
- Goals & Success Metrics
- ...

### ⚠️ Needs Improvement

**User Personas:**
- Issue: Only 1 persona, need 2-3
- Recommendation: Add persona for [secondary user type]

**NFRs - Performance:**
- Issue: Says "fast" but no specific metrics
- Recommendation: Define load time target (< 2s?)

### ❌ Missing Sections

**NFRs - Accessibility:**
- Missing: No WCAG compliance mentioned
- Impact: May exclude users with disabilities
- Recommendation: Define WCAG AA compliance requirement

**Edge Cases:**
- Missing: What if payment fails?
- Impact: Could frustrate users, lose revenue
- Recommendation: Add error handling + retry flow

---

## Scoring Breakdown

| Category | Score | Notes |
|----------|-------|-------|
| Completeness | 8/10 | Missing 2 sections |
| NFRs Coverage | 6/10 | Missing accessibility, vague performance |
| Edge Cases | 7/10 | Covered main flows, missing payment errors |
| Specificity | 8/10 | Mostly specific, some vague NFRs |
| **Total** | **7.5/10** | Good start, needs NFR work |

---

## Next Steps

1. **Critical:** Add accessibility NFRs
2. **Critical:** Define specific performance metrics
3. **High:** Add payment failure edge cases
4. **Medium:** Add 2nd user persona

**After fixes:**
Run `/verify [product]` again to re-score

**Ready to proceed?**
If score >= 7, you can run `/roadmap [product]`
If score < 7, fix critical gaps first
```

**Save to:** `Work/[product]/gaps.md`

---

### Step 7: Update .product-os.yaml

**Update project metadata:**
```yaml
stage: verified
status: ready-for-roadmap
last_updated: "[today]"

verification:
  completed: "[today]"
  score: [X]
  gaps_count: [N]

files:
  - PRD.md
  - gaps.md  # Added

next_action: "Run /roadmap [product] to create execution plan"
```

**Validation before writing:**
- Read current .product-os.yaml
- Preserve existing fields (created, discovery, etc.)
- Update only relevant fields
- Validate YAML syntax

---

### Step 8: Display Summary

```
✅ PRD Verification Complete!

**Score:** [X]/10 - [Status]

**Strengths:**
✅ [Strength 1]
✅ [Strength 2]

**Critical Gaps Found:** [N]
🚨 [Gap 1]
🚨 [Gap 2]

**Full report:** Work/[product]/gaps.md

**Next Steps:**

[If score >= 7:]
✅ PRD is ready!
→ Run /roadmap [product] to create execution plan

[If score < 7:]
⚠️  Fix critical gaps first:
1. [Gap 1]
2. [Gap 2]
→ Then run /verify [product] again
```

---

## Validation Rules

### Before Analyzing

- [ ] Work/[product]/ folder exists
- [ ] .product-os.yaml exists in project
- [ ] Stage is prd-created or verified
- [ ] PRD.md file exists

### During Analysis

- [ ] Parse PRD structure
- [ ] Identify all sections
- [ ] Check NFRs thoroughly
- [ ] Look for edge cases
- [ ] Flag vague requirements

### Before Writing Metadata

- [ ] Read current .product-os.yaml
- [ ] Calculate score correctly
- [ ] Count gaps accurately
- [ ] Update .product-os.yaml
- [ ] Validate YAML syntax

---

## Error Handling

### Project Not Found
```
❌ Error: Project 'spirit' not found

**Registered projects:**
- nx2u
- linkedin-pm

**Fix:** Check spelling or run /discover spirit first
```

### Wrong Stage
```
❌ Error: Cannot verify - project in discovery stage

**Current:** discovery
**Need:** prd-created (PRD must exist)

**Fix:** Run /create spirit to create PRD first
```

### PRD Missing
```
❌ Error: PRD.md not found

**Expected:** Work/spirit/PRD.md

**Possible causes:**
- /create not run yet
- PRD file moved/deleted

**Fix:** Run /create spirit to create PRD
```

### Corrupted PRD
```
⚠️  Warning: PRD structure unusual

**Issue:** Cannot parse sections clearly

**Continuing with best-effort analysis...**
[proceeds but flags in gaps.md]
```

---

## Scoring Examples

### Score 9-10: Excellent
- All sections complete
- NFRs comprehensive and specific
- Edge cases well covered
- Clear, specific requirements
- Ready to build

### Score 7-8: Good
- Most sections complete
- Some NFR gaps (minor)
- Main edge cases covered
- Mostly specific
- Can proceed with minor fixes

### Score 5-6: Needs Work
- Missing some critical sections
- NFR gaps (accessibility, performance)
- Few edge cases
- Some vague requirements
- Fix gaps before roadmap

### Score 3-4: Incomplete
- Missing multiple critical sections
- Major NFR gaps
- No edge cases
- Many vague requirements
- Significant rework needed

### Score 1-2: Skeleton Only
- Only basic sections
- No NFRs
- No edge cases
- All vague
- Start over with /create

---

## Important Notes

### Re-Verification

Can run `/verify` multiple times:
- After fixing gaps
- Before roadmap
- After PRD updates

**Each run:**
- Creates new gaps.md (overwrites old)
- Updates score in config
- Shows progress

### Verification != Approval

Verification checks **completeness**, not:
- Business viability
- Technical feasibility
- User desirability

**Still need:**
- Stakeholder review
- Technical review
- User validation

### Automated vs Manual

**Automated checks:**
- Section presence
- NFR coverage
- Common gaps

**Manual judgment needed:**
- Requirement quality
- Solution appropriateness
- Edge case sufficiency

---

## Success Criteria

✅ PRD analyzed
✅ Score calculated (1-10)
✅ gaps.md created with findings
✅ Critical gaps identified
✅ Recommendations clear
✅ .product-os.yaml updated
✅ Next steps clear

---

**Created:** 13 February 2026
**Updated:** 15 February 2026 - v1.0.0 Architecture
**Status:** ✅ Updated for v1.0.0
