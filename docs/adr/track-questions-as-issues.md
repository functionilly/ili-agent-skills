# Track open questions as plain issues

**Scope:** repo-wide — and every repo the skills configure
**Rule:** An open question is one issue: labeled `ready-for-human`, a child of the effort's parent issue, wired with `blocked-by` links. A grill session resolves it. The resolution is an ADR, new slices, or both. Do not build a separate map or ticket apparatus.
**Why:** Decisions stored in the tracker rot: a resolution in a closed issue sits outside the ADR read path, and a separate planning apparatus overlooks the issues that already exist. Native parent and blocker links give the same overview for free. The cost: no guided work queue; the unblocked children of the parent serve that role.
