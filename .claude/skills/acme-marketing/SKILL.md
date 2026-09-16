---
name: acme-marketing
description: >
  How Acme Corp writes publicly and what it is allowed to claim. Use when the
  output will be READ BY SOMEONE OUTSIDE THE COMPANY as Acme's own marketing or
  public communication, whatever the format: blog post, landing or comparison
  page, press release, social copy, email campaign, ad copy, case study,
  brochure, whitepaper, video script, event collateral. Also use to check
  whether a claim is cleared to publish.
  Triggers: "write a blog post about...", "draft a landing page", "write the
  copy for...", "a comparison page vs <competitor>", "write a case study", "is
  it OK to say that we...", "how do we position...".
  NOT for internal material however polished: roadmaps, status reports,
  internal decks, ops dashboards, board material are acme-brand alone. NOT for
  a prospect decision document (use solution-brief) or a call write-up (use
  customer-call-summary).
when_to_use: Any output an outsider will read as Acme speaking for itself.
inputs:
  - the brief or topic
  - company/market.md, company/overview.md, product/overview.md
  - references/claims.md
output_location: "outputs/<person-slug>/ until approved, then wherever it is published from"
owner: maya-chen
status: PUBLISHED v1.0 (2026-09-16)
last_updated: 2026-09-16
---

# Acme marketing

This skill is mandatory by **audience**, not by format. Ask one question: will
someone outside the company read this as Acme speaking for itself? If yes, this
applies, whatever it is. If it is internal, it does not apply however polished
the document is.

Format and audience are separate questions. Answer both: `acme-brand` almost
always runs alongside this one.

## Step 1 - Establish the audience

If you cannot tell whether the output is internal or public, **ask one short
question** before writing. Guessing wrong in either direction is expensive: an
internal doc run through a marketing pass reads like a press release to your own
team, and a public page written without one makes claims nobody cleared.

## Step 2 - Check every claim against references/claims.md

That file is the list of what Acme may say in public, each claim paired with its
basis. The rules:

- A number may be published only if it is in that file, and it is published with
  the comparison basis it was measured against. A number without its basis is
  not a claim, it is a shape.
- A customer may be named only where `accounts/<slug>/profile.md` records
  permission.
- Competitors are described by capability, never by characterisation. "Their
  product does not do X" needs a source; "they are worse at X" is not publishable.
- If a claim you want is not in the file, write the copy without it and list it
  under "not cleared" for a human to decide. Do not soften an uncleared claim
  into a vaguer version of itself and publish that.

## Step 3 - Write

House voice: plain, specific, short sentences. Say what the product does and for
whom. No superlatives, no "revolutionary", no invented urgency. Rule 0 applies
with full force here, because marketing copy is where mannered prose hides best.

Structure any page as: the problem in the reader's words, what Acme does about
it, the proof, what to do next.

## Step 4 - Record

File the draft to the author's `outputs/` folder. Add one line to `_ops/log.md`.
Public copy is never published straight from a skill run.

## Review before delivering (required)

- Every number traces to `references/claims.md` with its basis.
- Every named customer has recorded permission.
- No competitor is characterised, only described.
- No em dashes.
- A human has read it end to end and approved publication.

## Things that have gone wrong before

- **Never publish a number without its comparison basis.** Why: a figure quoted
  bare invites the reader to assume the most flattering baseline, and the first
  prospect who asks "compared with what" gets an answer that undercuts the
  claim. (2026-09-16)
