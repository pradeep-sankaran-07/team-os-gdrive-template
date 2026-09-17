# Install

Setting this up takes a few hours, not weeks, and most of that is deciding what
your company's context actually is rather than anything technical.

## The short version

1. Clone this repo.
2. Create a company Google Shared Drive and let Drive for Desktop mount it.
3. Copy the contents in **from a terminal, not from Finder**:

   ```
   rsync -a --exclude '.git' ./ "/path/to/your/mount/Shared drives/<drive-name>/"
   ```

   Then make the scripts runnable, because Drive does not preserve the
   executable bit:

   ```
   cd "/path/to/your/mount/Shared drives/<drive-name>"
   chmod +x _ops/*.sh .claude/hooks/*.sh .codex/hooks/*.sh
   ```

4. Check the dot-folders arrived. `ls -a` must show `.claude`, `.agents`,
   `.codex` and `.claude-plugin`.
5. Open the folder in your agent workspace and say: **"where do I start?"**

Steps 3 and 4 exist because every behavioural part of this system lives in a
dot-folder, and Finder hides those by default. Dragging "the contents" across in
a file browser copies the documents and silently leaves behind the rulebook, the
skills, the routines and the hooks. The result looks complete and does nothing.

From there the `install-team-os` skill runs the whole thing: it interviews you,
writes your answers into `config.yaml`, shapes the folders to your company, and
keeps `INSTALL-CHECKLIST.md` up to date so nothing ends up half-done.

Ask it **"what is left?"** at any point, and **"check my install"** to have it
re-run the probes rather than trust the ticks.

## The eight phases

| Phase | What happens | The thing people get wrong |
|---|---|---|
| **1. Files on the Drive** | Create and mount the Shared Drive, copy the contents in | Copying in Finder, which hides the dot-folders and silently leaves the whole system behind |
| **2. Notice** | Lawful basis, telling people what is recorded, retention | Treating it as paperwork and doing it after go-live |
| **3. Identity and access** | Shared Drive, two Google Groups, the grants | Assuming a grant took effect. Verify it by having a non-admin actually save a file |
| **4. Shape** | Decide which folders this company needs, delete the rest | Keeping every folder "just in case". An empty folder makes the assistant search for context that is not there, every session |
| **5. Context** | Delete the Acme demo content, then seed `company/`, the roster and the account list from what you already have | Leaving the demo accounts in place beside your real ones, and retyping things that already exist rather than mapping them in |
| **6. Surfaces** | Drive for Desktop, the workspace, mobile, optionally a CLI | Skipping mobile, which then silently fails to edit files |
| **7. Automation** | Hooks, the daily admin routine, each person's ingest | Registering the daily routine on a machine that is not always on |
| **8. Live** | Run the probes, then send `START-HERE.md` | Sending the intro before granting group access, so everyone's first session fails to write |

## Before you switch on the logging

This system records who used it and when, and can publish a per-person summary.
That is Phase 2 in the checklist, before any logging starts, because the fix for
telling people afterwards is expensive and the fix for telling them first is an
email. See [ACCESS-CONTROL.md](ACCESS-CONTROL.md), "What this measures about
people".

## Two things to decide before you start

**Who is the admin.** One person runs the daily routine on their machine and
holds Manager on the drive. It is roughly ten minutes of attention a week, and
it is a named job rather than a shared responsibility, because a shared one is
nobody's.

**What your company actually does.** This template ships with a fictional B2B
software company: accounts, partners, a product, a portfolio dashboard. A
services business probably has no `product/`. A company with no vendor side has
no `partners/`. Decide in phase 2 and delete what you do not need. The structure
is a starting point, not a prescription.

## Requirements

- A Google Workspace domain with Shared Drives.
- Google Drive for Desktop on at least the admin's machine.
- An AI assistant that can work from a local folder, plus the Drive connector
  for phones.

No servers, no CI and no database. The one optional exception is the Apps Script
that serves the dashboard, which is a hosted web app and needs its access
setting chosen carefully; see `apps-script/serve-dashboard.gs`. Everything else
is files. The more infrastructure this needs, the fewer teams can run it.

## Prefer to do it by hand

Everything the skill does is also written down. [ACCESS-CONTROL.md](ACCESS-CONTROL.md)
has the grants, [SETUP.md](SETUP.md) has the tool wiring, [CONNECTOR-SURFACES.md](CONNECTOR-SURFACES.md)
has the phone, and `.claude/routines/scheduled-task-prompts.md` has the
scheduled tasks. `INSTALL-CHECKLIST.md` works fine as a document you tick off
yourself.
