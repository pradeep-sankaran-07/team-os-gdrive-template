# Install checklist

Maintained by the `install-team-os` skill. Ask "where do I start" or "what is
left" at any time. Ask "check my install" to re-run the probes rather than
trusting the ticks.

**Company:** _not set yet_
**Shared Drive:** _not set yet_
**Admin runner:** _not set yet_
**Last checked:** _never_

## Phase 1 - Get the files onto the Drive

Nothing else can happen until `config.yaml` exists in the Shared Drive.

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Shared Drive created and mounted by Drive for Desktop | admin | the folder opens locally |
| todo | Contents copied in from a terminal, not Finder | admin | `ls -a` shows `.claude`, `.agents`, `.codex`, `.claude-plugin` |
| todo | Scripts made executable after the copy | admin | `./_ops/sync-skills.sh --check` runs without "permission denied" |

## Phase 2 - Notice and lawful basis

Before any logging is switched on. See ACCESS-CONTROL.md, "What this measures
about people".

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Lawful basis for session logging decided and recorded | admin | written in Notes below |
| todo | Everyone told what is recorded, who can read it, how long it is kept | admin | the notice was actually sent |
| todo | Works council or employee consultation checked | admin | you have an answer, not an assumption |
| todo | Per-person adoption table left off, or turned on only after the notice | admin | `config.yaml` `adoption_reporting.per_person_table` |
| todo | Retention period set for session rows and account email notes | admin | `adoption_reporting.retain_session_rows_days` is set and defensible |

## Phase 3 - Identity and access

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Company name and domain in `config.yaml` `company_name` / `company_domain` | admin | neither is a placeholder |
| todo | Daily routine runner and backup in `config.yaml` `admin` | admin | both are Drive Managers |
| todo | Shared Drive created, id in `config.yaml` `drive` | admin | the drive opens |
| todo | Team and admin Google Groups created | admin | both resolve |
| todo | Team group added as Viewer, admin group as Manager | admin | sharing dialog lists two groups and no individuals |
| todo | Team group upgraded to Content Manager on `accounts/`, `outputs/`, `_ops/` | admin | a non-admin can save into all three and cannot save into `company/` |

## Phase 4 - Shape

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Decided which optional folders this company keeps | admin | `index.md` matches what is on disk |
| todo | Removed the folders not being used, and their config and routing rows | admin | routing table names only skills that exist |
| todo | Renamed anything the company calls something else | admin | the team recognises the vocabulary |
| todo | Regenerated `AGENTS.md` and the skills mirror | admin | both `--check` scripts exit clean |

## Phase 5 - Context

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Demo records deleted (5a) | admin | `grep -ril acme accounts/ partners/ portfolio/ product/ company/ outputs/ --exclude-dir=_template` returns nothing |
| todo | Demo business replaced with yours (5b) | admin | "what do we sell" is answered from your `company/overview.md` |
| todo | Demo people replaced in all five `config.yaml` places and in skill frontmatter (5c) | admin | `grep -rn "sam-okafor\|maya-chen\|tobias-frank\|diego-ramirez\|priya-nair\|lena-vossen" config.yaml .claude/skills/*/SKILL.md \| grep -v install-team-os` returns nothing |
| todo | Branded skills renamed to this company and both sync scripts re-run (5d) | admin | both `--check` scripts exit clean |
| todo | `company/` seeded from existing material | admin | "what do we sell" is answered from the file, not from general knowledge |
| todo | Roster in `config.yaml` `people` and `company/team.md` | admin | every current person is listed with a role |
| todo | `accounts/_customer-list.csv` seeded | admin | every account that matters is a row, with a domain |
| todo | One account seeded fully as the worked example | admin | its status can be answered end to end |
| todo | `product/` seeded, or removed | admin | consistent with Phase 2 |

## Phase 6 - Surfaces

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Drive for Desktop installed, folder visible under Shared drives | each person | the folder opens locally |
| todo | Cowork pointed at the folder | each person | "how does this work" is answered from `CLAUDE.md` |
| todo | Write-probe run for every AI product the team uses, result recorded | admin | the table in `CONNECTOR-SURFACES.md` is filled in |
| todo | Connector project created per product, with the matching block (A or B) | admin | a session answers an account question by file id |
| todo | CLI set up for the admins and engineers | those people | a session row appears in `_ops/sessions/` |

## Phase 7 - Automation

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | Session markers being written on every surface | everyone | one empty marker per session, unnarrated |
| todo | Daily admin routine scheduled on the admin's machine | admin runner | it ends with a single `HEALTH:` line |
| todo | Everyone customer-facing has scheduled their own ingest | each person | accounts start getting seeded |

## Phase 8 - Live

| Status | Step | Owner | Verified by |
|---|---|---|---|
| todo | `START-HERE.md` sent, after group access was granted | admin | nobody's first session fails to write |
| todo | One non-admin has done real work end to end | that person | the output landed in the right folder unprompted |
| todo | First digest reviewed, nobody in "access blocked" | admin | the digest says so |

## Notes

_The skill writes here: what failed, what was skipped and why, anything the next
admin needs to know._
