---
name: grill-with-docs
description: Interview the user about a plan, challenge it against the project's domain model, and update CONTEXT.md and ADRs during the session. Use when the user wants to stress-test a plan against the project's language and documented decisions.
---

# Grill With Docs

Interview the user about every part of the plan until you reach a shared understanding.
Walk down each branch of the design tree. Resolve dependencies between decisions one by one.
Give your recommended answer with each question.

Ask one question at a time. Wait for the answer before you continue.
If the codebase can answer a question, explore the codebase instead.

## Domain awareness

During exploration, also look for these documents:

- `CONTEXT.md` at the root — the glossary.
- `CONTEXT-MAP.md` at the root — present only in multi-context repos. It points at the contexts.
- `docs/adr/` — past decisions.

Create files only when you have content to write. If no `CONTEXT.md` exists, create it
when the first term is resolved. If no `docs/adr/` exists, create it with the first ADR.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with `CONTEXT.md`, say so at once.
"The glossary defines 'cancellation' as X. You seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses a vague or overloaded term, propose one precise term.
"You say 'account'. Do you mean the Customer or the User? Those are different things."

### Test with concrete scenarios

When the user describes domain relationships, invent scenarios that probe the edge cases.
Force precision at the boundaries between concepts.

When the plan is about code, show a short code example of each option. An example
makes the trade-off concrete.

### Cross-reference with code

When the user states how something works, check the code. If the code disagrees, say so.
"The code cancels full Orders. You said partial cancellation is possible. Which is right?"

### Update CONTEXT.md at once

When a term is resolved, write it to `CONTEXT.md` in that moment. Do not batch the updates.
Use the format in [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` is a glossary and nothing else. Do not put implementation details,
specifications, or notes in it.

### Offer ADRs with restraint

Offer an ADR only when all three conditions are true:

1. **Hard to reverse** — a later change of mind has a real cost.
2. **Surprising without context** — a future reader will ask "why did they do this?"
3. **A real trade-off** — there were real alternatives, and one was selected for reasons.

If one condition is false, skip the ADR. Use the format in [ADR-FORMAT.md](./ADR-FORMAT.md).

When the user accepts an ADR, list the files the decision binds. Add one constraint
line to the header of each file. See docs/agents/code-docs.md. When the new ADR
supersedes an old ADR, grep the old number. Update each header that carries it.
