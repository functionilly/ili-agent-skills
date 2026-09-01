---
name: found-project
description: Found a new project - run the fresh-eyes grill on the app idea, write the founding ADRs, configure the repo for the skills, and cut the first vertical slices. Use when the user starts a new project or a new repo and wants the buildout to follow explicit architecture decisions.
disable-model-invocation: true
---

# Found Project

Start a project on decisions, not defaults. The fresh-eyes grill defines the
target architecture before code exists. The founding ADRs bind the buildout
from the first commit.

This skill conducts other skills. It owns the routing between phases. The
interview, the ADR writes, and the tracker actions belong to the skills that
own them.

## Preconditions

- A new or nearly empty repo. For a grown project, run `/sys-design-review`.
- The user is present. Every phase needs the user.

## Phase 1 — Configure

Run `/setup-skills`. It records the tracker, the labels, and the doc layout,
and it seeds the formats the later phases follow.

## Phase 2 — Grill

Run `/fresh-grill`. The app line comes from the user's pitch. The report
states the target architecture: the application, the deployment, the
organization, and the open risks.

## Phase 3 — Found the decision record

Walk the report with the user, one recommendation at a time. For each
accepted decision that passes the three ADR conditions, write one ADR in the
format of `docs/agents/adr-format.md`. Record the capability and the
selecting constraint; name a technology only with its constraint attached.
An open risk or an assumption is not an ADR.

Run the history check before the commit.

When the report selects more than one repo, run phases 1, 3, and 4 in each
repo. The grill runs once.

## Phase 4 — Cut the first slices

Run `/to-issues`:

- One parent issue: the walking skeleton — the thinnest path through every
  layer of the target architecture that a user can see work.
- Vertical slices as children. Each slice cites the founding slugs it binds.
- One question issue per open risk and per assumption from the report,
  labeled `ready-for-human`.

## Checks before you report done

1. Read each founding ADR. Each follows the template, and each technology
   name carries its selecting constraint. The history check passes.
2. Read the report's open risks. Each names a question issue.
3. Read the parent issue. The first slice is demoable end to end.
