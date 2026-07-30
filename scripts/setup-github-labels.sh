#!/usr/bin/env bash
# Create the labels that the triage and wayfinder skills use.
# Run from inside the target repo. Requires gh CLI with auth.
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh CLI not found. Install it first." >&2
  exit 1
fi

label() {
  local name="$1" color="$2" desc="$3"
  gh label create "$name" --color "$color" --description "$desc" --force
}

# Triage roles
label "needs-triage"    "d93f0b" "A maintainer must evaluate this issue"
label "needs-info"      "fbca04" "Waiting on the reporter for more information"
label "ready-for-agent" "0e8a16" "Fully specified. An AFK agent can take it"
label "ready-for-human" "1d76db" "Needs human implementation"
label "wontfix"         "ffffff" "Will not be actioned"

# Wayfinder
label "wayfinder:map"       "5319e7" "A wayfinder map. Indexes one large effort"
label "wayfinder:research"  "bfd4f2" "Ticket resolves through reading. AFK"
label "wayfinder:prototype" "c2e0c6" "Ticket resolves through a cheap artifact. HITL"
label "wayfinder:grilling"  "f9d0c4" "Ticket resolves through conversation. HITL"
label "wayfinder:task"      "e4e669" "Manual work that unblocks a decision"

echo "Done. All labels are present."
