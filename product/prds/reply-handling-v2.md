# PRD: Reply handling v2

Status: specified, not started. Owner: Diego Ramirez. Last updated 2026-09-10.

## Problem

Replies are classified into four buckets, and the objection bucket is a single
undifferentiated pile. A rep opening it has to read everything anyway, which is
the work the product was supposed to remove. Two customers have said this in
almost the same words.

## Goals

- Objections are classified by kind: price, timing, incumbent, authority, fit.
- Each kind routes differently, and the routing is configurable per customer.
- Classification confidence is exposed, so a rep knows when to look themselves.

## Non-goals

- Drafting the response. That is a separate decision and a separate risk.
- Changing the four top-level buckets.

## Requirements

1. Five objection sub-kinds, extensible without a release.
2. A confidence score on every classification, shown in the inbox.
3. Anything below the confidence threshold routes to a human, unclassified,
   rather than being guessed into a bucket.
4. Per-customer routing rules per sub-kind.

## Success metrics

- Median time from reply received to reply actioned.
- Share of objections a rep re-classifies by hand, which should fall.

## Open questions

- Does the threshold need to be per customer, or is one default enough?
- Do we expose sub-kinds in the analytics module in this release, or later?

## Who is waiting on it

Calderwick Media. See `accounts/calderwick-media/summary.md`.
