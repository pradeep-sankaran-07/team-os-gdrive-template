# PRD: Deliverability guardrails

Status: in progress. Owner: Diego Ramirez. Last updated 2026-09-08.

## Problem

A domain gets flagged, and the first anyone knows is that reply rates collapsed
two weeks ago. By then the damage takes a quarter to undo. Every customer who
has been through it asks the same question in the next renewal conversation.

## Goals

- Detect the signals that precede a flag, not the flag itself.
- Act automatically. Pause the mailbox, do not send an alert.
- Make the pause and its reason visible, so nobody thinks the product broke.

## Non-goals

- Managing the customer's DNS for them.
- Guaranteeing deliverability. We reduce the chance and shorten the recovery.

## Requirements

1. Per-mailbox daily caps, defaulted by mailbox age.
2. Warmup schedule for a new domain or mailbox.
3. Continuous domain health monitoring.
4. Automatic pause when spam signals cross a threshold, with the reason recorded
   and surfaced in the UI and by email to the admin.
5. A clear, deliberate resume action. Never resume by itself.

## Success metrics

- Number of flagged domains per customer per quarter.
- Time from first adverse signal to pause.

## Open questions

- Should the threshold be tunable by the customer, or is a tunable guardrail not
  a guardrail?

## Who is waiting on it

Harlowe Security's evaluation. See `accounts/harlowe-security/summary.md`.
