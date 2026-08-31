# ADR format

ADRs live in `docs/adr/`. One file holds one decision. The tree holds only current
decisions. Git holds the history. Create the directory with the first ADR, not before.

## Naming

The filename is the identifier. Write the decision as an imperative rule. Convert the
rule to a kebab-case slug, verb-first, five words or fewer:

- `write-skills-in-ste.md`
- `use-github-native-hierarchy.md`

Do not use numbers. Do not use dates. Code, issues, and briefs cite the bare slug,
not the path. A grep of the slug must find each site the decision binds. Change a
slug only when the decision itself changes. After a slug change, grep the old slug
and update each site.

## Placement

- A repo-wide decision lives at the root: `docs/adr/<slug>.md`.
- A scoped decision lives in the folder of the context it governs: `docs/adr/<scope>/<slug>.md`.
- Create a scope folder with its first decision, not before.

The folder answers "which ADRs bind the area I touch?"

## Template

```md
# {The rule, as one imperative sentence}

**Scope:** {repo-wide, or the context this binds}
**Rule:** {the decision in one or two testable sentences}
**Why:** {the trade-off in plain terms, with what was given up}
```

No other sections. No status field. No history section. Apply one test to each
sentence: does it change what an agent does next? When a rejected alternative still
matters, state it as a current rule: "Do not use X. X breaks under Y." When it does
not matter, leave it to git.

## Supersession

- When the decision evolves, edit the file in place.
- When the paradigm shifts, delete the file and write the new one.

The commit that replaces or deletes an ADR must carry a trailer:

```
Superseded: <old-slug> — <one-line why>
```

After the replacement, grep the old slug. Update each constraint line, docstring,
and issue that carries it. When the change also causes code changes, add a
`CHANGELOG.md` entry in that repo.

## Decision history

Git is the only record of superseded decisions. Query it only when the user weighs
an alternative that the project possibly rejected before:

- List retired rules: `git log --diff-filter=D --format='%as %s' --name-only -- docs/adr/`
- Recover a rejection on a topic: `git log -p -i -S"<term>" -- docs/adr/`

Do not load history into context in any other case.

## Legacy repos

Some repos hold ADRs in an old numbered format (`0001-slug.md`). Read them as they
are. Write new ADRs in this format only. Do not renumber or convert old files ad hoc;
a rebaseline pass (`/sys-design-review`) does that.

## When to offer an ADR

All three conditions must be true:

1. **Hard to reverse** — a later change of mind has a real cost.
2. **Surprising without context** — a future reader will ask "why did they do this?"
3. **A real trade-off** — there were real alternatives, and one was selected for reasons.

### What qualifies

- **Architectural shape.** "We use a monorepo." "The write model is event-sourced."
- **Integration patterns.** "Ordering and Billing communicate with domain events, not HTTP."
- **Technology choices with lock-in.** The database, the message bus, the auth provider.
  Not every library — only the ones that take months to swap.
- **Boundary decisions.** "The Customer context owns customer data. Other contexts hold IDs only."
- **Deliberate deviations from the obvious path.** "We use manual SQL, not an ORM, because X."
  The record stops the next engineer from a "fix" of a deliberate choice.
- **Constraints not visible in the code.** "Compliance forbids AWS." "Responses must stay under 200 ms."
- **Rejections that still bind.** State them as current rules: "Do not use GraphQL. Our
  clients cache REST responses at the edge." Otherwise, someone proposes GraphQL again
  in six months.
