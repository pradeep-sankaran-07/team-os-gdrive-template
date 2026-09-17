# markers

One **empty** file per session. All metadata is in the filename:

`<person-slug>__<YYYYMMDD>__<HHMM-utc>__<surface>.md`

Surface is `cowork`, `connector`, `claude-code` or `codex`.

Written by the assistant itself, per the "First action, every session" rule in
`CLAUDE.md`, because most surfaces cannot run a hook. It is batched with the
session's first tool call, never narrated, never retried, and fails silently.

**The file stays empty forever.** No content, ever, so no prompt, response or
customer data can ever land here.

Be clear-eyed about what that does and does not mean. The filename is the
payload: it records who worked, on what date, at what time. A folder listing is
therefore a record of everyone's working hours, evenings and weekends included.
There is no document content to review, and there is still personal data here.
See ACCESS-CONTROL.md, "What this measures about people".

**Some surfaces will never appear here, and that is expected.** A connector that
cannot create a `.md` file cannot write a marker either, so sessions on it leave
no trace. Record which products those are in `CONNECTOR-SURFACES.md`, and do not
go hunting for a file that was never written. It also means the adoption count
is a floor rather than a total, which is why the daily routine is forbidden from
reading an absent signal as absent work.

The daily admin routine rolls these into `../cowork@markers.csv`, deduping on
person and date, then trashes them. A marker whose filename will not parse stays
here and gets one log line, rather than being guessed at.

This README is never rolled up.

## Why create-only, rather than appending to a shared file

Most of the team works on a surface with no shell and, on a phone, file access
that can create but not edit. Dropping a new small file is the only write that
works everywhere, never conflicts on a synced drive, and needs no approval. A
daily routine folds them in. When you add a mechanism to this OS, copy this
shape.
