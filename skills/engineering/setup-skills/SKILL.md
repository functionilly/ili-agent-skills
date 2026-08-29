---
name: setup-skills
description: Set up the per-repo configuration that the engineering skills read - the issue tracker, the triage label vocabulary, and the domain doc layout. Run before first use of to-issues, to-prd, triage, wayfinder, diagnose, tdd, improve-codebase-architecture, or zoom-out.
disable-model-invocation: true
---

# Setup Skills

Write the per-repo configuration that the engineering skills read:

- **Issue tracker** — where issues live. GitHub is the default. Local markdown is the fallback.
- **Triage labels** — the strings for the five canonical triage roles.
- **Domain docs** — where the glossary and the ADRs live.

This is a conversation, not a script. Explore first. Present what you found.
Confirm with the user. Then write.

## Process

### 1. Explore

Read the current state of the repo. Do not assume:

- `git remote -v` — is this a GitHub repo? Which one?
- `CLAUDE.md` and `AGENTS.md` at the root — does either exist? Does an `## Agent skills` block exist?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — prior output of this skill
- `.scratch/` — a sign of a local markdown tracker

### 2. Present and ask

Summarize what is present and what is absent. Then walk through three decisions,
one at a time. Explain each decision before you ask. Assume the user does not know the terms.

**Decision A — Issue tracker.**
Explain: the skills read and write issues here. If the remote points at GitHub, propose GitHub.
The options:

- **GitHub** — issues live in GitHub Issues. The skills use the `gh` CLI.
  Point the user to `docs/github/GITHUB-SETUP.md` in the skills repo if `gh` is not ready.
- **Local markdown** — issues live under `.scratch/<feature>/` in this repo.
- **Other** — ask the user to describe the workflow in one paragraph. Record it as prose.

**Decision B — Triage labels.**
Explain: the triage skill applies labels that must match the repo's real label strings.
Show the five canonical roles: `needs-triage`, `needs-info`, `ready-for-agent`,
`ready-for-human`, `wontfix`. The default string for each role equals its name.
Ask if the user wants to map any role to a different string.

**Decision C — Domain docs.**
Explain: some skills read `CONTEXT.md` for the domain language, and `docs/adr/` for decisions.
Confirm the layout:

- **Single-context** — one `CONTEXT.md` and one `docs/adr/` at the root. Most repos.
- **Multi-context** — a `CONTEXT-MAP.md` at the root points to per-context files. Monorepos.

### 3. Confirm

Show a draft of the `## Agent skills` block and the three files under `docs/agents/`.
Let the user edit the draft before you write.

### 4. Write

Select the target file:

- If `CLAUDE.md` exists, edit it.
- If only `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create.

Do not create a second file when one exists. If an `## Agent skills` block exists,
update it in place. Do not append a duplicate.

The block:

```markdown
## Agent skills

### Issue tracker

[one line]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one line]. See `docs/agents/triage-labels.md`.

### Domain docs

[one line: "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### Code documentation

File headers, constraint lines, and docstrings. See `docs/agents/code-docs.md`.
```

Then write the four files. Use the seed templates in this folder:

- [issue-tracker-github.md](./issue-tracker-github.md)
- [issue-tracker-local.md](./issue-tracker-local.md)
- [triage-labels.md](./triage-labels.md)
- [domain.md](./domain.md)
- [code-docs.md](./code-docs.md)

For "other" trackers, write `docs/agents/issue-tracker.md` from the user's description.

### 5. Done

Tell the user which skills now read these files. Tell the user that direct edits to
`docs/agents/*.md` are fine. A re-run of this skill is only necessary for a tracker change.
