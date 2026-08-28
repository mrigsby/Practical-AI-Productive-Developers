---
description: Reviews code changes for security vulnerabilities, authentication gaps, and injection risks
disable-model-invocation: true
argument-hint: <branch-or-path>
---

## Diff to review

!`git diff $ARGUMENTS`

Audit the changes above for:

1. Injection vulnerabilities (SQL, XSS, command)
2. Authentication and authorization gaps
3. Hardcoded secrets or credentials
4. Input that reaches a sink without validation

Use checklist.md in this skill directory for the full review checklist.

Report findings with a severity rating and a concrete remediation step.
If you find nothing, say so. Do not pad the report with observations that
are not findings.
