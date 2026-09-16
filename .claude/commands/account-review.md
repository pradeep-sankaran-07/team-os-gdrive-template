---
description: Review one account end to end and write the account-review document.
---
Run the `account-review` skill at `.claude/skills/account-review/SKILL.md` for the account named in $ARGUMENTS.

Read the whole account folder before writing. Health is inferred from evidence and the evidence is named; never carry a rating forward unexamined. Every risk gets an owner and a date.

Output goes to `accounts/<slug>/documents/account-review-<yyyy-mm-dd>.md`, and `summary.md` is refreshed.

Boundary: the whole portfolio at once is `customer-dashboard`. A prospect who has not bought is `solution-brief`. A single call is `customer-call-summary`.
