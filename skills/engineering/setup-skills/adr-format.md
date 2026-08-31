# Decision records

How this repo records decisions. Skills and agents that read or write ADRs follow
these rules.

## Layout

ADRs live in `docs/adr/`. One file holds one decision. The tree holds only current
decisions. Git holds the history.

- The filename is the identifier: the rule as a kebab-case slug, verb-first, five
  words or fewer. Example: `write-skills-in-ste.md`. No numbers. No dates.
- A repo-wide decision lives at the root: `docs/adr/<slug>.md`.
- A scoped decision lives in the folder of the context it governs: `docs/adr/<scope>/<slug>.md`.

Each file follows one template:

```md
# {The rule, as one imperative sentence}

**Scope:** {repo-wide, or the context this binds}
**Rule:** {the decision in one or two testable sentences}
**Why:** {the trade-off in plain terms, with what was given up}
```

## Read

Before work in an area, read the ADRs at `docs/adr/` root and in the scope folder of
that area. Each file is a current rule. The tree contains no superseded files.

## Cite

Cite the bare slug, not the path:

- File headers: `ADR <slug>: <local rule>` — see `docs/agents/code-docs.md`.
- Docstrings: `(adr: <slug>)`.
- Issues and briefs: `<slug> — the local rule in one line`.

A grep of the slug must find each site the decision binds.

## Supersede

- When the decision evolves, edit the file in place.
- When the paradigm shifts, delete the file and write the new one.
- Do not describe the change in the file. The note about what changed goes in
  the commit message.

The commit that replaces or deletes an ADR must carry a trailer:

```
Superseded: <old-slug> — <one-line why>
```

After the replacement, grep the old slug. Update each constraint line, docstring,
and issue that carries it. When the change also causes code changes, add a
`CHANGELOG.md` entry.

### History check

Decision docs drift toward history prose: "previously", "as of v2", a status
section. Run this check after each write to `docs/adr/` or to the glossary:

```sh
grep -rniE 'previously|formerly|originally|used to|no longer|superseded by|replaced by|deprecated|as of |version [0-9]|\bv[0-9]+\b|## (status|history|changelog)|\*\*status' docs/adr/ CONTEXT.md
```

Zero hits is the pass condition. For each hit, do one of:

- Rewrite the sentence as a current rule. "The API no longer accepts X" becomes
  "The API rejects X."
- Move the note to the commit message. The `Superseded:` trailer holds the change story.
- Let the hit stand only when it states a current rule about an external system,
  such as "Use the v2 API."

In a multi-context repo, add each glossary file you touched to the command.

## History

Git is the only record of superseded decisions. Query it only when the user weighs
an alternative that the project possibly rejected before:

- List retired rules: `git log --diff-filter=D --format='%as %s' --name-only -- docs/adr/`
- Recover a rejection on a topic: `git log -p -i -S"<term>" -- docs/adr/`

Do not load history into context in any other case.

## Legacy files

Old numbered ADRs (`0001-slug.md`) can exist in this repo. Read them as they are.
Write new ADRs in the format above only. Do not renumber or convert old files ad hoc;
a rebaseline pass (`/sys-design-review`) does that.
