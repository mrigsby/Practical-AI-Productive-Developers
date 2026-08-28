---
paths:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.ts"
---

# Testing Rules

These load only when a test file enters context.

- Write the test from the specification, not from the implementation. A
  test written by reading the code will pass against that code,
  including its bugs.
- Use descriptive names: "should [expected] when [condition]".
- Mock external dependencies. Do not mock internal modules.
- Clean up side effects in `afterEach`.
- Never change a failing test to make it pass. Fix the code, or report
  that the test itself is wrong and wait for a decision.
