# ADR format

ADRs live in `docs/adr/`. Use sequential numbers: `0001-slug.md`, `0002-slug.md`.
Create the directory with the first ADR, not before.

## Template

```md
# {Short title of the decision}

{One to three sentences: the context, the decision, and the reason.}
```

An ADR can be one paragraph. The value is the record that a decision was made, and why.

## Optional sections

Add these only when they carry real value. Most ADRs do not need them.

- **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`)
- **Considered options** — only when the rejected alternatives are worth memory.
- **Consequences** — only for downstream effects that are not obvious.

## Numbering

Find the highest number in `docs/adr/`. Add one.

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
- **Non-obvious rejections.** If you weighed GraphQL and selected REST for subtle reasons,
  record it. Otherwise, someone proposes GraphQL again in six months.
