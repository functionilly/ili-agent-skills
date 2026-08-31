# Agent Skills

A collection of agent skills for Claude Code and compatible agents. The skills read
per-repo configuration that `/setup-skills` writes.

## Language

**Issue tracker**:
The tool that holds a repo's issues. GitHub Issues is the default. A local `.scratch/`
markdown convention is the fallback.
_Avoid_: backlog, backlog manager, issue host

**Issue**:
One tracked unit of work in the issue tracker. A bug, a task, a question, or a slice.
_Avoid_: ticket

**Triage role**:
A canonical state label on an issue. The five roles are `needs-triage`, `needs-info`,
`ready-for-agent`, `ready-for-human`, and `wontfix`.

**Garden pass**:
A triage pass that prunes and consolidates open issues in one approved batch.

**Question issue**:
An issue that holds one open question, labeled `ready-for-human`. A grill session
resolves it. The resolution is an ADR, new slices, or both.

**Glossary**:
The `CONTEXT.md` file of a repo. It defines the domain terms of that repo.

**ADR**:
An architecture decision record in `docs/adr/`. It records one current, hard-to-reverse
decision. Its filename slug is its identifier.

**Slug**:
The kebab-case filename of an ADR, without `.md`. It states the rule as an imperative
and serves as the grep token.

**Constraint line**:
One header comment line in a source file. It states the local rule of one ADR: `ADR <slug>: <rule>`.

**Rebaseline**:
A sys-design-review pass. It rewrites the ADRs of a repo to the current decisions
and restructures the tracker to match.

**History check**:
The verbatim grep of `docs/adr/` and the glossary for history markers, defined in
the ADR format doc. Zero hits is the pass condition.

**Vertical slice**:
A thin, complete path through all layers of the system. A completed slice is demoable.
_Avoid_: tracer bullet (used only as an explanation of the concept)

**AFK**:
Work that an agent completes without human interaction.

**HITL**:
Work that needs a human in the loop.

## Relationships

- An **issue tracker** holds many **issues**.
- An **issue** carries one **triage role** at a time.
- A parent **issue** can hold slice **issues** and **question issues** as children.
