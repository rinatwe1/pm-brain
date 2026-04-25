#!/usr/bin/env bash
# Tests for install.sh — happy path

set -uo pipefail

PASS=0
FAIL=0
PM_BRAIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_LINK="$HOME/.claude/skills/pm-brain"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "install.sh"

# --- Run install ---
"$PM_BRAIN_DIR/install.sh" > /dev/null 2>&1
INSTALL_EXIT=$?

[ $INSTALL_EXIT -eq 0 ] && pass "exits 0" || fail "exits 0 (got $INSTALL_EXIT)"

# --- Symlink ---
[ -L "$SKILLS_LINK" ] && pass "symlink created at ~/.claude/skills/pm-brain" || fail "symlink missing at $SKILLS_LINK"

[ -L "$SKILLS_LINK" ] && {
  TARGET=$(readlink "$SKILLS_LINK")
  EXPECTED="$PM_BRAIN_DIR/skills"
  [ "$TARGET" = "$EXPECTED" ] && pass "symlink points to PM-Brain/skills/" || fail "symlink target wrong (got $TARGET, want $EXPECTED)"
}

# --- All skill directories reachable via symlink ---
EXPECTED_SKILLS=(brain-init brain-import brain-review decision-log hypothesis prd discover create verify roadmap dashboard strategy-check)
for skill in "${EXPECTED_SKILLS[@]}"; do
  [ -f "$SKILLS_LINK/$skill/SKILL.md" ] && pass "skill reachable: $skill" || fail "skill missing via symlink: $skill"
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
