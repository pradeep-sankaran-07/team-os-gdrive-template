---
name: account-review
description: >
  Review one account end to end and produce the written view: how it is doing,
  what is at risk, and what the plan is. Use before a QBR or a renewal, when an
  account looks wobbly, or on a regular cadence for the accounts that matter.
  Triggers: "review the <account> account", "how is <account> doing", "prep for
  the <account> QBR", "is <account> at risk", "account review for <account>".
  NOT for the whole portfolio at once (use customer-dashboard). NOT for a
  prospect who has not bought (use solution-brief). NOT for writing up a single
  call (use customer-call-summary).
when_to_use: One account, in depth, when a human is about to act on it.
inputs:
  - accounts/<slug>/ in full: profile.md, summary.md, calls/, emails/, documents/
  - product/roadmap context for anything the account is blocked on
output_location: "accounts/<slug>/documents/account-review-<yyyy-mm-dd>.md"
owner: sam-okafor
status: PUBLISHED v1.0 (2026-09-16)
last_updated: 2026-09-16
---

# Account review

## Step 1 - Gather

Read the whole account folder, oldest to newest, so the direction of travel is
visible rather than just the current state. Note the date of the most recent
call and the most recent email: an account with no contact in two months is a
finding in itself.

## Step 2 - Infer health, do not ask for it

Health is **green**, **amber** or **red**, and it is inferred from evidence, not
hand-set. Say which evidence produced it.

| | Signal |
|---|---|
| green | using what they bought, contact is current, no open escalation |
| amber | adoption below plan, a blocker with no date, a champion who went quiet, a renewal inside 90 days with no conversation started |
| red | an open escalation, a stated intent to leave, or a commercial term we cannot meet |

If the evidence is thin, say the confidence is low. A confident amber and an
uncertain amber are different things to the person reading it.

## Step 3 - Write

1. **Health** - the rating, and the two or three facts behind it.
2. **Usage** - what they actually use, against what they bought.
3. **Results** - what they have got out of it, in their words where possible.
4. **Risks** - each with an owner and a next action. A risk with no action is a
   worry, not a risk.
5. **Expansion** - only where there is a real signal. Leave it empty rather than
   inventing one.

## Step 4 - Record

Write to `output_location`, refresh `accounts/<slug>/summary.md`, append one
line to `_ops/log.md`.

## Review before delivering (required)

- Every claim traces to a file in the account folder.
- The health rating and its evidence agree.
- Risks have owners and dates.
- A human has read it before it reaches the customer or leadership.

## Things that have gone wrong before

- **Never carry a health rating forward unexamined.** Why: a rating copied from
  last quarter's review looks like a fresh assessment and is trusted as one. If
  the evidence has not been re-read, the rating has not been made. (2026-09-16)
