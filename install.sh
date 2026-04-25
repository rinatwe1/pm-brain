#!/bin/bash
# PM Brain — Installer
# Run once. Then forget this directory exists.

set -e

PM_BRAIN_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
LINK_NAME="pm-brain"

echo "Installing PM Brain..."
echo ""

# Create skills directory if needed
mkdir -p "$SKILLS_DIR"

# Remove old installation (symlink or directory)
if [ -L "$SKILLS_DIR/$LINK_NAME" ]; then
  rm "$SKILLS_DIR/$LINK_NAME"
  echo "Removed old symlink"
elif [ -d "$SKILLS_DIR/$LINK_NAME" ]; then
  rm -rf "$SKILLS_DIR/$LINK_NAME"
  echo "Removed old directory installation"
fi

# Create symlink: ~/.claude/skills/pm-brain → PM-Brain/skills/
ln -s "$PM_BRAIN_DIR/skills" "$SKILLS_DIR/$LINK_NAME"

echo "✓ Skills linked to ~/.claude/skills/pm-brain/"
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
