#!/usr/bin/env bash
# Validates .pm-brain/ output after /brain-init runs.
# Run this from the product directory after brain-init.
#
# Usage:
#   ./tests/test_brain_init_output.sh [product-dir]
#   ./tests/test_brain_init_output.sh          # uses current directory

set -uo pipefail

PASS=0
FAIL=0
PRODUCT_DIR="${1:-$(pwd)}"
PM_BRAIN="$PRODUCT_DIR/.pm-brain"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo ".pm-brain/ structure — $PRODUCT_DIR"

# --- Root ---
[ -d "$PM_BRAIN" ] || { echo "FATAL: .pm-brain/ not found in $PRODUCT_DIR"; exit 1; }
pass ".pm-brain/ exists"

# --- meta.json ---
META="$PM_BRAIN/meta.json"
[ -f "$META" ] && pass "meta.json exists" || fail "meta.json missing"

[ -f "$META" ] && {
  REQUIRED_FIELDS=(product description primary_user stage init_mode initialized)
  for field in "${REQUIRED_FIELDS[@]}"; do
    grep -q "\"$field\"" "$META" && pass "meta.json has: $field" || fail "meta.json missing: $field"
  done
}

# --- Knowledge domains ---
echo ""
echo "  knowledge/"

DOMAINS=(discovery strategy growth metrics ux roadmap market)
for domain in "${DOMAINS[@]}"; do
  DOMAIN_DIR="$PM_BRAIN/knowledge/$domain"
  [ -d "$DOMAIN_DIR" ] && pass "$domain/ exists" || fail "$domain/ missing"
  for file in knowledge.md hypotheses.md rules.md; do
    [ -f "$DOMAIN_DIR/$file" ] && pass "$domain/$file exists" || fail "$domain/$file missing"
  done
done

[ -f "$PM_BRAIN/knowledge/INDEX.md" ] && pass "knowledge/INDEX.md exists" || fail "knowledge/INDEX.md missing"

# --- Quick mode: answers saved ---
echo ""
echo "  quick mode pre-population"

DISCOVERY_KB="$PM_BRAIN/knowledge/discovery/knowledge.md"
[ -f "$DISCOVERY_KB" ] && {
  grep -q "Product Description\|Primary User" "$DISCOVERY_KB" \
    && pass "discovery/knowledge.md has init answers" \
    || fail "discovery/knowledge.md is empty (Quick mode answers not saved)"
}

STRATEGY_KB="$PM_BRAIN/knowledge/strategy/knowledge.md"
[ -f "$STRATEGY_KB" ] && {
  grep -q "Key Product Context" "$STRATEGY_KB" \
    && pass "strategy/knowledge.md has init answers" \
    || fail "strategy/knowledge.md is empty (Q4 not saved)"
}

# --- Decisions ---
echo ""
echo "  decisions/ + hypotheses/"

[ -d "$PM_BRAIN/decisions" ] && pass "decisions/ exists" || fail "decisions/ missing"
[ -d "$PM_BRAIN/hypotheses" ] && pass "hypotheses/ exists" || fail "hypotheses/ missing"

# --- Quality ---
CRITERIA="$PM_BRAIN/quality/criteria.md"
[ -f "$CRITERIA" ] && pass "quality/criteria.md exists" || fail "quality/criteria.md missing"

[ -f "$CRITERIA" ] && {
  for category in Discovery Strategy Decisions Roadmap; do
    grep -q "$category" "$CRITERIA" && pass "criteria.md has $category category" || fail "criteria.md missing $category"
  done
}

# --- Agents ---
AGENTS_YAML="$PM_BRAIN/agents/agents.yaml"
[ -f "$AGENTS_YAML" ] && pass "agents/agents.yaml exists" || fail "agents/agents.yaml missing"

[ -f "$AGENTS_YAML" ] && {
  grep -q "competitor-watcher" "$AGENTS_YAML" && pass "agents.yaml has competitor-watcher entry" || fail "agents.yaml missing competitor-watcher"
  grep -q "enabled:" "$AGENTS_YAML" && pass "agents.yaml has enabled flag" || fail "agents.yaml missing enabled flag"
}

# --- CLAUDE.md updated ---
echo ""
echo "  CLAUDE.md"

CLAUDE_MD="$PRODUCT_DIR/CLAUDE.md"
[ -f "$CLAUDE_MD" ] && {
  grep -q "PM Brain Memory" "$CLAUDE_MD" && pass "CLAUDE.md has PM Brain block" || fail "CLAUDE.md missing PM Brain block"
  grep -q "\.pm-brain" "$CLAUDE_MD" && pass "CLAUDE.md references .pm-brain/" || fail "CLAUDE.md missing .pm-brain/ reference"
} || fail "CLAUDE.md not found in product directory"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
