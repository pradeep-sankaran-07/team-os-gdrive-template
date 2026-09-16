# Acme Outbound

**Demo content.** Fictional product, written to give the skills something real
to work with.

Seven modules. The first four are what a buyer sees; the last three are what
keeps them.

| # | Module | What it does |
|---|---|---|
| 1 | Lead sourcing and enrichment | Builds and enriches target lists from the customer's ICP definition |
| 2 | Sequencer | Runs email sequences. A second channel is specified, not shipped |
| 3 | Reply handling | Classifies every inbound reply and routes it |
| 4 | Meeting booking | Takes an interested reply through to a booked meeting |
| 5 | Deliverability guardrails | Warmup, domain health, per-mailbox caps. Alerts today; automatic pause is in progress |
| 6 | CRM sync | Two-way with the major CRMs; we never ask a customer to replace theirs |
| 7 | Analytics | Per-sequence and per-rep reporting |

## Where the roadmap lives

In the work tracker, queried live. See
[integrations/work-tracker.md](../integrations/work-tracker.md). Do not mirror
tracker content into files here: it goes stale within days and then two sources
disagree.

`product/prds/` holds the written specifications for work that is not yet built,
because a PRD is a document rather than a ticket. Anything with a status, an
assignee or a date belongs in the tracker instead.

## The three things in flight

Each is cross-referenced from at least one account, which is the point: product
work and customer pain should be traceable to each other in both directions.

- **Reply handling v2** - better objection classification. Calderwick Media's
  amber health traces to this.
- **Deliverability guardrails** - per-mailbox caps and automatic pause. Harlowe
  Security's evaluation turns on it.
- **Social multichannel** - the second channel in a sequence. Northwind
  Software's expansion depends on it, and it is Calderwick's stated blocker.
