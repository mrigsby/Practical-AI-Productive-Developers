# Claude Code Configuration Example

A working example of how to configure Claude Code for a project and for
yourself. Every file here is a real, usable starting point. Copy what
fits, delete what does not.

Nothing in this repository is application code. It is configuration only.

## Practical AI, Productive Developers Presentation

`Practical-AI-Productive-Developers.pdf`

Most developers meet an AI coding assistant the same way: they open a terminal in a project, ask a question, get a decent answer, and then slowly discover that the results get worse as the task gets bigger. The tool did not change. The way it was pointed at the problem did. This session is about pointing it well. We will walk through how to bring an AI assistant into an existing codebase so it actually understands the code, how to use plan mode and sub-agents to do real feature work instead of one-off snippets, and how to keep control of the whole thing through permissions, review gates, and git discipline. The focus is practical and repeatable: the setup you do once per project, the habits you use every day, and the guardrails that let you delegate work without losing track of what got changed. If you use Claude Code, ran /init, and stopped there, you will leave with an improved and practical workflow. If you have been using it for a while, you will leave with the pieces most people skip.

## The two layers

Claude Code reads configuration from two places:

| Layer | Location | Who it is for |
|---|---|---|
| Project | this repository | the team, committed to git |
| Global | `~/.claude/` on your machine | you, across every project |

The rule of thumb: if a teammate would benefit from it, it belongs in the
repo. If it is a personal preference, an absolute path, or anything with
a credential in it, it stays out of the repo.

The `GLOBAL/` folder in this repository is **not** something Claude Code
reads. It is a copy of what a personal `~/.claude/` directory looks like,
included here so you can see both layers side by side. To use it, copy
its contents into `~/.claude/`.

## Repository layout

```
.
├── CLAUDE.md                     project instructions, loaded every session
├── CLAUDE.local.md.example       template for personal per-project notes
├── .mcp.json                     team shared MCP servers
├── .worktreeinclude              gitignored files to copy into new worktrees
├── .gitignore
├── .claude/
│   ├── settings.json             permissions, hooks, output style
│   ├── settings.local.json.example
│   ├── rules/                    topic instructions, some path scoped
│   ├── skills/                   reusable prompts, invoked with /name
│   ├── commands/                 single file prompts, also /name
│   ├── agents/                   sub-agent definitions
│   ├── hooks/                    scripts that settings.json points at
│   └── output-styles/            project shared response styles
└── GLOBAL/                       copy this into ~/.claude/
    ├── CLAUDE.md
    ├── settings.json
    ├── rules/
    ├── skills/
    ├── commands/
    ├── agents/
    └── output-styles/
```

## Project files

### `CLAUDE.md`

The file that does the most work. Project instructions, build commands,
conventions, and house rules, loaded into context at the start of every
session.

The house rules are grouped into four sets: honesty (do not guess, ask
instead), style (comments, punctuation, spelling), safety (approve the
message, the commit, and the push separately), and planning (phases and
pause points). Those are the parts worth copying verbatim. The project
and commands sections at the top are placeholders to replace.

Keep it under about 200 lines. Longer files still load in full, but
adherence drops. When it gets long, move topic specific guidance into
`.claude/rules/`.

### `CLAUDE.local.md.example`

Template for a gitignored file that loads alongside `CLAUDE.md`. Personal
notes about this one project that the team does not need. Copy it to
`CLAUDE.local.md` to use it.

### `.mcp.json`

Model Context Protocol servers shared with the team. This connects Claude
to outside systems: a tracker, a database, a docs site. Note the
`${DOCS_TOKEN}` reference. Secrets come from the environment so they never
land in the file. This lives at the project root, not inside `.claude/`.

### `.worktreeinclude`

Lists gitignored files to copy into each new git worktree. Worktrees are
fresh checkouts, so untracked files like `.env` are missing by default.

### `.claude/settings.json`

Settings Claude Code applies directly rather than reads as guidance.
Permissions control which commands run without a prompt, hooks run
scripts at fixed points, and `outputStyle` selects a response style.

The allowlist here covers the safe and repetitive commands so you stop
rubber stamping every prompt. The deny list blocks destructive commands
and reads of credential files.

### `.claude/settings.local.json.example`

Your personal overrides for this project, in the same format. The real
file is gitignored. Machine specific permissions and paths only, never
credentials.

### `.claude/rules/`

Project instructions split into topic files. A rule with `paths:`
frontmatter loads only when Claude reads a matching file, so it costs no
context the rest of the time. A rule without `paths:` loads at session
start like `CLAUDE.md`.

- `testing.md` loads on test files. Includes the rule that matters most:
  never change a failing test to make it pass.
- `api-design.md` loads on files under `src/api/`.
- `commit-messages.md` has no path scope, so it always loads.

### `.claude/skills/`

Reusable prompts. Each skill is a directory with a `SKILL.md` plus any
supporting files it needs, which is the difference between a skill and a
command.

