---
name: install-team-os
description: >
  Set up, continue or check the installation of this Team OS in a company
  Google Shared Drive. Interviews the admin, writes the answers into
  config.yaml, shapes the folders to that company, and keeps
  INSTALL-CHECKLIST.md up to date so nothing is half-done.
  Triggers: "where do I start", "set up the team os", "install this",
  "what is left to set up", "check my install", "is the setup finished",
  "continue the installation", "add a new person to the OS".
  NOT for day-to-day work once the OS is running. NOT for changing access for
  one person, which is a Google Group membership change, not an install step.
when_to_use: Before the OS is live, and any time someone asks what is still missing.
inputs:
  - INSTALL-CHECKLIST.md (the current state)
  - config.yaml
  - references/checklist-template.md, references/verification.md, references/mobile-project-template.md
output_location: "config.yaml, INSTALL-CHECKLIST.md, and the folders being created"
owner: tobias-frank
status: PUBLISHED v1.0 (2026-09-16)
last_updated: 2026-09-16
---

# Install this Team OS

You are guiding one person, the admin, through standing this up. They may be
non-technical and may be working in a chat surface with no shell. Assume that.

## How to run

**Always read `INSTALL-CHECKLIST.md` first.** It is the state. Never ask a
question the checklist already answers, and never redo a step it records as done.

Then:

| They say | You do |
|---|---|
| "where do I start" | Report the first `todo` step, in full, with what they physically have to do. Nothing else. |
| "what is left" | List every `todo` and `in progress` step, grouped by phase, shortest first. |
| "check my install" | Run the probes in `references/verification.md` against the folder and report what actually passed, not what is ticked. |
| anything else | Work out which phase it belongs to, do that step, then update the checklist. |

**One step at a time.** Do not present six phases at once. An admin who is told
everything is left does nothing; an admin told one thing does it.

**Update `INSTALL-CHECKLIST.md` after every step**, before you reply. If the
checklist does not exist yet, create it from
`references/checklist-template.md` as your first action.

## Phase 1 - Get the files onto the Drive

Nothing else can happen until `config.yaml` exists in the Shared Drive. Create
the Shared Drive, mount it with Drive for Desktop, and copy this repo's contents
in **from a terminal, not Finder**: every behavioural part of the system lives in
a dot-folder, and Finder hides those, so a drag-and-drop copies the documents and
silently leaves the rulebook, the skills, the routines and the hooks behind.

Then `chmod +x _ops/*.sh .claude/hooks/*.sh .codex/hooks/*.sh`, because Drive
does not preserve the executable bit. Confirm with `ls -a` that `.claude`,
`.agents`, `.codex` and `.claude-plugin` all arrived.

## Phase 2 - Notice, before any logging happens

This system records who opened it and when, and can publish a per-person summary
of what each named colleague contributed. Before anyone's first session, the
admin needs four things settled. Ask for each and record the answer in the
checklist's Notes section:

1. What is the lawful basis for recording this?
2. Has everyone been told what is collected, who can read it, and how long it is
   kept? `START-HERE.md` has a section they can be pointed at.
3. Does a works council or employee representative have to be consulted?
4. Is the per-person table staying off? It is off by default in `config.yaml`
   `adoption_reporting.per_person_table`, and it should only go on after 2.

Do not treat this as paperwork to get past. The system only works if people use
it willingly, and the quickest way to lose that is somebody discovering a
productivity table with their name on it that nobody mentioned.

## Phase 3 - Identity and access

Ask, in this order, and write each answer into `config.yaml` as you get it:

1. Company name and email domain, into `company_name` and `company_domain`.
   Several generated files read these, so they come first.
2. The Shared Drive name and id, into the `drive` block.
3. The two Google Group addresses, into `permissions.groups`.
4. Who runs the daily routine and who backs them up, into `admin`.

Then walk them through the grants, which they do in the Drive UI themselves:

- Team group: **Viewer** on the drive, then **Content Manager** on `accounts/`,
  `outputs/` and `_ops/`.
