---
name: sys-design-review
description: Rebaseline a project - review the codebase, the ADRs in any shape, and the open issues; grill the user to define the goal; rewrite the ADRs to current decisions; and restructure the tracker to match. Use when the user wants a system design review or a rebaseline, when the ADRs are messy or stale, or when the tracker no longer matches the goal.
disable-model-invocation: true
---

# Sys Design Review

Rebaseline a project. Rewrite the decision record to match the current goal.
Restructure the tracker to match the decision record. Do not change code.

This skill conducts other skills. It owns the survey, the gap analysis, and the
routing between phases. The interview, the ADR writes, and the tracker actions
belong to the skills that own them.

## Preconditions

- `/setup-skills` has run in the repo. It names the tracker and seeds `docs/agents/`.
- The user is present. Phases 2, 3, and 5 need approvals. Do not run this skill AFK.

## Definition of done

The pass is complete when the ADR tree and the tracker agree:

- Every ADR follows `docs/agents/adr-format.md`. No numbered files remain.
- Every open issue cites live slugs, or left the tracker in the approved batch.
- Every accepted decision from the grill is one ADR file.
- Every gap has a home: a decision ticket or an issue.

"The project is scalable" is not the done condition. The later work makes the
project scalable. This pass aims that work.

## Phase 1 — Survey

Delegate the collection to subagents. Collect three inputs:

1. **Codebase map** — the modules, their boundaries, and their dependencies.
2. **ADR inventory** — one line per file in `docs/adr/`, in whatever format the
   file has: the decision, and a verdict — current, stale, or contradicted by the code.
3. **Tracker dump** — every open issue: title, labels, age, and each ADR it cites.

Merge the three inputs into one current-state brief. Show the brief to the user.
Do not propose changes in this phase.

## Phase 2 — Grill

Run `/grill-with-docs`, primed with the current-state brief. The session targets
the goal of the project and the decisions that support it. For each inventory line
with the verdict "stale" or "contradicted", ask: does the decision stand, evolve,
or die?

## Phase 3 — Rebaseline the ADRs

Apply the outcome of the grill to `docs/adr/`:

- A decision that stands: rewrite the file in the format of `docs/agents/adr-format.md`.
- A decision that evolves: rewrite the file with the new rule.
- A decision that dies: delete the file.
- A new decision: write a new file.

Show the user the full diff of `docs/adr/` before the commit. Put one `Superseded:`
trailer in the commit for each replaced or deleted decision.

## Phase 4 — Gap analysis

Compare the goal against the current-state brief, through the new ADRs. Write one
gap list. Classify each gap:

- **The way is not clear** — an open question blocks the work. Route it to
  `/wayfinder` as a decision ticket.
- **The work is clear** — route it to `/to-issues` as vertical slices. Cite the
  binding slugs in each issue.

## Phase 5 — Restructure the tracker

Run the garden pass of `/triage` with the new ADRs as the standard. In one approved
batch: retire dead issues, fold duplicates, requeue survivors with current slugs,
and file the new issues from phase 4.

File one more issue, first in the queue: "Repoint constraint lines to the new
slugs." The work is comment-only and behavior-safe. Label it `ready-for-agent`.

## Checks before you report done

1. Grep the tracker for slugs with no matching file in `docs/adr/`. Zero hits.
2. Read each file in `docs/adr/`. Each follows the template. Zero exceptions.
3. Read the gap list. Every line names a decision ticket or an issue.
