---
name: to-issues
description: Break a plan, spec, or PRD into independent issues on the project issue tracker, cut as vertical slices. Use when the user wants to convert a plan into issues or break down work.
---

# To Issues

Break a plan into issues that anyone can take independently. Cut the plan into
vertical slices.

The issue tracker and the triage labels come from the repo configuration.
Run `/setup-skills` if they are absent.

## Process

### 1. Gather context

Work from the conversation. If the user passes an issue reference, fetch it from the
issue tracker. Read the full body and the comments.

### 2. Explore the codebase

Explore the codebase if you have not. Use the glossary vocabulary in titles and
descriptions. Respect the ADRs in the area you touch. List the ADRs that bind each slice.

### 3. Draft the vertical slices

Each issue is one thin vertical slice. A slice cuts through all layers, end to end.
A slice is not a horizontal cut of one layer.

Mark each slice HITL or AFK. A HITL slice needs human interaction, such as a design
review. An AFK slice can be built and merged without a human. Prefer AFK.

Slice rules:

- Each slice delivers a narrow but complete path through every layer: schema, API, UI, tests.
- A completed slice is demoable or verifiable on its own.
- Prefer many thin slices over few thick slices.

### 4. Quiz the user

Present the breakdown as a numbered list. For each slice, show:

- **Title**: a short descriptive name
- **Type**: HITL or AFK
- **Blocked by**: the slices that must complete first, if any
- **User stories covered**: from the source material, if present

Ask the user:

- Is the granularity right?
- Are the dependencies correct?
- Must any slice merge or split?
- Are the HITL and AFK marks correct?

Iterate until the user approves.

### 5. Publish the issues

Publish one issue per approved slice. Use the template below. Apply the `needs-triage`
label. Publish in dependency order, blockers first, so the "Blocked by" fields can
reference real issue identifiers. On GitHub, also wire the dependency natively:
`gh issue edit <n> --add-blocked-by <m>`.

<issue-template>

## Parent

A reference to the parent issue, if the source was an issue. Otherwise omit this section.

## What to build

A concise description of this slice. Describe the end-to-end behavior, not the layers.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- A reference to the blocker, or "None — can start immediately".

## Constraints
- ADR-NNNN — the local rule in one line. Omit this section when no ADR binds the slice.

</issue-template>

Do not close or modify the parent issue.
