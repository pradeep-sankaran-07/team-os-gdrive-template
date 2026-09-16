# Access control

Two groups, and the folder layout follows from them. This page explains why the
directory tree looks the way it does, because the reason is not tidiness.

## The two groups

Grant roles through Google Groups on the Shared Drive, never to individuals. The
machine-readable copy of this model is `config.yaml` `permissions`.

| Group | Role | What it means |
|---|---|---|
| `acme-os-team@` | **Viewer** everywhere, upgraded to **Content Manager** on `accounts/`, `outputs/` and `_ops/` | Everyone. Can read the whole OS, and can write only in the three working folders. Can trash within them, never purge. |
| `acme-os-admins@` | **Manager** on the whole drive | A small group. The only role that can write root files, `.claude/`, `company/`, `product/`, `integrations/`, `partners/` and `portfolio/`, and the only role that can permanently delete. |

Adding a new joiner to the team group is the **only manual step** in onboarding.
Do it before you send them `START-HERE.md`, so their very first session can
write. Everything else derives itself: their `outputs/` folder is created from
their session, and the daily admin routine folds them into the roster.

## Why the layout is what it is

In a Shared Drive the team's base role is read-only. At a read-only path a save
cannot even create its temporary file, so a write there does not fail cleanly:
it fails confusingly. That single fact produces the whole structure.

**Team-writable, because a person's own routine has to write there:**

- `accounts/` - every customer record, written concurrently by several people's
  ingest runs.
- `outputs/` - per-person scratch. Always writable for you, which is why health
  and incident markers land here when nothing else can be written.
- `_ops/` - `log.md` and `STATUS.md` live in a folder rather than at the root
  purely so that a routine running as an ordinary team member can close out.

One exception inside that list, worth knowing about: `_ops/` is team-writable
but it also holds `sync-agents.sh`, `sync-skills.sh`, `scrub-check.sh` and the
skill-promotion state. Those are admin machinery sitting in a folder the whole
team can write to, because the log and status files have to live beside them.
So any team member can in principle edit a script the daily admin routine then
runs against admin-only paths.

Treat that as a known limit rather than a protection. If it matters to you, move
the three scripts into `.claude/ops/`, which is admin-only, and leave `log.md`,
`STATUS.md` and `sessions/` here. The daily routine's drift check will tell you
if a script changed unexpectedly, but it is a detection, not a prevention.

**Admin-writable, because it is slow-changing shared truth:**

- `company/`, `product/` - the context layer.
- `integrations/` - the boundary layer for external systems.
- `partners/` - the other side of the transaction, with the opposite
  confidentiality direction from `accounts/`.
- `portfolio/` - the single named exception to the money rule, isolated so that
  exception is auditable.
- `.claude/`, `.agents/`, `.codex/`, and the root files - the rulebook and the
  machinery.

## Three consequences to know

**1. Prefer a create-only write to an edit.** Any mechanism meant for the whole team should
drop a new small file that a daily routine folds in, rather than edit a shared
one. That is the only shape that works under connector-grade access, needs no
shell, and never conflicts on a synced drive. The session markers in
`_ops/sessions/markers/` are the worked example.

**2. A person who cannot write is invisible unless you plan for it.** The
session hook writes to `_ops/sessions/`, so a successful row there also proves
that person's Content Manager grant is effective. When that write fails it falls
back to `outputs/_health/`, which is always writable. A row there is the only
signal that positively means "this person's access is broken". See
`_ops/sessions/README.md`.

**3. The expert on a skill usually is not an admin.** Requiring Manager rights
to improve a skill means skills stop improving. The way round it is
`config.yaml` `skill_owners`: the owner maintains their skill in their own
`outputs/<slug>/_skills/<skill>/`, and the daily admin routine promotes it after
a mechanical gate. Adding someone to `skill_owners` is the act of granting
ownership, and that edit is an admin's.

## What this measures about people

Switching this on starts recording things about your colleagues. Decide that
deliberately, and tell them, before anyone's first session.

| What is recorded | Where | Who can read it |
|---|---|---|
| Each session: work email, display name, machine hostname, UTC timestamp | `_ops/sessions/<user>@<host>.csv` | everyone on the team |
| Which skill was run, and when | the same file | everyone on the team |
| Each session on a surface with no hook: person, date, time | the filename in `_ops/sessions/markers/` | everyone on the team |
| Optionally, a per-person table of what each person contributed and produced | the daily digest | everyone on the team |

No prompt, response, file path or document content is ever recorded. That part
is genuinely safe by construction. But the timestamps do show when each person
works, including evenings and weekends, and the per-person table is a named
productivity comparison.

That table is **off by default**. Turn it on with `config.yaml`
`adoption_reporting.per_person_table`, and only after you have told people. With
it off the digest still reports system health, which is what the routine is
actually for.

Session rows are deleted after `adoption_reporting.retain_session_rows_days`.
Pick a period you can defend, and keep it short.

**Before you enable any of this**, work out your lawful basis for it, tell
everyone plainly what is collected and who can see it, and check whether a works
council or employee representative has to be consulted. In much of Europe,
monitoring employee activity without notice is unlawful regardless of how benign
the intent is, and "it is only metadata" is not a defence. `INSTALL-CHECKLIST.md`
has this as Phase 0 for a reason.

## Confidentiality here is organisational, not technical

Worth being blunt about: the team group is **Viewer everywhere**. Every
employee, including someone who joined this morning, can read every account's
commercial terms, every partner's costs, and the portfolio folder. They can also
**write** to every account folder, so any employee can alter a customer record.

The rules about what goes in which folder buy tidiness and auditability. They do
not restrict access and were never going to: a Shared Drive has one membership.
If you need one team unable to see another team's accounts, that is a separate
Shared Drive, not a folder.

## Applying it

1. Create the Shared Drive.
2. Create the two Google Groups.
3. Add the team group to the drive as **Viewer**.
4. Add the admin group to the drive as **Manager**.
5. On each of `accounts/`, `outputs/` and `_ops/`, grant the team group
   **Content Manager**.
6. Verify by having one non-admin save a file into each of the three folders,
   and confirm they cannot save into `company/`.

Step 6 is not optional. A grant that looks right in the sharing dialog and does
not take effect is the most common install failure, and the symptom people
report is "the assistant said it saved but nothing is there".
