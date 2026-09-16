# Technical deep dive - Harlowe Security - 2026-09-08

**Attendees.** Harlowe: Nadia Shah (RevOps), Marcus Lindqvist (Demand Gen). Acme: Lena Vossen, Diego Ramirez.
**Type.** Technical evaluation.

## Objective

Answer the deliverability and control questions from discovery.

## Decisions

None taken by Harlowe. They will decide after their security review.

## Next steps

| Owner | Action | By |
|---|---|---|
| lena-vossen | Solution brief on the risk and control angle | 2026-09-18 |
| diego-ramirez | Confirm whether guardrails have a release date | 2026-09-18 |
| nadia-shah | Get the security reviewer into the next conversation | not committed to |

## Details worth keeping

- Priya asked the automatic-pause question again, in more detail: does it pause,
  or does it alert. Diego was straight that today it alerts and that automatic
  pausing is being built. She took that well; being told plainly seems to matter
  more to her than the answer being yes.
- She then asked whether the pause threshold would be tunable by the customer.
  Diego said that is an open question and that a fully tunable guardrail may not
  be a guardrail. She agreed with the reasoning, which is a good sign.
- Second account to ask about per-mailbox caps being configurable per rep.
- Marcus is ready to move. Priya is the brake, and she is being a reasonable one.
