# team-os-gdrive-template

A working template for an **AI Team OS**: one shared Google Drive folder that
gives every function the context of the business plus a library of reusable
skills, kept current automatically, so anyone can work as if they had the whole
company in their head.

Most of it is Markdown that an agent reads and acts on. A smaller part is code
that runs: the session hook, two sync scripts, a publication gate and an Apps
Script. The repo is explicit about which is which. What it adds over a folder of
notes: session logging that works on surfaces with no shell, a daily admin pass
that repairs what it can and escalates the rest, an access model the folder
layout is derived from, skills kept in step across two agent tools, and an
installer that checks its own steps instead of trusting them.

Seeded with a fictional company, so the structure has something in it while you
read. The demo content is deleted during install.

## GitHub is the distribution channel. Google Drive is the runtime.

Clone this repo, then copy its contents into a company Google Shared Drive.
Nothing in the running system depends on git. That is the point: a Shared Drive
is something a non-technical team already has, already understands, and already
has permissions for, and Drive for Desktop makes it a plain local folder that
agent tools read and write directly, with no push step.

## The four layers

1. **Context** - what the AI knows about the business, as plain Markdown:
   `company/`, `product/`, `accounts/`, `partners/`.
2. **Skills** - reusable recipes that turn context into finished work:
   `.claude/skills/`.
3. **Orchestration** - routines that keep it current with no manual upkeep:
   `.claude/routines/`.
4. **Inputs** - where context comes from and where results go: `integrations/`.

## Start here

| You are | Read |
|---|---|
| Setting this up for a company | [INSTALL.md](INSTALL.md), then ask the assistant "where do I start" |
| A new joiner on a team already using it | [START-HERE.md](START-HERE.md) |
| Wondering why the folders are arranged like this | [ACCESS-CONTROL.md](ACCESS-CONTROL.md) |
| Wiring up a second agent tool | [SETUP.md](SETUP.md) |
| Setting it up on a phone | [CONNECTOR-SURFACES.md](CONNECTOR-SURFACES.md) |
| Looking for a specific file | [index.md](index.md) |

Behaviour rules are in [CLAUDE.md](CLAUDE.md). Every environment-specific value
is in [config.yaml](config.yaml), and nothing environment-specific is hardcoded
anywhere else.

## What makes this different from a folder of Markdown

- **The layout is derived from the permission model**, not from taste. Two
  groups, three team-writable folders, and a documented reason for each.
- **It measures its own adoption**, on every surface, including the ones that
  cannot run a hook, using empty files that carry everything in their name.
- **It reports honestly.** The daily digest is explicitly forbidden from reading
  absence of a signal as absence of work.
- **It self-heals what is mechanical and escalates what needs judgment**, and
  the difference between the two is written down as a closed list.
- **A non-admin can own and improve a skill** without ever getting write access
  to the skills folder.
- **Every rule carries the reason for it.** A rule with no stated reason gets
  deleted by the next person who finds it inconvenient. See
  [.claude/learnings.md](.claude/learnings.md).

## Which agent tools

Designed for Cowork first, because that is where most of a non-technical team
works: no hooks, no guaranteed shell, and file access that may be read-only in
practice depending on the product. Everything team-wide works under those constraints. Claude Code and
Codex work from the same folder. Claude Code also gets the session hook; on
Codex, check whether repo-local hooks run in your version, and fall back to the
session-marker rule, which works everywhere. A
phone reaches it through the Drive connector; see [CONNECTOR-SURFACES.md](CONNECTOR-SURFACES.md).

## The fiction

Acme Corp sells Acme Outbound, an AI outbound sales platform. Six people, five
accounts, two partners, three PRDs. Every company, person, customer and domain
is invented, and the domains are all under the reserved `.example` TLD.

The accounts are chosen to exercise different skills: one healthy with an
expansion signal, one at risk with a quiet champion, one mid-onboarding, one
competitive prospect, one churned with the honest reason written down. Product
work cross-references the accounts waiting on it, in both directions.

Replace all of it. What you are adopting is the structure, not the content.

## Licence

MIT. See [LICENSE](LICENSE).
