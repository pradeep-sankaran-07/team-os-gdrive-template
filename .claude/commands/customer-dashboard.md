---
description: Build or refresh the cross-portfolio customer dashboard.
---
Run the `customer-dashboard` skill at `.claude/skills/customer-dashboard/SKILL.md`. $ARGUMENTS may name a fresh data export to ingest first.

Two conditions are not negotiable: per-customer figures only, and never a company-wide total. Risk is reported as a share of the portfolio, never as an amount. If the revenue export is older than `revenue_stale_days`, suppress the derived risk bands and say the data is stale.

Boundary: a single account is `account-review`.
