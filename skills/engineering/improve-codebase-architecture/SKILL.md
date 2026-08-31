---
name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr. Use when the user wants to improve architecture, find refactor opportunities, consolidate coupled modules, or make a codebase more testable and navigable.
---

# Improve Codebase Architecture

Surface architectural friction. Propose **deepening opportunities** — refactors that
turn shallow modules into deep modules. The aim is testability and AI-navigability.

## Glossary

Use these terms exactly, in every suggestion. Do not drift into "component", "service",
or "boundary".

- **Module** — anything with an interface and an implementation: a function, class,
  package, or slice.
- **Interface** — everything a caller must know: types, invariants, error modes,
  ordering, config. Not only the type signature.
- **Implementation** — the code inside.
- **Depth** — leverage at the interface. Much behavior behind a small interface.
  **Deep** = high leverage. **Shallow** = the interface is nearly as complex as the
  implementation.
- **Seam** — where an interface lives. A place to alter behavior without an edit in place.
  Use this word, not "boundary".
- **Adapter** — a concrete thing that satisfies an interface at a seam.
- **Leverage** — what callers get from depth.
- **Locality** — what maintainers get from depth: change, bugs, and knowledge in one place.

Key principles:

- **The deletion test**: imagine the module deleted. If complexity vanishes, the module
  was a pass-through. If complexity reappears across N callers, the module earned its place.
- **The interface is the test surface.**
- **One adapter = a hypothetical seam. Two adapters = a real seam.**

The project's domain model informs this skill. The glossary names the good seams.
The ADRs record decisions you must not re-litigate.

## Process

### 1. Explore

Read the glossary and the ADRs in the area first. Then walk the codebase without rigid
heuristics. Note where you feel friction:

- Where does one concept force a bounce between many small modules?
- Where are modules shallow?
- Where were pure functions extracted for testability, while the real bugs hide in how
  they are called?
- Where do coupled modules leak across their seams?
- Which parts have no tests, or resist tests through their current interface?

Apply the deletion test to every suspect module. "Deletion concentrates complexity"
is the signal you want.

### 2. Present candidates

Present a numbered list of deepening opportunities. For each candidate:

- **Files** — the modules involved
- **Problem** — why the current shape causes friction
- **Solution** — the change, in plain words
- **Benefits** — in terms of locality, leverage, and better tests

Show a short before and after code sketch for each candidate. Keep each sketch
under 15 lines. A sketch makes the candidate concrete for the user. The sketch is
an illustration, not a design.

Use the `CONTEXT.md` vocabulary for the domain, and this skill's glossary for the
architecture. If the glossary defines "Order", say "the Order intake module".

**ADR conflicts**: surface a candidate that contradicts an ADR only when the friction
justifies a reopen. Mark it: _"contradicts store-orders-as-events — but worth a reopen because…"_.

Do not design the full interface yet. Ask: "Which of these do you want to explore?"

### 3. Grilling loop

When the user selects a candidate, drop into a grilling conversation. Walk the design
tree: constraints, dependencies, the shape of the deepened module, what sits behind the
seam, which tests survive. See [DEEPENING.md](./DEEPENING.md) for the dependency
categories and the seam discipline.

Side effects happen at once, as decisions crystallize:

- A deepened module gets a name that is not in `CONTEXT.md`? Add the term.
  Use [CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md).
- A fuzzy term gets sharp during the conversation? Update `CONTEXT.md` there.
- A module got deepened? Write its file header and interface docstrings, per
  docs/agents/code-docs.md.
- The user rejects a candidate with a load-bearing reason? Offer an ADR:
  "Do you want this recorded, so future reviews do not re-suggest it?"
  Skip ephemeral or self-evident reasons.
  Use [ADR-FORMAT.md](../grill-with-docs/ADR-FORMAT.md).
