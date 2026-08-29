# Agent Skills

A collection of agent skills for Claude Code and compatible agents. The skills read
per-repo configuration that `/setup-skills` writes.

## Language

**Issue tracker**:
The tool that holds a repo's issues. GitHub Issues is the default. A local `.scratch/`
markdown convention is the fallback.
_Avoid_: backlog, backlog manager, issue host

**Issue**:
One tracked unit of work in the issue tracker. A bug, a task, a PRD, or a slice.
_Avoid_: ticket (permitted only inside the wayfinder skill, where "decision ticket" is a defined term)

**Triage role**:
A canonical state label on an issue. The five roles are `needs-triage`, `needs-info`,
`ready-for-agent`, `ready-for-human`, and `wontfix`.

**Garden pass**:
A triage pass that prunes and consolidates open issues in one approved batch.

**Map**:
A wayfinder issue with the label `wayfinder:map`. It indexes the decisions of one large effort.

**Decision ticket**:
A child issue of a map. It holds one question. Its resolution is a decision, not a deliverable.

**Frontier**:
The set of open, unblocked, unclaimed decision tickets of a map.

**Glossary**:
The `CONTEXT.md` file of a repo. It defines the domain terms of that repo.

**ADR**:
An architecture decision record in `docs/adr/`. It records one hard-to-reverse decision.

**Constraint line**:
One header comment line in a source file. It states the local rule of one ADR: `ADR-NNNN: <rule>`.

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
- A **map** has many **decision tickets** as child issues.
- The **frontier** contains only **decision tickets** that are open, unblocked, and unclaimed.
