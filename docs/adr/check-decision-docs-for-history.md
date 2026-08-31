# Check decision docs for history markers

**Scope:** repo-wide — and every repo the skills configure
**Rule:** After a write to `docs/adr/` or to the glossary, run the history check: the verbatim grep in the ADR format doc. Zero hits is the pass condition. Rewrite each hit as a current rule, or move the note to the commit message.
**Why:** Style guidance does not stop history prose: agents still record supersession as narrative that duplicates git history and rots. A verbatim grep is deterministic, and agents follow a command better than a style rule. The cost: a rare false positive, such as a current rule that names an external API version. Such a hit can stand.
