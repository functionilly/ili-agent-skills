# Domain docs

How the skills consume this repo's domain documentation.

## Read these before exploration

- `CONTEXT.md` at the repo root — the glossary.
- `CONTEXT-MAP.md` at the repo root, if it exists — it points at one `CONTEXT.md` per context.
- `docs/adr/` — decisions that touch the area of your work. Read the root and the
  scope folder of your area. In multi-context repos, also check `src/<context>/docs/adr/`.
  Naming, placement, and supersession: see `docs/agents/adr-format.md`.

If a file does not exist, continue in silence. Do not flag the absence.
The `/grill-with-docs` skill creates these files when a term or decision is resolved.

## Layout

Single-context repo (most repos):

```
/
├── CONTEXT.md
├── docs/adr/
└── src/
```

Multi-context repo (a `CONTEXT-MAP.md` exists at the root):

```
/
├── CONTEXT-MAP.md
├── docs/adr/            <- system-wide decisions
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/    <- context-specific decisions
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## Use the glossary vocabulary

When your output names a domain concept, use the term from `CONTEXT.md`. Do not drift
to synonyms that the glossary rejects. If a concept is not in the glossary, that is a signal.
Either you invent language the project does not use, or there is a real gap.
Note the gap for `/grill-with-docs`.

## Flag ADR conflicts

If your output contradicts an ADR, say so. Do not override it in silence.

> _Contradicts store-orders-as-events — but worth a reopen because…_
