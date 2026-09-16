# Status

Current-state snapshot. Auto-maintained by the routines. For the full history
see [log.md](log.md).

## Daily health

2026-09-16 (Wednesday) - daily-team-os-admin: not yet run. Register the scheduled
task per `.claude/routines/scheduled-task-prompts.md`.

## What happened (last 24h)

Seeded from the template.

## Knowledgebase

Never refreshed. `integrations/knowledgebase.md` holds placeholder rows until an
admin points `config.yaml` `knowledgebase` at a real drive and runs the refresh,
or deletes the block.

## Sync status (all roster people)

Driven from `config.yaml` `people`, never from a hardcoded count. The per-person
sweep-state CSV is the source of truth for seeded counts; this table is a view
of it and loses to it in a disagreement.

| Person | Accounts seeded | Last run (UTC) | Status | Notes |
|---|---|---|---|---|
| maya-chen | 0/5 | never | not set up | |
| diego-ramirez | 0/5 | never | not set up | |
| priya-nair | 0/5 | never | not set up | |
| lena-vossen | 0/5 | never | not set up | |
| sam-okafor | 4/5 | 2026-09-11 | green | harlowe-security not yet seeded; it is lena-vossen's prospect |
| tobias-frank | 0/5 | never | not set up | admin runner |

## Last update per account

| Account | Last updated | By |
|---|---|---|
| northwind-software | 2026-09-11 | seeded |
| calderwick-media | 2026-09-04 | seeded |
| ashgrove-analytics | 2026-09-09 | seeded |
| harlowe-security | 2026-09-08 | seeded |
| harborline-logistics | 2026-07-31 | seeded |
