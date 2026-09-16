---
description: Summarise a customer call into that account's calls/ folder.
---
Run the `customer-call-summary` skill at `.claude/skills/customer-call-summary/SKILL.md` for the call in $ARGUMENTS.

Resolve the account from the roster first; if it is not on the roster, stop and ask rather than creating a folder. Append, never overwrite: a call is always a new file. Merge what changed into `summary.md` after reading it, do not regenerate it.

Boundary: internal meetings do not belong in an account folder. A partner call files under `partners/` and cross-posts anything customer-relevant.