- Admin group: **Manager** on the drive.

Explain why in one sentence: the team writes only where their work goes, and
`_ops/` exists as a folder rather than root files precisely so an ordinary team
member's routine can close out.

**Do not mark this phase done on their word.** A grant that looks right in the
sharing dialog and does not take effect is the most common install failure, and
the symptom is "the assistant said it saved but nothing is there". Verify it per
`references/verification.md`.

## Phase 4 - Shape the folders to this company

Every company has different functions. Ask what this one actually has, and then
**delete what they do not need.** A folder nobody fills is worse than no folder:
it makes the assistant look for context that is never there.

| Folder | Keep? |
|---|---|
| `accounts/`, `outputs/`, `_ops/` | Always. These are the three writable folders and the OS does not work without them. |
| `company/` | Always. |
| `product/` | If they build a product. A services business usually does not need it. |
| `partners/` | If they have a supply, vendor or reseller side worth tracking per entity. |
| `portfolio/` | If they want a cross-portfolio roll-up. Skip it and the confidentiality carve-out disappears with it, which is simpler. |
| `integrations/knowledgebase.md` | Only if they have a second, read-only knowledge drive. |

Also ask what they call things. If they say "clients" rather than "accounts",
rename the folder and update `index.md` and the routing table to match. People
do not adopt a system that uses someone else's vocabulary.

When you remove a folder, remove its rows from `index.md`, its routing-table
rows in `CLAUDE.md`, its `config.yaml` block, and any skill that only served it.
Then regenerate with `./_ops/sync-agents.sh` and `./_ops/sync-skills.sh`, or say
that an admin with a terminal needs to run them.

## Phase 5 - Remove the demo content, then seed the real thing

**Delete the fiction first.** Nothing else in this phase is safe until it is gone: an adopter who seeds their real customers alongside Acme's ends up with a
roster nobody trusts, and a marketing skill that will happily clear Acme's
claims for their publications.

### 5a. Delete the demo records

- every folder under `accounts/` except `_template/` and `_sweep-state/`, and
  empty `accounts/_customer-list.csv` down to its header and comment lines
- every per-person CSV in `accounts/_sweep-state/`, keeping the README
- every folder under `partners/` except `_template/`, and empty
  `partners/_partner-list.csv` the same way
- the generated tables in `accounts/_index.md` and `partners/_index.md`
- `portfolio/crosswalk.csv`, `portfolio/revenue.csv`, `portfolio/revenue.meta.json`
- everything in `product/prds/`
- every folder under `outputs/` except `_unassigned/`
- both tables in `.claude/skills/acme-marketing/references/claims.md`
- the seed line in `_ops/log.md`, and the two demo tables in `_ops/STATUS.md`
  (`## Sync status` and `## Last update per account`)
- `.github/`, which is for this template's own repo and not for yours

### 5b. Replace the demo business

These describe Acme, not your company. Rewrite rather than delete, because the
structure is what you want to keep:

- `company/overview.md`, `company/market.md`, `company/glossary.md`,
  `company/team.md`
- `product/overview.md` and `product/roadmap.md`, or delete `product/`
  altogether if you do not build a product

### 5c. Replace every demo person

`config.yaml` names demo people in **five** places, not one. Change all of them:

- `people`
- `admin.runner` and `admin.backup`
- `customer_dashboard.schedule.runner` and `.backup`
- `knowledgebase.refresh.runner` and `.backup`
- both `skill_owners` entries

Then the `owner:` field in the frontmatter of every file in
`.claude/skills/*/SKILL.md`.

### 5d. Rename the two branded skills

`acme-brand` and `acme-marketing` become `<company>-brand` and
`<company>-marketing`. Update the routing-table rows in `CLAUDE.md`, the
`--acme-*` token names in `assets/tokens/*.css`, and every reference to
`acme-brand` in other skills. Also update `Shared drives/acme-os` in
`.claude/routines/scheduled-task-prompts.md`, and `company_name` /
`company_domain` / `repo_name` in `config.yaml` if you have not already.

