# sessions - the adoption metric

Answers three questions per person: **who they are**, **how many sessions** they
run, and **what kind of work** they do here, so the team can see who is getting
value and who is quietly stuck.

## What is recorded

One row per event, metadata only:

| Column | Meaning |
|---|---|
| `ts_utc` | timestamp, UTC |
| `event` | `session`, `skill`, or `write-blocked` |
| `detail` | for a session: `startup` or `resume`. For a skill: the skill name. For a marker row: the surface. |
| `drive_account` | the person's work Google account. This is the **who**, and it maps to `config.yaml` `people`. |
| `person` | the display name from the machine |
| `user_host` | `<os-user>@<host>`, the machine. Literally `cowork` for marker rows. |
| `session_id` | the session id, or the marker filename stem |

**No content is ever captured.** Not prompts, not responses, not file contents,
not file paths, not session titles, not customer data. `detail` is only ever a
fixed keyword or a skill name. Nothing confidential is logged by construction,
so nothing ever needs redacting.

## Two paths, because hooks only work on some surfaces

**The hook path** (CLI surfaces). Two hooks in `.claude/settings.json` and
`.codex/hooks.json`, both running `log-session.sh`:
`SessionStart` writes a `session` row, and `PreToolUse` matched to the `Skill`
tool writes a `skill` row. Every other tool is ignored. It runs silently and
always exits 0. Depending on the client and its settings, the first run may ask
the person to approve the hook.

Each machine appends to its **own** file, `<user>@<host>.csv`, so concurrent
writes on a synced drive never conflict. Aggregate by reading them all.

**The marker path** (every surface, including the hooked ones). The rulebook
instructs the assistant to create ONE **empty** file per session in `markers/`.
All metadata is in the filename. The daily admin routine folds markers into
`cowork@markers.csv` here and trashes them.

The `@` in every filename is required, not decorative: the readers glob
`*@*.csv`, so the marker rollup is counted alongside the per-machine files
without any extra wiring.

**Every surface writes a marker, including the ones with hooks.** It is tempting
to exclude the CLI surfaces on the grounds the hook covers them. A hook only
fires on a machine that has it installed, and excluding the hooked surfaces
erases the recorded activity of everyone without one, and the people affected
read as completely inactive while doing a full week's work. A duplicate costs nothing, because
the rollup dedupes to one active day per person per date.

## It doubles as an access canary

`_ops/` is writable by the whole team, so a successful `session` row here also
proves that person can write to `_ops/`. The first time anyone opens the folder,
the team learns whether their access works, with no ingest run needed.

If the write fails, the hook writes a `write-blocked` row to
`outputs/_health/<user>@<host>.csv` instead, which is always writable. That row
is the **only** signal that positively means someone's access is broken. The
daily digest reads both.

## Reading it

Run `.claude/hooks/session-report.sh` from the repo root, or:

```
cat _ops/sessions/*@*.csv 2>/dev/null | awk -F, '$2=="session"{print $4}' | sort | uniq -c | sort -rn
cat _ops/sessions/*@*.csv 2>/dev/null | awk -F, '$2=="skill"{print $4"  "$3}' | sort | uniq -c | sort -rn
```

## Caveats, which matter more than the numbers

- **Scheduled routine runs are included.** They start sessions too. They rarely
  produce `skill` rows, so `skill` rows are the better proxy for hands-on work.
  Separate the two by their fixed daily clock time.
- **Marker rows are a floor, not an exact count.** Markers are instruction
  driven, so an occasional session skips one. Hook rows are deterministic.
  Compare people on the same surface with that in mind.
- **Absence of a row proves nothing.** Someone who only reads the OS leaves no
  trace any of this can count. A low number means "wrote little", never "got no
  value", and the digest is required to say so.
- **Forward only.** No backfill. History before the first synced session was
  never stored anywhere.
