# Index

The catalog for this Team OS. **Route from here, then go straight to the right
file.** Do not scan the whole tree.

## Core

| File | What it is for |
|---|---|
| [README.md](README.md) | What this template is, and where to start |
| [LICENSE](LICENSE) | MIT |
| [START-HERE.md](START-HERE.md) | The one-page intro sent to a new joiner |
| [CLAUDE.md](CLAUDE.md) | The behaviour contract. Governs everything |
| [AGENTS.md](AGENTS.md) | The same rules for a second agent tool. Generated from CLAUDE.md |
| [config.yaml](config.yaml) | Every environment-specific value: people, paths, ids, models |
| [ACCESS-CONTROL.md](ACCESS-CONTROL.md) | The two groups, and why the layout follows from them |
| [INSTALL.md](INSTALL.md) / [INSTALL-CHECKLIST.md](INSTALL-CHECKLIST.md) | Setting it up, and what is still missing |
| [SETUP.md](SETUP.md) | Multi-tool wiring, and what is honestly not portable |
| [CONNECTOR-SURFACES.md](CONNECTOR-SURFACES.md) | Connector surfaces, what each product can write, and the probe |
| [_ops/log.md](_ops/log.md) | Append-only history |
| [_ops/STATUS.md](_ops/STATUS.md) | Current state and freshness |

## Context layer

| Path | What it holds |
|---|---|
| [company/overview.md](company/overview.md) | What we do, business model, constraints |
| [company/market.md](company/market.md) | Who we sell to, the landscape, where we win and lose |
| [company/glossary.md](company/glossary.md) | Terms, so everyone means the same thing |
| [company/team.md](company/team.md) | Roster and ownership. `config.yaml` wins if they disagree |
| [product/overview.md](product/overview.md) | What the product is |
| [product/roadmap.md](product/roadmap.md) | Shaping decisions only. The roadmap itself is live in the tracker |
| [product/prds/](product/prds/) | Written specifications for work not yet built |

## Accounts

[accounts/_customer-list.csv](accounts/_customer-list.csv) is the source of
truth; [accounts/_index.md](accounts/_index.md) is a generated view, and the CSV
wins. One folder per account, `_template/` to create one,
`_sweep-state/` holding each person's per-account ingest window.

Worked example: [northwind-software](accounts/northwind-software/), which has a
profile, a summary, two calls, an email thread and an account review.

## Partners

[partners/_index.md](partners/_index.md). Mirrors `accounts/` with the opposite
confidentiality direction: partner costs stay here, our margin and customer
pricing never enter.

## Portfolio

[portfolio/README.md](portfolio/README.md). The cross-portfolio roll-up and the single named
exception to the rule that money does not go in files.

## Outputs

[outputs/README.md](outputs/README.md). One folder per person for personal and
in-progress work. Your slug is derived from your session; the folder appears by
itself.

## Skills (`.claude/skills`)

> Canonical: `.claude/skills/`, edit here only. Mirror: `.agents/skills/`,
> generated, never hand-edit. Manifest: `.claude-plugin/plugin.json`, generated.
> Run `./_ops/sync-skills.sh` after any change.

| Skill | What it does |
|---|---|
| [_template](.claude/skills/_template/) | The authoring standard. Copy it to start a new skill |
| [acme-brand](.claude/skills/acme-brand/) | The visual standard. Mandatory by format |
| [acme-marketing](.claude/skills/acme-marketing/) | What may be said in public. Mandatory by audience |
| [create-branded-image](.claude/skills/create-branded-image/) | Images. Mandatory by output type |
| [customer-call-summary](.claude/skills/customer-call-summary/) | A call, filed into the account |
| [account-review](.claude/skills/account-review/) | One account, in depth |
| [solution-brief](.claude/skills/solution-brief/) | The prospect decision document |
| [customer-dashboard](.claude/skills/customer-dashboard/) | The cross-portfolio view |
| [install-team-os](.claude/skills/install-team-os/) | Set up, continue or check the installation |

## Orchestration (`.claude/routines`)

| Routine | Who runs it |
|---|---|
| [daily-team-os-admin](.claude/routines/daily-team-os-admin.md) | One admin, daily. Refresh, reconcile, drift, skill promotion, health and digest |
| [ingest-customer-context](.claude/routines/ingest-customer-context.md) | Everyone customer-facing, on their own mail |
| [refresh-knowledgebase-map](.claude/routines/refresh-knowledgebase-map.md) | An admin, daily, if there is a second knowledge drive |
| [scheduled-task-prompts](.claude/routines/scheduled-task-prompts.md) | The prompts to register, and the rule that keeps them working |

## Integrations

| File | System |
|---|---|
| [integrations/gmail-drive.md](integrations/gmail-drive.md) | The ingestion inputs, and the privacy model |
| [integrations/work-tracker.md](integrations/work-tracker.md) | Live over MCP. Query, never mirror |
| [integrations/knowledgebase.md](integrations/knowledgebase.md) | A second read-only drive, indexed as a routing map |

## Machinery

| File | What it does |
|---|---|
| [.claude/hooks/log-session.sh](.claude/hooks/log-session.sh) | Session and skill logging, and the access canary |
| [.claude/hooks/session-report.sh](.claude/hooks/session-report.sh) | Read the adoption metric |
| [_ops/sync-skills.sh](_ops/sync-skills.sh) | Mirror skills, regenerate the manifest |
| [_ops/sync-agents.sh](_ops/sync-agents.sh) | Generate AGENTS.md from CLAUDE.md |
| [_ops/sessions/README.md](_ops/sessions/README.md) | How adoption is measured, and every caveat |
| [apps-script/serve-dashboard.gs](apps-script/serve-dashboard.gs) | Serve a Drive HTML file at an internal URL |
| [.claude/learnings.md](.claude/learnings.md) | Accumulated rules, each with its reason |
| [.claude/commands/](.claude/commands/) | Slash-command wrappers, Claude Code only |
| [.claude/settings.json](.claude/settings.json) | Hook registration for Claude Code |
| [.codex/hooks.json](.codex/hooks.json) | The same hooks in Codex's format, if your version runs them |
| [.claude-plugin/plugin.json](.claude-plugin/plugin.json) | Generated manifest. Never hand-edit |
| [.agents/skills/](.agents/skills/) | Generated mirror of the skills, for the second agent tool |
| [_ops/README.md](_ops/README.md) | Why the ops files live in a folder rather than the root |
| [_ops/scrub-check.sh](_ops/scrub-check.sh) | Publication gate, for anyone who publishes part of this folder |
| [_ops/skill-sync/](_ops/skill-sync/) | State and backups for owner skill promotion |
| [accounts/_sweep-state/](accounts/_sweep-state/) | Each person's per-account ingest window |
| [.github/](.github/) | Issue templates for this template's own repo. Delete after install |
