#!/bin/bash
# Validates YAML frontmatter in .pm-brain/ files after edit
# Called by PostToolUse hook when a .pm-brain/ file is modified

FILE="$1"

# Only validate .pm-brain/ files
if [[ "$FILE" != *".pm-brain/"* ]]; then
  exit 0
fi

# Only validate .md files
if [[ "$FILE" != *.md ]]; then
  exit 0
fi

# Check file exists
if [[ ! -f "$FILE" ]]; then
  exit 0
fi

ERRORS=()

# Check for YAML frontmatter opening
if ! head -1 "$FILE" | grep -q "^---$"; then
  ERRORS+=("missing YAML frontmatter (file should start with ---)")
fi

# Check for required field: type
if ! grep -q "^type:" "$FILE"; then
  ERRORS+=("missing required field: type")
fi

# Check for required date field — accept either "date:" or "updated:" (knowledge files use updated:)
if ! grep -qE "^(date|updated):" "$FILE"; then
  ERRORS+=("missing required date field (date: or updated:)")
fi

# Check frontmatter is closed
if ! awk '/^---/{count++} count==2{found=1; exit} END{exit !found}' "$FILE"; then
  ERRORS+=("YAML frontmatter not closed (missing second ---)")
fi

# Report errors
if [ ${#ERRORS[@]} -gt 0 ]; then
  echo "⚠️  PM Brain YAML validation — $FILE"
  for err in "${ERRORS[@]}"; do
    echo "   • $err"
  done
  exit 1
fi

exit 0
