#!/bin/bash
# PM Brain — Installer
# Run once. Then forget this directory exists.

set -e

PM_BRAIN_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo "Installing PM Brain..."
echo ""

# Create skills directory if needed
mkdir -p "$SKILLS_DIR"

# Create one symlink per skill (Claude Code looks for ~/.claude/skills/<skill-name>/)
INSTALLED=0
for skill_dir in "$PM_BRAIN_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")

  # Remove old installation if exists (symlink or directory)
  if [ -L "$SKILLS_DIR/$skill_name" ] || [ -d "$SKILLS_DIR/$skill_name" ]; then
    rm -rf "$SKILLS_DIR/$skill_name"
  fi

  ln -s "$skill_dir" "$SKILLS_DIR/$skill_name"
  INSTALLED=$((INSTALLED + 1))
done

echo "✓ $INSTALLED skills linked to ~/.claude/skills/"
echo ""
echo "Skills available:"
for skill in "$PM_BRAIN_DIR/skills"/*/; do
  echo "  /$(basename "$skill")"
done
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Done. You can close this directory now."
echo ""
echo "To start:"
echo "  1. Open Claude Code in your product directory"
echo "  2. Type: /brain-init"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
