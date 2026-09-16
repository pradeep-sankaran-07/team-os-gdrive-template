# _sweep-state

One CSV per person, `<person-slug>.csv`, columns
`slug,first_swept_at,last_refresh_at`.

This is the **per-account** ingest window, and it is per person because each
person sweeps their own mailbox. It is the source of truth for whether an
account has been seeded; the table in `_ops/STATUS.md` is a view of it and loses
to it in a disagreement.

`first_swept_at` blank means the account has never had its all-time seed. The
routine writes each row **immediately after that account finishes**, not at the
end of the run, so a run that dies halfway still made progress and the next one
resumes at the first blank.

A churned account is swept weekly. When it is skipped, `last_refresh_at` is left
untouched on purpose, so the seven-day clock stays accurate.
