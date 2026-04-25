#!/usr/bin/env bash
# Tests for install.sh — happy path

set -uo pipefail

PASS=0
FAIL=0
PM_BRAIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "install.sh"

# --- Run install ---
"$PM_BRAIN_DIR/install.sh" > /dev/null 2>&1
INSTALL_EXIT=$?

[ $INSTALL_EXIT -eq 0 ] && pass "exits 0" || fail "exits 0 (got $INSTALL_EXIT)"

# --- Each skill has its own symlink at ~/.claude/skills/<skill-name> ---
EXPECTED_SKILLS=(brain-init brain-import brain-review decision-log hypothesis prd discover create verify roadmap dashboard strategy-check)
for skill in "${EXPECTED_SKILLS[@]}"; do
  LINK="$SKILLS_DIR/$skill"
  [ -L "$LINK" ] && pass "$skill: symlink exists at ~/.claude/skills/$skill" || fail "$skill: symlink missing"
  [ -L "$LINK" ] && {
    TARGET=$(readlink "$LINK")
    EXPECTED="$PM_BRAIN_DIR/skills/$skill/"
    [ "$TARGET" = "$EXPECTED" ] && pass "$skill: points to PM-Brain/skills/$skill/" || fail "$skill: wrong target ($TARGET)"
  }
  [ -f "$SKILLS_DIR/$skill/SKILL.md" ] && pass "$skill: SKILL.md reachable by Claude Code" || fail "$skill: SKILL.md not reachable"
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
