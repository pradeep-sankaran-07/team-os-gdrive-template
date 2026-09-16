# _ops

Operational files every routine writes to: `log.md`, the append-only history,
and `STATUS.md`, the current state.

**Why they are in a folder rather than at the root.** In a Shared Drive the
team's base role is Viewer. Ingestion runs under each person's own identity and
has to append to `log.md` and update `STATUS.md`. At a read-only root a save
cannot even create its temporary file, so those writes fail, confusingly. Moving
them into a folder the team can write to is what lets every person's routine
close out cleanly.

That is the whole reason this folder exists, and it is the clearest example in
the repo of the layout being derived from the permission model. See
[ACCESS-CONTROL.md](../ACCESS-CONTROL.md).

## What is here

| Path | What it is |
|---|---|
| `log.md` | Append-only. Newest at the bottom. One line per action. |
| `STATUS.md` | Current state: daily health, per-person sync, per-account freshness. |
| `sessions/` | The adoption metric. See its own README. |
| `skill-sync/` | State and backups for owner skill promotion. |
| `sync-skills.sh` | Mirrors skills for the second agent tool and regenerates the plugin manifest. |
| `sync-agents.sh` | Generates `AGENTS.md` from `CLAUDE.md`. |
| `scrub-check.sh` | Template-only publication gate. Adopters can delete it. |

## Rotation

When `log.md` passes about 5,000 lines or `STATUS.md` passes about 1,000, the
daily routine moves everything older than the current month into
`_ops/archive/<YYYY>/<MM>-log.md` and leaves a pointer. Unrotated, these grow
without limit and eventually cost more to read than they are worth.
