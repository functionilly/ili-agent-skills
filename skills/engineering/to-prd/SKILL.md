---
name: to-prd
description: Turn the current conversation into a PRD and publish it to the project issue tracker. Use when the user wants a PRD from the current context.
---

# To PRD

Turn the current conversation and codebase understanding into a PRD. Do not interview
the user. Synthesize what you already know.

The issue tracker and the triage labels come from the repo configuration.
Run `/setup-skills` if they are absent.

## Process

1. Explore the repo if you have not. Use the glossary vocabulary in the whole PRD.
   Respect the ADRs in the area you touch.

2. Sketch the modules you will build or modify. Look for chances to extract deep modules —
   modules with much function behind a small, stable, testable interface.
   Confirm the modules with the user. Confirm which modules get tests.

3. Write the PRD with the template below. Publish it to the issue tracker.
   Apply the `needs-triage` label, so the PRD enters the normal triage flow.

<prd-template>

## Problem statement

The problem, from the user's point of view.

## Solution

The solution, from the user's point of view.

## User stories

A long, numbered list. Each story has this format:

1. As an <actor>, I want <a feature>, so that <a benefit>.

Cover all parts of the feature.

## Implementation decisions

A list of the decisions made. Include:

- The modules to build or modify
- The interfaces of those modules
- Architectural decisions
- Schema changes
- API contracts

Do not include file paths or code snippets. They go stale fast.

Cite the ADRs that bind the solution, each with its local rule in one line.

## Testing decisions

- What makes a good test here: test external behavior, not implementation details.
- Which modules get tests.
- Prior art: similar tests in the codebase.

## Out of scope

The things this PRD does not cover.

## Further notes

Any other notes.

</prd-template>
