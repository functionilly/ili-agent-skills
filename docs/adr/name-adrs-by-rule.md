# Name ADRs by their rule, not by a number

**Scope:** repo-wide — and every repo the skills configure
**Rule:** The filename of an ADR is its imperative rule, as a kebab-case slug. The tree holds only current decisions. Supersede by an edit in place, or by a delete and a replacement, with a `Superseded:` commit trailer. Git holds the history.
**Why:** A slug carries the rule; a number is a bare token that needs a lookup. Sequential numbers collide when parallel agents mint them, and status chains need constant pruning. The cost: filenames do not show order, and old rationale leaves the tree. Git supplies both on demand.
