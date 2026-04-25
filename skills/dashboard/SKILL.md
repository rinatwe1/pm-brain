---
name: dashboard
description: Show all products at a glance - stage, status, next actions, and blockers
allowed-tools: Read
---

# /dashboard - Product Overview

Shows all active products at a glance with their current status.

---

## Usage

```
/dashboard
```

**No parameters needed** - shows all products registered in workspace.

---

## What This Skill Does

**Read-only skill** - displays information, doesn't modify anything.

Shows:
- All products registered in workspace
- Current stage (discovery, prd-created, verified, etc.)
- Current status (research-in-progress, ready-for-prd, etc.)
- Type (pm-only or full-stack)
- Next action (what to do next)
- Blockers (if any)
- Last updated date
- Has research/insights/PRD flags

**Use cases:**
- Weekly review - what's the state of all products?
- Quick status check - where is each product?
- Identify blockers - what's stuck?
- Prioritize - what needs attention?

---

## Process

### Step 1: Discover All Projects

1. **Scan Work directory for projects:**
   ```bash
   # Find all .product-os.yaml files in Work/*/
   # This discovers ALL projects automatically
   ```

2. **For each .product-os.yaml found:**
   - Read the file
   - Extract: name, type, stage, status, owner, next_action
   - Add to projects list

3. **If no projects found:**
   ```
   📊 Product OS Dashboard
   ═══════════════════════

   **Total Products:** 0

   No products found.

   **Get started:**
   /discover [product-name] - Start a new product with discovery
   /create [product-name] - Create PRD directly
   ```

4. **Calculate stats:**
   - Count projects per stage
   - Count projects with blockers
   - Find stale projects (>30 days since last_updated)

---

### Step 2: Display Overview

**Header:**
```
📊 Product OS Dashboard
═══════════════════════

**Last Updated:** [workspace.meta.last_sync]
**Total Products:** [N]
```

**For each project:**
```
──────────────────────────────────────

🎯 [Product Name] ([type])

**Stage:** [stage] → **Status:** [status]
**Created:** [date] | **Updated:** [date]
**Owner:** [owner]

**Progress:**
├─ Research: [✅/❌]
├─ Insights: [✅/❌]
└─ PRD: [✅/❌]

**Next Action:**
→ [next_action]

[If blockers exist:]
🚨 **Blockers:**
   - [blocker 1]
   - [blocker 2]
```

---

### Step 3: Display Summary Stats

**Footer:**
```
──────────────────────────────────────

📈 Summary

**By Stage:**
├─ 🔍 Discovery: [N]
├─ ✅ Discovery Complete: [N]
├─ 📝 PRD Created: [N]
├─ ✔️  Verified: [N]
├─ 🗺️  Planned: [N]
├─ 💻 In Progress: [N]
└─ 🚀 Shipped: [N]

**By Type:**
├─ PM-only: [N]
└─ Full-stack: [N]

**Needs Attention:**
├─ 🚨 With blockers: [N]
└─ ⏰ Stale (>30 days): [N]

**Ready for Action:**
├─ Ready for PRD: [N]
├─ Ready for verification: [N]
├─ Ready for roadmap: [N]
└─ Ready for dev: [N]

═══════════════════════════════════════
```

---

## Display Format Details

### Stage Indicators

| Stage | Emoji | Display |
|-------|-------|---------|
| discovery | 🔍 | Discovery |
| discovery-complete | ✅ | Discovery Complete |
| prd-created | 📝 | PRD Created |
| verified | ✔️ | Verified |
| planned | 🗺️ | Planned |
| in-progress | 💻 | In Progress |
| shipped | 🚀 | Shipped |

### Type Indicators

| Type | Emoji | Display |
|------|-------|---------|
| pm-only | 📋 | PM-only |
| full-stack | 💻 | Full-stack |

### Progress Flags

- ✅ Green check = has this
- ❌ Red X = doesn't have this

### Blockers

If `blockers` array not empty:
```
🚨 **Blockers:**
   - [blocker text]
```

If empty: don't show blockers section.

### Stale Detection

If `last_updated` > 30 days ago:
```
⏰ **Warning:** Last updated [N] days ago
```

---

## Optional: Save Snapshot

**Ask user:**
```
רוצה לשמור snapshot של הdashboard?
```

