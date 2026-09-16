# outputs: your own working area

`outputs/<your-slug>/` is yours. Drafts, experiments, one-offs, half-finished
things, anything that is not ready for or not relevant to the rest of the team.

**Nothing here is authoritative.** Do not cite a colleague's `outputs/` folder as
a source, and do not expect yours to be read. The shared, trusted material lives
in the core folders.

## Where a finished thing belongs instead

| If it is about... | It goes to |
|---|---|
| one customer | `accounts/<slug>/documents/` or `calls/` |
| one partner | `partners/<slug>/` |
| the company or the product | `company/`, `product/`, or into the relevant skill |
| nothing in particular, or it is still in progress | here |

If something you made here turns out to be useful generally, move the substance
into the right core file or skill and leave this copy as a draft, or delete it.
The test is simple: would a colleague need it to do their job? Then it does not
belong in your scratch folder. Nothing at all belongs loose in the repo root.

## Your folder appears on its own

The slug comes from your work email, read from the Drive path you are working
in. You do not have to be listed anywhere first. If you are already in the
roster, that slug is used; if you are not, one is worked out from your name and
the folder is created the first time you save something. There is nothing to
request and no admin step. The overnight admin pass adds you to the roster
afterwards.

## About access, plainly

Everyone on the team can write anywhere under `outputs/`, including in your
folder. The per-person split is a convention, not a permission. A Shared Drive
grants access at the folder it is granted on, and cannot narrow it below that.

That is a deliberate trade, and it has one useful consequence: this is the one
place that is reliably writable for you, which is why the files below live here.
It has one uncomfortable consequence too, which the daily routine has to account
for: a skill you own and maintain here can be edited by anyone. See
`.claude/routines/daily-team-os-admin.md`, Task 4.

## Folders the system manages

Leave these alone unless the daily digest tells you otherwise.

- `outputs/_health/<user>@<host>.csv` - written by the session hook only when
  someone cannot write to `_ops/`. A row here means that person's access is
  broken. Usually this file does not exist at all.
- `outputs/<your-slug>/_health/` - notes a routine leaves when it could not
  finish writing something: a dated `*-blocked.md` plus `heartbeat.csv`,
  recording what failed and what still needs doing.
- `outputs/<your-slug>/_skills/<skill>/` - only if you maintain a skill. The
  daily routine promotes what you leave here. See `config.yaml` `skill_owners`.