Re-run `./_ops/sync-agents.sh` and `./_ops/sync-skills.sh` afterwards.

### 5e. Check it

```
grep -ril acme accounts/ partners/ portfolio/ product/ company/ outputs/ \
  --exclude-dir=_template
grep -rn "sam-okafor\|maya-chen\|tobias-frank\|diego-ramirez\|priya-nair\|lena-vossen" \
  config.yaml .claude/skills/*/SKILL.md | grep -v install-team-os
```

Both must return nothing. The second filters out this file, which names the demo
people in the line above and would otherwise match itself forever.

The first is scoped to the content folders rather than the whole repo, because
after 5d the root documents and skills legitimately carry *your* company name,
so a repo-wide grep can never come back empty and tests nothing.

## Phase 5f - Seed the context

The OS is only as good as what it knows. Ask what already exists and **map it
in**; do not ask them to retype anything.

1. `company/overview.md`, `market.md`, `glossary.md` - from whatever they have:
   a pitch deck, a website, an internal wiki page.
2. `company/team.md` and `config.yaml` `people` - the roster. `role` and `owns`
   are written by a human here; everything after this is derived automatically.
3. `accounts/_customer-list.csv` - the account roster. This is the operative
   watch list, and nothing gets ingested for a company that is not on it. If
   they have a CRM export or a sheet, map the columns rather than retyping.
4. `product/` if kept.

Seed one account fully as the worked example, so the team can see the shape.

## Phase 6 - Agent surfaces

1. **Drive for Desktop** on each person's machine, signed in with their work
   account. Confirm the folder appears under Shared drives.
2. **Cowork**: select this folder as the working folder. This is the primary
   surface for most of the team.
3. **Mobile**: create a project and paste in the instruction block generated
   from `references/mobile-project-template.md`. It needs real file and folder
   ids, so generate it after Phase 3, when the files exist. See `CONNECTOR-SURFACES.md`.
4. **CLI** (Claude Code, Codex): optional, for the admins and engineers.

## Phase 7 - Automation

1. Install the session hooks. `.claude/settings.json` is wired and takes effect
   for anyone who opens the folder in Claude Code. `.codex/hooks.json` is
   provided but repo-local hook support varies by Codex version, so confirm it
   actually fires before counting on it. Nothing to do for Cowork or mobile,
   which write session markers instead, and so do the CLIs.
2. Register the daily admin routine as a scheduled task, using the prompt in
   `.claude/routines/scheduled-task-prompts.md`. It runs on **one admin's
   machine** and needs the local mount.
3. Give everyone who talks to customers the single sentence that schedules their
   own ingest. It is in `START-HERE.md` and they paste it once.

Fill in `config.yaml` `admin.runner` and `admin.backup`, and make sure both are Drive Managers. A routine with one owner and no backup stops the week they go on holiday.

## Phase 8 - Verify, then go live

Run every probe in `references/verification.md`. A step is done when a probe
passes, not when someone says they did it. Report what actually passed.

Then send `START-HERE.md` to the team. **Add them to the team group first**, so
their first session can write.

## Non-negotiables

- Never mark a step done without its probe passing.
- Never invent a value into `config.yaml`. If you do not have it, leave the
  placeholder and leave the step `todo`.
- Never grant access yourself or ask for credentials. Access changes happen in
  the Google Admin console, by a human, in their own browser.
- Do not delete anything outside this folder.

## Things that have gone wrong before

- **A Content Manager grant that has not been verified is not a grant.** Why:
  the most common failure in this whole install is a sharing setting that reads
  correctly and has not propagated, and the person affected reports it as "the
  AI is broken" rather than as an access problem. (2026-09-16)
- **Remove the folders the company does not use, at install, not later.** Why:
  an empty top-level folder makes the assistant search for context that does not
  exist, and every session pays for it. (2026-09-16)
