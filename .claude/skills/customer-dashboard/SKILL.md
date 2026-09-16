---
name: customer-dashboard
description: >
  Build or refresh the shared customer dashboard: one self-contained HTML file
  covering every onboarding and live customer, with health, order or usage
  trends, blocked work and a per-owner summary. Creates it if it does not
  exist, updates it if it does.
  Triggers: "refresh the customer dashboard", "which clients are off track",
  "what are the red flags this week", "which accounts should I focus on",
  "I have a new revenue export", "update the client health dashboard".
  NOT for a single account's status (use account-review). NOT for a
  customer-facing report. NOT for writing up a call.
when_to_use: The cross-portfolio view, on a schedule or when fresh data arrives.
inputs:
  - accounts/ summaries and profiles
  - the crosswalk and value export named in config.yaml customer_dashboard
  - the live work tracker, for blocked items
output_location: "config.yaml customer_dashboard.output, plus a dated snapshot in .snapshots"
owner: tobias-frank
status: DRAFT
last_updated: 2026-09-16
---

# Customer dashboard

The only place in this OS where per-customer values sit side by side. That is a
deliberate, named exception to the confidentiality rule, and it comes with two
conditions that are not negotiable:

1. **Per-customer figures only.**
2. **Never a company-wide total.** A sum across all customers is company
   revenue, which stays out of every file including this one. Report risk as a
   **share of the portfolio**, never as an amount.

The exception covers `portfolio/` and no other path.

**Every path in this skill comes from `config.yaml` `customer_dashboard`.** Read
that block first and use `output`, `crosswalk`, `revenue_csv`, `revenue_meta`,
`snapshots` and `raw_drops` as written there. Do not hardcode a folder name: the
installer invites companies to rename these folders to their own vocabulary, and
a hardcoded path silently writes to the old one.

## Step 1 - Check the data, before using it

Read the file named in `revenue_meta`. If the export is older than
`config.yaml` `customer_dashboard.revenue_stale_days`, **suppress every derived
risk band rather than showing a stale one**, and say on the page that the data
is stale and how old it is. A dashboard that silently shows last quarter's
numbers as this quarter's is worse than one that shows nothing.

Every data drop keeps a `.meta.json` sidecar next to it recording
`source_file`, `exported_at`, `exported_by`, `normalised_at_utc`, row counts,
the period covered, rows dropped, and any assumption that is not confirmed
(`currency_assumed`, `currency_confirmed: false`). Write the uncertainty down;
do not resolve it silently.

## Step 2 - Reconcile entities

The `crosswalk` file maps one customer across every system: account folder slug,
display name, owner, tracker projects, roster status, renewal date, tier.

Rows that are deliberately out of scope are **kept**, prefixed `_excluded_`, with
a written `exclude_reason`. Nothing is ever silently dropped, because a customer
that vanishes from the dashboard looks identical to one that was never there.

Where two systems disagree, record the disagreement in a `conflicts` list rather
than picking a winner in code.

## Step 3 - Build

One self-contained HTML file. Inline CSS and JS, no external calls, so it opens
from a Drive folder and from the Apps Script viewer alike.

**Escape every value that came from account content.** Account summaries are
condensed from ingested email by a model, so their text is attacker-influenced:
a customer name or a note containing a `<script>` tag would otherwise execute in
the browser of everyone who opens the dashboard. Escape `&`, `<`, `>` and `"` in
every interpolated value, put the data in a JSON island rather than building
HTML strings, and add a restrictive `Content-Security-Policy` meta tag. Numbers
from the value export are escaped too; they come from a spreadsheet a human
edited. Apply `acme-brand`
tokens for colour and type; charts use the brand palette, never a rainbow.

Sections: a portfolio summary, accounts off track, trends, blocked work, per-owner
view, and a **data health** tab showing every source's age and every unresolved
assumption.

Write a dated snapshot to `snapshots`, and prune per
`config.yaml` `customer_dashboard.snapshot_retention`. Bump `scoring_version`
whenever the scoring changes, so old snapshots are not read as comparable.

## Step 4 - Share it

Google Drive's web preview does not run JavaScript, so a plain Drive link to
this file renders blank. `apps-script/serve-dashboard.gs` is a ten-line Web App
that serves it at a stable internal URL. Content changes need no redeploy.

## Step 5 - Before anyone else can open it

The Apps Script viewer bypasses the Drive permissions: whoever can open the URL
sees this file with the deployer's access. Deploy it to the named group in
`config.yaml` `customer_dashboard.apps_script.audience_group`, never to the
whole organisation, and have someone outside the group confirm they are blocked.

## Non-negotiables

- No company-wide total, ever.
- Never show a derived risk band on stale data. Suppress it and say why.
- Never delete an excluded row; keep it with a reason.
- Escape every account-derived value before it reaches the page.
- Never widen the Apps Script audience to the whole organisation.