- `security-review/` bundles the prompt with a `checklist.md` the skill
  tells Claude to read. It sets `disable-model-invocation: true` so only
  you can trigger it, never Claude on its own.

### `.claude/commands/`

Single file prompts. A file at `commands/commit.md` gives you `/commit`.
Skills and commands are the same mechanism now, so prefer a skill when
you need to bundle supporting files, and a command when the prompt stands
alone.

- `phased-plan.md` asks for build phases with testable pause points, then
  dispatches two clean context reviewers to find gaps in the plan.
- `review-claude-md.md` is the end of task habit that keeps `CLAUDE.md`
  from rotting into a changelog.
- `commit.md` drafts the message and stops. It does not commit.
- `onboard.md` is the first thing to run on a repository Claude has never
  seen.

### `.claude/agents/`

Sub-agent definitions. Each runs in its own context window, which is the
whole point: a reviewer that has not watched you write the plan has no
investment in the plan being right.

Agents auto invoke based on their `description`, so write descriptions
narrowly. If you would be surprised to see an agent run on an unrelated
task, its description is too broad. The `tools:` field restricts what it
can do. Every reviewer here is read only.

- `pattern-finder.md` finds every occurrence of something and reports.
  Never edits.
- `plan-reviewer.md` reviews a build plan against the codebase for gaps.
- `test-writer.md` writes tests from the requirement, not from the
  implementation.
- `dependency-reviewer.md` reports on licenses, unused packages, and
  version drift.

### `.claude/hooks/`

Shell scripts that `settings.json` points at. `CLAUDE.md` is a request
that the model can drift from. A hook is enforcement that cannot be
talked out of.

- `check-commit.sh` runs before any Bash command and blocks a bare
  `git commit` or `git push`. It shows the exit code 2 pattern, which is
  the only exit code that blocks. Exit code 1 logs an error and lets the
  command proceed, which is the most common mistake with hooks.
- `format-on-write.sh` runs after every file edit and formats the file.
  It cannot block anything, because the edit already happened.

Both scripts read the tool call as JSON on stdin.

### `.claude/output-styles/`

A response style, selected by the `outputStyle` key in `settings.json`.
The default is verbose: it restates your task, narrates each step, and
reprints files you already have, so you skim it. Skimmed output gets
approved without review.

`concise.md` specifies result first, no restatement, cite file paths
instead of reprinting files, and stop when done.

Output styles are usually personal, so most belong in `~/.claude/`. There
is one here as well for teams that want to share one.

## Global files

Copy the contents of `GLOBAL/` into `~/.claude/` to use them. On Windows,
that path is `%USERPROFILE%\.claude`.

### `GLOBAL/CLAUDE.md`

Your preferences, loaded in every project alongside that project's own
`CLAUDE.md`. When the two conflict, the project file wins. Keep this
short, because it costs context in every project you open.

### `GLOBAL/settings.json`

Your default permissions and output style across all projects. Project
settings override matching keys.

### `GLOBAL/rules/personal-style.md`

Engineering preferences that follow you everywhere, separate from any
one team's conventions.

### `GLOBAL/skills/ste-writing/`

A writing skill that rewrites prose into ASD-STE100 Simplified Technical
English. It exists to remove the recognizable texture of generated text
from documentation, pull request descriptions, release notes, and commit
messages.

It has two modes. Strict applies every rule and both length caps, for
procedures and error messages. STE-flavored relaxes the dictionary
restriction for general prose so the text still reads naturally. The self
lint section at the end is the part that does the work: six mechanical
checks to run before returning any text.

The house rules in `CLAUDE.md` reference this skill in two places, for
commit messages and for public facing text.

### `GLOBAL/commands/`

- `rubber-duck.md` makes Claude ask the questions a good reviewer would
  ask before offering a solution.
- `what-did-you-guess.md` asks it to list its own assumptions and what it
  would need to read to remove them. Useful at the end of any session on
  unfamiliar code, and the answers are a ready made list of what to add
  to `CLAUDE.md`.

### `GLOBAL/agents/code-reviewer.md`

A general code reviewer available in every project. Read only, and every
finding must include a concrete fix.

### `GLOBAL/output-styles/concise.md`

The same concise style as the project copy. This is where it usually
belongs, since response style is a personal preference.

## Getting started

1. Copy `CLAUDE.md` into your project and replace the project and
   commands sections with real values. Keep the house rules.
2. Copy `.claude/settings.json` and edit the allowlist to match the
   commands you actually run.
3. Copy `GLOBAL/` into `~/.claude/`.
4. Add the rules, agents, commands, and hooks as you find you need them.
   You do not need all of them on day one.

The two files that carry most of the value are `CLAUDE.md` and
`settings.json`. Everything else is optional.

## Notes

The scripts in `.claude/hooks/` require `jq`. The formatting hook assumes
Prettier and a Node project. Replace it with whatever your project uses.

Claude Code's configuration surface changes regularly. For the current
reference, see the official documentation at
<https://code.claude.com/docs/en/claude-directory>.
