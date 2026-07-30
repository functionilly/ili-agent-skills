---
name: wayfinder
description: Plan work that is too large for one agent session as a shared map of decision tickets on the issue tracker. Resolve the tickets one at a time until the way to the destination is clear. Use when the user has a large loose idea, wants to chart a map, or wants to work through an existing map.
---

# Wayfinder

A loose idea arrives. It is too large for one agent session, and the way to the
**destination** is not visible yet. Do not charge at the destination. Chart the way
as a **shared map** on the repo's issue tracker. Then work its **decision tickets**
one at a time, until the route is clear.

The destination varies per effort. Name it first — it shapes every ticket.
A destination can be a spec to hand off, a decision to lock, or a change made in place.
The map is domain-agnostic. Engineering work and content work both fit.

## Plan, do not do

Wayfinder is planning by default. Each ticket resolves a decision. The map is done when
nothing is left to decide, and someone can go and do the thing. When you feel the pull
to do the work, you are at the edge of the map. That is the signal to hand off.
The map's **Notes** section can override this default. Without an override,
produce decisions, not deliverables.

## Refer by name

Every map and ticket is an issue, so it has a name — its title. In everything the human
reads, use the name, never a bare number. A wall of `#42, #43, #44` is not legible.
Wrap the link inside the name. The number rides inside the name, never in place of it.

## The map

The map is one issue with the label `wayfinder:map`. It is the canonical artifact.
Its tickets are child issues of the map.

The map is an **index**, not a store. A decision lives in exactly one place: its ticket.
The map holds a one-line gist and a link, nothing more. Open tickets are not listed in
the map body. Find them by query.

The physical operations — children, blocking, claims, and the frontier query — are
tracker-specific. Read the repo's tracker doc (`docs/agents/issue-tracker.md`).
Run `/setup-skills` if it is absent. For GitHub, the exact commands live in
[GITHUB-OPERATIONS.md](./GITHUB-OPERATIONS.md). Without a tracker, use the local
markdown convention.

### The map body

```markdown
## Destination

<What the end of this map looks like. One or two lines. Each session orients to it first.>

## Notes

<The domain. The skills each session must consult. Standing preferences for this effort.>

## Decisions so far

<!-- The index. One line per closed ticket. -->

- [<closed ticket title>](link) — <one-line gist of the answer>

## Not yet specified

<!-- In-scope fog that cannot be a ticket yet. See "Fog of war". -->

## Out of scope

<!-- Work ruled beyond the destination. It never graduates. -->
```

### Tickets

Each ticket is a child issue of the map. The body is one question, sized to one
agent session:

```markdown
## Question

<the decision or investigation this ticket resolves>
```

Each ticket carries one `wayfinder:<type>` label: `research`, `prototype`, `grilling`,
or `task`.

A session **claims** a ticket before any work: assign the ticket to yourself.
The assignee is the claim. An open, unassigned ticket is unclaimed.

Blocking uses the tracker's native dependency relation. Native blocking renders the
frontier in the tracker's own UI, so the human sees what is takeable without the map.
A ticket is **unblocked** when every blocker is closed. The **frontier** is the set of
open, unblocked, unclaimed children.

The answer is not part of the ticket body. Record it at resolution, as a comment.
Link assets from the ticket. Do not paste them in.

## Ticket types

A ticket is **HITL** (a human speaks for themselves in the loop) or **AFK** (the agent
works alone). A HITL ticket resolves only through the live exchange. Never answer the
human's side of a HITL ticket yourself.

- **Research** (AFK): read documentation, APIs, or knowledge bases to surface a fact
  that a decision waits on. Resolve with a research subagent.
- **Prototype** (HITL): make a cheap concrete artifact to react to. Use the `/prototype`
  skill. Link the artifact as an asset. Use when "how does it look" or "how does it
  behave" is the question.
- **Grilling** (HITL): conversation through `/grill-with-docs`, one question at a time.
  This is the default type.
- **Task** (HITL or AFK): manual work that must happen before a decision is possible.
  Examples: sign up for a service, provision access, move data. This type does rather
  than decides. It earns its place because it unblocks a decision. The agent does it
  alone where it can. Otherwise, hand the human a precise checklist. The resolution
  records what was done, and the facts that later tickets need.

## Fog of war

The map is incomplete on purpose. Do not chart what you cannot see. Beyond the live
tickets lies the fog: decisions you can feel ahead, but cannot pin down yet.
Each resolution clears some fog. Graduate the cleared fog into fresh tickets.

Write the fog in the **Not yet specified** section: the suspected question, the area
to revisit. Everything there is in scope, but not sharp enough to be a ticket.

**Fog or ticket?** The test: can you state the question precisely now? The answer does
not matter, only the question.

- **Ticket** when the question is sharp — even when it is blocked.
- **Fog** when you cannot phrase it sharply. Do not pre-slice the fog into ticket-size
  pieces. One patch of fog can graduate into several tickets, or none.

## Out of scope

The destination fixes the scope. Work beyond the destination is out of scope.
It is not fog, and it never graduates. Record it in the **Out of scope** section:
the gist, and why it is out.

When an existing ticket turns out to sit past the destination, close it. Add one line
to **Out of scope** with a link to the closed ticket. Do not add it to **Decisions so far** —
that section records the route walked, and a scope boundary is not a step on it.

## Invocation

Two modes. In both modes, resolve at most one ticket per session. Research tickets
are the exception — they can run in parallel.

### Chart the map

The user invokes with a loose idea.

1. **Name the destination.** Run a `/grill-with-docs` session. Pin down what this map
   finds its way to. The destination fixes the scope, so settle it first.
2. **Map the frontier.** Grill again, breadth-first. Fan out across the whole space.
   Surface the open decisions and the first takeable steps. If no fog appears, the
   journey fits in one session. Stop and ask the user how to continue.
3. **Create the map** with the label `wayfinder:map`. Fill in Destination and Notes.
   Leave Decisions-so-far empty. Sketch the fog into Not-yet-specified.
4. **Create the tickets you can specify now** as child issues. Then wire the blocking
   edges in a second pass — issues need identifiers before they reference each other.
5. **Start the research subagents.** For each `research` ticket, start a subagent to
   resolve it in parallel. Capture findings on a throwaway `research/<name>` branch,
   with a pointer from the ticket.
6. Stop. To chart is one session's work. Do not resolve tickets in the same session.

### Work through the map

The user invokes with a map (URL or number). A ticket argument is optional.

1. Load the map body. Do not load every ticket.
2. Select the ticket. If the user named one, take it. Otherwise take the first frontier
   ticket. Claim it: assign it to yourself before any work.
3. Resolve it. Zoom as needed: fetch related or closed tickets on demand. Invoke the
   skills that the map's Notes section names. When in doubt, use `/grill-with-docs`.
4. Record the resolution: post the answer as a comment, close the ticket, and append
   one index line to the map's Decisions-so-far.
5. Update the map: create newly visible tickets (create, then wire). Graduate fog that
   the answer made sharp. Remove each graduated patch from Not-yet-specified. If the
   answer shows that a ticket sits past the destination, rule it out of scope. If the
   decision invalidates other tickets, update or delete them.

Other sessions can edit the tracker at the same time. Expect concurrent changes.
