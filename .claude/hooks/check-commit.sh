#!/bin/bash
# PreToolUse hook on the Bash tool.
#
# Enforces the house rule that a commit message must be drafted and
# approved before anything is committed. Exit code 2 blocks the tool call
# and sends the stderr text back to Claude as the reason.
#
# Note: exit code 1 does NOT block. It logs an error and proceeds. If a
# hook enforces a policy, it must exit 2.
#
# Escape hatch: set CLAUDE_COMMIT_APPROVED=1 in the environment after you
# have reviewed and approved the message.

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if [[ "$command" == git\ commit* && "${CLAUDE_COMMIT_APPROVED}" != "1" ]]; then
  echo "House rule: draft the commit message, revise it with the ste-writing skill, and get it approved before committing." >&2
  exit 2
fi

if [[ "$command" == git\ push* && "${CLAUDE_PUSH_APPROVED}" != "1" ]]; then
  echo "House rule: approval to commit is not approval to push. Ask first." >&2
  exit 2
fi

exit 0
