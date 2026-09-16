# PRD: Social multichannel sequencing

Status: specified, not started. Owner: Diego Ramirez. Last updated 2026-09-11.

## Problem

Sequences are email only. Customers ask for a second channel constantly, and two
deals are explicitly waiting on it. It is also the most commonly cited reason a
prospect picks a competitor.

## Goals

- A sequence can include social steps alongside email steps.
- Social is the second channel: it supplements the email sequence rather than
  running its own parallel one.
- Per-channel limits are respected and visible.

## Non-goals

- Automating connection requests at volume. We will not build something whose
  best use is against a platform's terms.
- Social-only sequences in this release.

## Requirements

1. Social steps in the sequence builder, with their own timing rules.
2. Per-day per-account limits, conservative by default.
3. Replies on either channel collapse into one thread in reply handling.
4. Analytics splits by channel.

## Success metrics

- Reply rate of multichannel sequences against email-only, same accounts.
- Number of accounts that enable a social step within 30 days of release.

## Open questions

- How do we handle a prospect who replies on both channels at once?
- Does the per-day limit belong to the mailbox, the rep or the customer?

## Who is waiting on it

Northwind Software, for expansion. Calderwick Media names it as their blocker.
See both accounts' `summary.md`.
