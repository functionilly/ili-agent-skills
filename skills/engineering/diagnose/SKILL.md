---
name: diagnose
description: Disciplined diagnosis loop for hard bugs and performance regressions. Reproduce, minimize, hypothesize, instrument, fix, regression-test. Use when the user says diagnose or debug, reports a bug, says something is broken or failing, or describes a performance regression.
---

# Diagnose

A discipline for hard bugs. Skip a phase only with an explicit reason.

During exploration, use the glossary vocabulary to build a mental model of the modules.
Check the ADRs in the area you touch.

## Phase 1 — Build a feedback loop

**This is the skill.** All else is mechanical. With a fast, deterministic, agent-runnable
pass/fail signal, you will find the cause. Without one, no amount of code-reading saves you.

Spend disproportionate effort here. Be aggressive. Be creative. Do not give up.

### Ways to construct a loop, in rough order

1. **A failing test** at whatever seam reaches the bug: unit, integration, e2e.
2. **A curl script** against a running dev server.
3. **A CLI invocation** with a fixture input. Diff stdout against a known-good snapshot.
4. **A headless browser script** (Playwright, Puppeteer). Assert on DOM, console, network.
5. **A replayed trace.** Save a real request or event log. Replay it through the code path.
6. **A throwaway harness.** Boot a minimal subset of the system. Exercise the bug path
   with one function call.
7. **A property or fuzz loop.** For "sometimes wrong output": run 1000 random inputs.
8. **A bisection harness.** If the bug appeared between two known states, automate
   "boot at state X, check, repeat" for `git bisect run`.
9. **A differential loop.** Run the same input through the old and the new version. Diff.
10. **A HITL bash script.** The last resort. If a human must click, drive the human with
    a structured script. The captured output feeds back to you.

Build the right loop, and the bug is 90% fixed.

### Iterate on the loop itself

Treat the loop as a product. Ask:

- Can it run faster? Cache the setup. Skip unrelated initialization. Narrow the scope.
- Can the signal get sharper? Assert on the specific symptom, not on "did not crash".
- Can it get more deterministic? Pin the time. Seed the RNG. Isolate the file system.

A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is
a superpower.

### Non-deterministic bugs

The goal is a higher reproduction rate, not a clean repro. Loop the trigger 100 times.
Parallelize. Add stress. Narrow the timing windows. A 50% flake is debuggable. A 1% flake
is not. Raise the rate until it is debuggable.

### When no loop is possible

Stop and say so. List what you tried. Then ask the user for one of these:

- Access to the environment that reproduces the bug
- A captured artifact: a HAR file, a log dump, a core dump, a recording with timestamps
- Permission for temporary production instrumentation

Do not hypothesize without a loop.

Do not start Phase 2 without a loop you believe in.

## Phase 2 — Reproduce

Run the loop. Watch the bug appear. Confirm:

- [ ] The loop shows the failure the user described, not a nearby different failure.
- [ ] The failure repeats across runs, or repeats often enough to debug against.
- [ ] You captured the exact symptom, so later phases can verify the fix.

Do not continue until you reproduce the bug.

## Phase 3 — Hypothesize

Generate 3 to 5 ranked hypotheses before you test any of them. A single hypothesis
anchors you on the first plausible idea.

Each hypothesis must be falsifiable. State its prediction:

> "If <X> is the cause, then <a change to Y> makes the bug disappear."

If you cannot state the prediction, the hypothesis is a vibe. Discard it or sharpen it.

Show the ranked list to the user before you test. The user often re-ranks it at once
("we deployed a change to #3 yesterday"). Do not block on the user. Continue with your
ranking if the user is AFK.

## Phase 4 — Instrument

Map each probe to one prediction from Phase 3. Change one variable at a time.

Tool preference:

1. **A debugger or REPL**, if the environment supports one. One breakpoint beats ten logs.
2. **Targeted logs** at the boundaries that separate the hypotheses.
3. Never "log everything and grep".

Tag every debug log with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup becomes one grep.

For performance regressions, logs are usually wrong. Establish a baseline measurement —
a timing harness, a profiler, a query plan — then bisect. Measure first. Fix second.

## Phase 5 — Fix and regression-test

Write the regression test before the fix — but only at a **correct seam**.

A correct seam exercises the real bug pattern as it occurs at the call site. If the only
seam is too shallow, a test there gives false confidence.

**If no correct seam exists, that is itself the finding.** Record it. The architecture
prevents a lock on this bug. Flag it for the next phase.

With a correct seam:

1. Turn the minimized repro into a failing test at that seam.
2. Watch it fail.
3. Apply the fix.
4. Watch it pass.
5. Re-run the Phase 1 loop against the original scenario.

## Phase 6 — Cleanup and post-mortem

Required before you declare the work done:

- [ ] The original repro no longer reproduces. Re-run the Phase 1 loop.
- [ ] The regression test passes, or the absent seam is documented.
- [ ] All `[DEBUG-...]` instrumentation is removed. Grep the prefix.
- [ ] Throwaway harnesses are deleted, or moved to a marked debug location.
- [ ] The correct hypothesis is stated in the commit or PR message.

Then ask: what would have prevented this bug? If the answer is architectural — no test
seam, tangled callers, hidden coupling — hand off to `/improve-codebase-architecture`
with the specifics. Make that recommendation after the fix, not before. You know more now.
