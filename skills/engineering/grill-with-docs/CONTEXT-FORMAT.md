# CONTEXT.md format

## Structure

```md
# {Context name}

{One or two sentences: what this context is, and why it exists.}

## Language

**Order**:
{One or two sentences that define the term.}
_Avoid_: purchase, transaction

**Invoice**:
A request for payment, sent to a customer after delivery.
_Avoid_: bill, payment request
```

## Rules

- **Be opinionated.** When several words name one concept, select the best word.
  List the others under _Avoid_.
- **Flag conflicts.** If a term is ambiguous, record the ambiguity and its resolution.
- **Keep definitions tight.** Two sentences maximum. Define what the term IS, not what it does.
- **Show relationships.** Use bold term names. State cardinality where it is obvious.
- **Include only project-specific terms.** General programming concepts do not belong,
  even when the project uses them often.
- **Group terms under subheadings** when natural clusters appear. A flat list is fine otherwise.
- **Write an example dialogue.** A short conversation between a developer and a domain expert.
  It shows how the terms interact and where the boundaries are.

## Single-context and multi-context repos

**Single context (most repos)**: one `CONTEXT.md` at the repo root.

**Multiple contexts**: a `CONTEXT-MAP.md` at the root lists the contexts and their relations:

```md
# Context map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) — creates invoices and processes payments

## Relationships

- **Ordering → Billing**: Ordering emits `OrderPlaced` events. Billing consumes them.
```

The rules of inference:

- If `CONTEXT-MAP.md` exists, read it to find the contexts.
- If only a root `CONTEXT.md` exists, the repo has a single context.
- If neither exists, create a root `CONTEXT.md` with the first resolved term.
- With several contexts, infer which context the topic belongs to. Ask if unclear.
