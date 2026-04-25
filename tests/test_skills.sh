#!/usr/bin/env bash
# Tests for SKILL.md files — validates structure and frontmatter

set -uo pipefail

PASS=0
FAIL=0
PM_BRAIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$PM_BRAIN_DIR/skills"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

EXPECTED_SKILLS=(brain-init brain-import brain-review decision-log hypothesis prd discover create verify roadmap dashboard strategy-check)

echo "SKILL.md files"

for skill in "${EXPECTED_SKILLS[@]}"; do
  SKILL_FILE="$SKILLS_DIR/$skill/SKILL.md"

  [ -f "$SKILL_FILE" ] || { fail "$skill/SKILL.md exists"; continue; }
  pass "$skill/SKILL.md exists"

  # Frontmatter: starts with ---
  head -1 "$SKILL_FILE" | grep -q "^---" && pass "$skill: has frontmatter" || fail "$skill: missing frontmatter"

  # Has name: field
  grep -q "^name:" "$SKILL_FILE" && pass "$skill: has name field" || fail "$skill: missing name field"

  # Has description: field
  grep -q "^description:" "$SKILL_FILE" && pass "$skill: has description field" || fail "$skill: missing description field"

  # Not empty (>10 lines)
  LINE_COUNT=$(wc -l < "$SKILL_FILE")
  [ "$LINE_COUNT" -gt 10 ] && pass "$skill: has content ($LINE_COUNT lines)" || fail "$skill: suspiciously short ($LINE_COUNT lines)"
done

# --- Templates ---
echo ""
echo "Templates"

EXPECTED_TEMPLATES=(decision-template.md quality-criteria-template.md competitor-analysis-template.md insights-template.md interview-guide-template.md prd-template.md research-plan-template.md)
for tpl in "${EXPECTED_TEMPLATES[@]}"; do
  [ -f "$PM_BRAIN_DIR/templates/$tpl" ] && pass "$tpl exists" || fail "$tpl missing"
done

# --- Knowledge base ---
echo ""
echo "Knowledge base"

EXPECTED_DOMAINS=(discovery strategy growth metrics ux roadmap market)
for domain in "${EXPECTED_DOMAINS[@]}"; do
  for file in knowledge.md hypotheses.md rules.md; do
    [ -f "$PM_BRAIN_DIR/knowledge-base/$domain/$file" ] && pass "$domain/$file exists" || fail "$domain/$file missing"
  done
done

[ -f "$PM_BRAIN_DIR/knowledge-base/INDEX.md" ] && pass "INDEX.md exists" || fail "INDEX.md missing"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
