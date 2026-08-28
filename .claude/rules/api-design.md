---
paths:
  - "src/api/**/*.ts"
---

# API Design Rules

These load only when an API file enters context.

- Validate all input at the boundary with a schema.
- Return shape is always `{ data }` or `{ error }`, never both.
- Rate limit every public endpoint.
- New endpoints need an entry in the route registry and a test.