**If yes:**
- Save to `Work/_System/product-os/snapshots/dashboard-[date].md`
- Include timestamp
- Useful for comparing over time
- Create snapshots/ folder if doesn't exist

---

## Error Handling

### No Work Directory

```
❌ Error: Work/ directory not found

**Expected location:**
/Users/rinatweiss/Downloads/Work/

**Fix:** Ensure you're in the correct directory
```

### No Projects Found

```
📊 Product OS Dashboard
═══════════════════════

**Total Products:** 0

No products registered yet.

**Get started:**
/discover [product-name] - Start a new product with discovery
```

### Corrupted Project Metadata

```
⚠️  Warning: [Project] .product-os.yaml is corrupted

**Issue:** Cannot parse YAML file

**Check:**
1. Open Work/[Project]/.product-os.yaml
2. Look for syntax errors
3. Check indentation (YAML is sensitive to spaces)

**Recovery:**
- Fix YAML syntax
- Or restore from git history
- Skill will skip this project and continue with others
```

---

## Filtering (Future Enhancement)

**Not implemented yet, but planned:**

```
/dashboard --stage=discovery
/dashboard --type=pm-only
/dashboard --blocked
/dashboard --stale
```

For now: shows all projects.

---

## Important Notes

### Read-Only Skill

- **Does NOT modify** workspace.yaml
- **Does NOT modify** config.yaml
- **Only reads** and displays
- Safe to run anytime

### Performance

- Scans Work/*/ for .product-os.yaml files
- Fast for reasonable number of projects (< 50)
- Each project = one YAML file read
- Optional: can read additional files (PRD.md, gaps.md) for more details

### When to Run

- **Weekly review** - see all products
- **Daily standup** - quick status
- **After changes** - verify updates worked
- **Debugging** - check system state

---

## Example Output

```
📊 Product OS Dashboard
═══════════════════════

**Last Updated:** 2026-02-13T14:30:00Z
**Total Products:** 3

──────────────────────────────────────

🎯 Spirit (📋 PM-only)

**Stage:** discovery-complete → **Status:** ready-for-prd
**Created:** 2026-02-03 | **Updated:** 2026-02-11
**Owner:** רינת

**Progress:**
├─ Research: ✅
├─ Insights: ✅
└─ PRD: ❌

**Next Action:**
→ Run /create spirit to build PRD from insights

──────────────────────────────────────

🎯 NX2U (💻 Full-stack)

**Stage:** prd-created → **Status:** needs-verification
**Created:** 2025-11-15 | **Updated:** 2026-01-20
**Owner:** רינת

**Progress:**
├─ Research: ✅
├─ Insights: ✅
└─ PRD: ✅

**Next Action:**
→ Run /verify nx2u to validate PRD

⏰ **Warning:** Last updated 24 days ago

──────────────────────────────────────

🎯 LinkedIn-PM (📋 PM-only)

**Stage:** planned → **Status:** in-execution
**Created:** 2026-01-05 | **Updated:** 2026-02-10
**Owner:** רינת

**Progress:**
├─ Research: ❌
├─ Insights: ❌
└─ PRD: ✅

**Next Action:**
→ Use /today to work on tasks

🚨 **Blockers:**
   - Waiting for interview with Sarah
   - Content calendar needs approval

──────────────────────────────────────

📈 Summary

**By Stage:**
├─ 🔍 Discovery: 0
├─ ✅ Discovery Complete: 1
├─ 📝 PRD Created: 1
├─ ✔️  Verified: 0
├─ 🗺️  Planned: 1
├─ 💻 In Progress: 1
└─ 🚀 Shipped: 0

**By Type:**
├─ PM-only: 2
└─ Full-stack: 1

**Needs Attention:**
├─ 🚨 With blockers: 1
└─ ⏰ Stale (>30 days): 0

**Ready for Action:**
├─ Ready for PRD: 1
├─ Ready for verification: 1
├─ Ready for roadmap: 0
└─ Ready for dev: 0

═══════════════════════════════════════
```

---

## Success Criteria

✅ Shows all projects from workspace
✅ Clear stage and status display
✅ Highlights blockers
✅ Shows next actions
✅ Summary stats calculated
✅ Stale projects identified
✅ Read-only (no modifications)
✅ Clear error messages

---

**Created:** 13 February 2026
**Updated:** 15 February 2026 - v1.0.0 Architecture
**Status:** ✅ Updated for v1.0.0
