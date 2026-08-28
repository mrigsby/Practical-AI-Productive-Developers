#!/bin/bash
# PostToolUse hook on the Edit and Write tools.
#
# Formats every file Claude edits. PostToolUse runs after the tool has
# already succeeded, so it cannot block anything. It is for reactions:
# formatting, linting, logging.
#
# Replace the formatter with whatever this project uses.

input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

if [[ -z "$file" || ! -f "$file" ]]; then
  exit 0
fi

case "$file" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    npx --no-install prettier --write "$file" 2>/dev/null
    ;;
esac

exit 0
