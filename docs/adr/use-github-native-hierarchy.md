# Use GitHub native sub-issues and dependencies

**Scope:** repo-wide — the issue-tracker workflow in wayfinder, triage, and to-issues
**Rule:** Use the native GitHub parent-child and blocked-by links (`--parent`, `--blocked-by`, `--blocking`). Do not use body-text conventions.
**Why:** The frontier is visible in the GitHub UI without extra tools. The cost: the repo needs gh CLI >= 2.94.0. Older setups fall back to the label-and-body convention in each skill.
