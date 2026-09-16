---
name: solution-brief
description: >
  Create the Solution Brief: the decision document a prospect uses to decide
  whether to buy, with the business case behind it. Use after discovery, when a
  prospect needs something to evaluate and circulate internally.
  Triggers: "write a brief for <company>", "create a solution brief", "draft
  the decision document", "build the business case for <company>".
  BOUNDARY: this is the DECISION DOCUMENT and the BUSINESS CASE, the argument
  for buying. A priced list of what they get is a different document. A deal
  often needs both, produced separately. NOT for public marketing content (use
  acme-marketing) and NOT for an existing customer's review (use
  account-review).
when_to_use: A prospect is evaluating, and needs the written case.
inputs:
  - accounts/<slug>/ in full, especially the discovery calls
  - company/overview.md, company/market.md, product/overview.md
  - the dominant value angle, confirmed by a human
output_location: "accounts/<slug>/documents/solution-brief-<yyyy-mm-dd>.md"
owner: lena-vossen
status: PUBLISHED v1.0 (2026-09-16)
last_updated: 2026-09-16
---

# Solution brief

## Step 1 - Gather

Read the account folder, especially the discovery calls, and the three context
files above. Note the prospect's own words for their problem: the brief uses
their vocabulary, not ours.

## Step 2 - Choose the dominant value angle

**This is the step that decides whether the brief works.** See
`references/value-angles.md`. Pick exactly one angle and build the whole
document around it.

Do not hedge across three angles. A brief that argues everything argues nothing,
and the person who has to circulate it internally cannot summarise it in a
sentence. If two angles look equally strong, that means discovery is incomplete;
say so and ask, rather than including both.

**A human confirms the angle before you draft.** This is the judgment the skill
does not make.

## Step 3 - Draft

1. **The problem, in their words** - quoted or closely paraphrased from
   discovery, with the call it came from named.
2. **What changes** - what their operation looks like afterwards. Concrete, not
   adjectival.
3. **The case** - the numbers, each one traceable to an assumption stated on the
   page. An unsourced number in a decision document is worse than no number.
4. **How it lands** - what implementation actually involves, including what it
   asks of them. Understating this is how a deal closes and an onboarding fails.
5. **What we need from you** - the decision being asked for, and by when.

## Step 4 - Record

Write to `output_location`. Append one line to `_ops/log.md`. Note the chosen
angle in `accounts/<slug>/summary.md`, so the next person does not rediscover it.

## Review before delivering (required)

- One angle, carried all the way through.
- Every number has its assumption written next to it.
- Every claim about the prospect traces to a named call or document.
- Nothing in it that we would not say out loud to them.
- No em dashes. A human has read it end to end.

## Things that have gone wrong before

- **Lead with one angle, not three.** Why: a brief covering every possible
  benefit reads as a brochure and gets skimmed. The champion needs one sentence
  they can repeat to their own boss. (2026-09-16)
