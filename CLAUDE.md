# Project Instructions

Replace the Project and Commands sections with real values for your
repository. The House Rules below are meant to be used as written.

Keep this file under about 200 lines. Longer files still load in full,
but adherence drops. When it gets long, move topic specific guidance
into `.claude/rules/` so it loads only when relevant.

## Project

- Name: example-app
- Stack: replace with your language, framework, and versions
- Entry point: `src/index.ts`
- Additional context: @docs/architecture.md

## Commands

- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
- Dev server: `npm run dev`

## Conventions

- Named exports, never default exports
- Tests live next to source: `foo.ts` becomes `foo.test.ts`
- New modules go in `src/modules/<name>/`
- All API routes return a `{ data, error }` shape

## House Rules: Honesty

- **Do not guess.** When you are unsure, do not make it up. Research it
  or ask me.
- **Ask first.** Ask me any questions needed to remove ambiguity on
  direction or requirements.
- **Say so.** Flag uncertainty rather than presenting a guess as a fact.
- **No invention.** No invented APIs, methods, or file paths. If it
  cannot be verified, it stays out.

## House Rules: Style

- **Code comments.** Brief and plain. Simplified terms, not overly
  technical unless necessary.
- **Dashes.** No em dashes in commit messages, code comments, or
  generated text.
- **Spelling.** American English. Color, not colour. Customize, not
  customise.
- **Edit pass.** Public facing text goes through the ste-writing skill
  before it lands.

## House Rules: Safety

Approve the words, then approve the action.

- Draft the commit message first, then revise it with the ste-writing
  skill.
- Always show it to me for approval. I review, revise, or approve.
- Approval does not cascade. Approval for the message, the commit, and
  the push are three separate approvals.
- No co-authored trailer lines in commit messages.

## House Rules: Planning

- Use plan mode for any task that touches more than two files.
- Divide the plan into logical build phases with steps, not one long
  list of edits.
- Add pause points where I can verify and test the functionality.
- At each pause point, give a simplified overview of what was
  accomplished and exact details on what is ready for me to test.

## House Rules: Keeping This File Current

After approval and completion of a task, review this file and suggest up
to three additions based on the session, plus corrections, gotchas to
avoid in future sessions, and streamlining.

Changes to this file should be replacements, not a continual log of
findings and fixes.
