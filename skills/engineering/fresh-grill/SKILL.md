---
name: fresh-grill
description: Run a fresh-eyes architecture grill - launch an interviewer agent that holds only the app line and a question guide, relay its questions to the user verbatim, and return a target-architecture report. Use when the user asks for a fresh-eyes architecture review, and inside sys-design-review or found-project when they reach their grill phase.
---

# Fresh Grill

Define the target architecture from first principles. A fresh interviewer
holds only the app line, so it carries no assumption from the current
structure, the current stack, or the session so far.

The user must be present. The output is the interviewer's report. The skill
that invoked this one owns what happens to the report.

## Steps

1. **Write the app line.** Ask the user for one or two sentences: what the
   application is, and for whom. Confirm the wording with the user.
2. **Launch the interviewer.** Start a fresh agent on the strongest model
   available (in Claude Code: an Opus subagent). Give it the app line and
   [INTERVIEWER.md](./INTERVIEWER.md). Give it nothing else: no brief, no
   ADRs, no code, no stack.
3. **Relay.** Pass each question to the user verbatim, one at a time. Pass
   each answer back verbatim. The interviewer probes vague answers with the
   guide; you add nothing in either direction.
4. **Return the report.** The interviewer's final message is the report: the
   target architecture and its open risks. Hand it to the skill that invoked
   this one, or to the user when invoked directly.

When the agent cannot run subagents, run the interview yourself from
[INTERVIEWER.md](./INTERVIEWER.md). Ask each question before you form your
own answer from the code.

## Routing the report

- Inside `/sys-design-review`: phase 6 compares the report with the ADR tree.
- Inside `/found-project`: the report becomes the founding decision record.
- Invoked directly: show the report. Offer `/grill-with-docs` for each
  decision the user accepts, and `/to-issues` for each open risk.
