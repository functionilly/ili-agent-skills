# Use GitHub native sub-issues and dependencies

Wayfinder and triage need parent-child links and blocked-by links between issues.
GitHub supports both natively, and GitHub CLI 2.94.0 (June 2026) exposes them as flags
(`--parent`, `--blocked-by`, `--blocking`) and as JSON fields. We use the native features
instead of body-text conventions. The benefit: the frontier is visible in the GitHub UI
without extra tools. The cost: the repo needs gh CLI >= 2.94.0. Older setups can fall back
to the label-and-body convention described in each skill.
