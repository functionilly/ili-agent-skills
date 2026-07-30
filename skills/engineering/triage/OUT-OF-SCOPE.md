# The out-of-scope knowledge base

The `.out-of-scope/` directory stores records of rejected feature requests.
It serves two purposes:

1. **Institutional memory** — the reason a feature was rejected survives the closed issue.
2. **Deduplication** — a new issue that matches a prior rejection surfaces the old
   decision. No re-litigation.

## Directory structure

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

One file per **concept**, not per issue. Several issues that request the same thing
share one file.

## File format

Write the file as a short design document, not as a database entry. Use paragraphs,
code samples, and examples. Make the reason clear to a first-time reader.

```markdown
# Dark Mode

This project does not support dark mode or user-facing themes.

## Why this is out of scope

The rendering pipeline assumes one color palette, defined in `ThemeConfig`.
Several themes would require a theme context provider, per-component style resolution,
and a persistence layer for preferences. That is a large architectural change, and it
does not align with the project's focus on content authoring.

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
```

### The file name

Use a short kebab-case concept name: `dark-mode.md`, `plugin-system.md`. A reader who
browses the directory must understand the rejection from the name alone.

### The reason

Write a substantive reason, not "we do not want this". Good reasons reference:

- Project scope or philosophy
- Technical constraints
- Strategic decisions

Write a durable reason. "We are too busy now" is a deferral, not a rejection.

## When to check `.out-of-scope/`

During triage, in the context-gather step, read all files in `.out-of-scope/`.
Match new issues by concept, not by keyword — "night theme" matches `dark-mode.md`.
On a match, tell the maintainer: "This resembles `.out-of-scope/dark-mode.md`.
We rejected it because [reason]. Does that still hold?"

The maintainer can:

- **Confirm** — append the new issue to "Prior requests", then close it.
- **Reconsider** — delete or update the file. The issue proceeds through normal triage.
- **Disagree** — the issues are distinct. Proceed with normal triage.

## When to write to `.out-of-scope/`

Only when an **enhancement** is rejected as `wontfix`. Bugs do not go here. The flow:

1. The maintainer rules the request out of scope.
2. Check for an existing file that matches the concept.
3. Match: append the issue to "Prior requests". No match: create the file.
4. Comment on the issue with the decision and a link to the file.
5. Close the issue with the `wontfix` label.

## Updates and removals

When the maintainer changes their mind about a concept: delete the file. Do not reopen
old issues — they are historical records. The new issue proceeds through normal triage.
