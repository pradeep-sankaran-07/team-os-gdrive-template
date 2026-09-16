# Checklist format

`INSTALL-CHECKLIST.md` at the repo root is the live checklist. **This file does
not duplicate it**, deliberately: two copies of the same table diverge the first
time anyone edits either one. If the checklist is missing, rebuild it from the
phases in `SKILL.md` using the rules below.

## Row format

One row per step, in a table per phase:

`| status | step | owner | verified by |`

`status` is exactly one of: `todo`, `in progress`, `done`, `skipped (reason)`.

`verified by` names the probe from `verification.md`, not a description of the
work. A step is done when its probe passes, never when someone says they did it.

## Header fields, and when to fill them

At the top of the file:

- `**Company:**` and `**Shared Drive:**` - after Phase 1.
- `**Admin runner:**` - after Phase 5, from `config.yaml` `admin.runner`.
- `**Last checked:**` - set to today's UTC date every time you run the probes,
  whether or not anything passed. A stale date is itself information.

## Notes

The `## Notes` section at the bottom takes one bullet per entry:

`- <YYYY-MM-DD>: <what happened, in one sentence>`

Write there when a step is skipped and why, when a probe failed and what was
observed, and for the Phase 0 answers about lawful basis and consultation.

## What never to do

Do not tick a row and add a caveat beside it. The next person reads the tick.
Leave it `todo` or `in progress`, and put the caveat in Notes.
