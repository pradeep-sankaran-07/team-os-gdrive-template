# Verification probes

A step is done when its probe passes, not when someone says they did it. Each
probe below is something that can actually be observed.

Probes marked **no shell** work in Cowork or on a phone. The rest need a
terminal on a machine with the Drive mounted, so an admin runs them.

## Phase 2 - Notice and lawful basis

| Probe | Passes when |
|---|---|
| **no shell** Ask any team member what this folder records about them | They can say: their email, their machine, when they used it, and which skills they ran |
| **no shell** Read the notice you sent | It names what is collected, who can read it, how long it is kept, and who to ask |
| **no shell** Check `config.yaml` `adoption_reporting` | The per-person table is off, or it is on and people were told before it was |
| **no shell** Ask whoever owns data protection whether this needed a works council or employee consultation | You have an answer, recorded, rather than an assumption |

These are not paperwork. The system's whole value depends on people using it
willingly, and the fastest way to lose that is for someone to discover a
productivity table with their name on it that nobody mentioned.

## Phase 3 - Access

| Probe | Passes when |
|---|---|
| **no shell** `ls -a` in the Shared Drive | `.claude`, `.agents`, `.codex` and `.claude-plugin` are all present. If they are not, the copy was done in Finder and the system is not there |
| `./_ops/sync-skills.sh --check` | Runs at all, rather than "permission denied". Drive does not preserve the executable bit |
| **no shell** Have a non-admin save any small file into `accounts/`, `outputs/` and `_ops/` | All three saves succeed |
| **no shell** Have the same non-admin try to save into `company/` | It fails. If it succeeds, the base role is wrong and everyone can edit the rulebook |
| **no shell** Open the Shared Drive sharing dialog | The two groups are listed, and no individuals remain once the creator's own grant has been removed |

If the first probe fails for one person only, they are not in the team group
yet. If it fails for everyone, the folder-level Content Manager grant did not
take.

## Phase 4 - Shape

| Probe | Passes when |
|---|---|
| **no shell** Read `index.md` | Every folder it lists exists, and every top-level folder appears in it |
| **no shell** Read the routing table in `CLAUDE.md` | Every skill it names exists in `.claude/skills/` |
| `./_ops/sync-agents.sh --check` | Exits clean, so `AGENTS.md` carries the same rules |
| `./_ops/sync-skills.sh --check` | Exits clean, so the mirror and the manifest match |

## Phase 5 - Demo content removed

| Probe | Passes when |
|---|---|
| `grep -ril acme accounts/ partners/ portfolio/ product/ company/ outputs/ --exclude-dir=_template` | Returns nothing. Scoped to the content folders on purpose: the root docs and skills keep naming your company, so a repo-wide grep can never come back empty |
| `grep -rn "sam-okafor\|maya-chen\|tobias-frank\|diego-ramirez\|priya-nair\|lena-vossen" config.yaml .claude/skills/*/SKILL.md \| grep -v install-team-os` | Returns nothing. Demo people hide in five config keys and in every skill's `owner:` field, not only in `people`. The filter drops the installer skill, which names them in its own instructions |
| **no shell** Open `accounts/_index.md` and `partners/_index.md` | The tables list your accounts, not Acme's |
| **no shell** Open `_ops/STATUS.md` | No demo people in the sync table, no demo accounts in the freshness table |
| **no shell** Ask: "what do we sell?" | Answered from your `company/overview.md`, with no trace of the demo product |

## Phase 5b - Context

| Probe | Passes when |
|---|---|
| **no shell** Ask: "who owns the <account> relationship and what is their status?" | Answered from the account folder, with the file named |
| **no shell** Ask: "what do we sell, in one paragraph?" | Answered from `company/overview.md`, not from general knowledge |
| **no shell** Open `accounts/_customer-list.csv` | Every account that matters is a row, with a domain |

The second probe is the real test of Phase 3. If the answer is generic, the
context layer is not seeded and every skill will produce generic output.

## Phase 6 - Surfaces

| Probe | Passes when |
|---|---|
| **no shell** Open the folder in Cowork and ask "how does this Team OS work?" | It answers from `CLAUDE.md` and `index.md` |
| **no shell** Start a session on the phone project and ask for one account's status | It answers, having read by file id, with no search |
| Open the folder in a CLI and run any command | A row appears in `_ops/sessions/<user>@<host>.csv` |

## Phase 7 - Automation

| Probe | Passes when |
|---|---|
| **no shell** List `_ops/sessions/markers/` after a fresh Cowork session | Exactly one new empty file, correctly named, and the session did not narrate or pause for it |
| **no shell** Check the scheduled tasks list on the admin's machine | The daily routine is there, enabled, with the cron you expected |
| Run the daily routine once by hand | It ends with a single `HEALTH:` line |
| **no shell** Read `_ops/STATUS.md` the morning after | It has a `## Daily health` block dated today |

## Phase 8 - The whole thing

| Probe | Passes when |
|---|---|
| **no shell** Have one person who is not an admin do a real piece of work in Cowork | The output lands in the right folder without them choosing it |
| **no shell** Read the digest in the admin's `outputs/` folder | It names every person in the roster, and the access section has nobody in "access blocked" |

That last probe is the one that matters. Everything else can pass while the
system is still unused.

## When a probe fails

Leave the step `todo` or move it to `in progress` with a note saying which probe
failed and what was observed. Do not tick it and add a caveat: the next person
reads the tick.
