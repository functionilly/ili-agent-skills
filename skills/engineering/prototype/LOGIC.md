# Logic prototype

A small interactive terminal app. The user drives a state model by hand. Use this branch
when the question is about business logic, state transitions, or data shape.
Such models look fine on paper and only feel wrong under real cases.

## When this is the right shape

- "Does this state machine handle the case where X, then Y?"
- "Can this data model represent the case where…?"
- "I want to feel out the API before I write it."
- Any time the user wants to press buttons and watch state change.

If the question is "what does it look like", use [UI.md](UI.md).

## Process

### 1. State the question

Before any code, write down the state model and the question. One paragraph, at the top
of the file or in the prototype's README. A prototype that answers the wrong question is
pure waste.

### 2. Select the language

Use the language of the host project. If the project has no obvious runtime, ask.
Do not add a new package manager or runtime for a prototype.

### 3. Isolate the logic in a portable module

Put the logic behind a small, pure interface that can move into the real codebase later.
The terminal shell around it is throwaway. The logic module is not.

Select the shape that fits the question:

- **A pure reducer** — `(state, action) => state`. For discrete events over a single value.
- **A state machine** — explicit states and transitions. For "which actions are legal now".
- **A set of pure functions** over a plain data type. For transformations without
  a current state.
- **A class with a clear method surface** — when the logic owns ongoing internal state.

Keep the logic pure: no I/O, no terminal code, no logs for control flow. The shell
imports the logic. Nothing flows the other direction.

### 4. Build the smallest terminal shell that shows the state

On every tick, clear the screen and render the whole frame. The user sees one stable
view, not growing scrollback. Each frame has two parts, in this order:

1. **The current state**, pretty-printed and diff-friendly. One field per line.
   Bold for field names, dim for secondary context. ANSI escape codes are sufficient.
2. **The keyboard shortcuts** at the bottom: `[a] add user  [d] delete user  [q] quit`.

Behavior: initialize the state, render the first frame, read one keystroke, dispatch to
a handler, re-render the full frame, loop until quit. The frame fits on one screen.

### 5. Make it one command

Add a script to the project's task runner. The user runs `pnpm run <name>` or the
equivalent. Without a task runner, put the command at the top of the README.

### 6. Hand it over

Give the user the run command. The interesting moments are "wait, that is not possible"
and "I assumed X". Those are the bugs in the idea — the whole point. Add new actions
when the user asks. Prototypes evolve.

### 7. Capture the answer

The answer is the only thing worth keeping. Ask the user what the prototype taught them.
If the user is away, leave a `NOTES.md` with the question and a placeholder.

## Anti-patterns

- **No tests.** A prototype with tests is no longer a prototype.
- **No real database.** In-memory only, unless persistence is the question.
- **No generalization.** No "what if we later want X". One question per prototype.
- **No blur between logic and shell.** A reducer that references the terminal is not
  portable.
- **No promotion of the shell.** The logic module is the keepable part. The shell dies.
