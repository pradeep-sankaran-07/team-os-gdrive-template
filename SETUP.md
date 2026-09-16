# Setup: running this Team OS across more than one agent tool

The **knowledge and skills are portable**. The **live tool wiring is not**, and
has to be set up per tool. This page is for admins and engineers. A new joiner
needs `START-HERE.md` instead.

## Entry files, per tool

- **Claude and Claude Code** read `CLAUDE.md`, then `index.md`.
- **Codex** reads `AGENTS.md`, then `index.md`.

Both carry the same operating norms and the same skills routing table.

**`AGENTS.md` is generated from `CLAUDE.md`.** Edit `CLAUDE.md`, then run
`./_ops/sync-agents.sh`. Where the two genuinely differ, wrap each version in
the fenced blocks described at the top of that script; everything else is one
global path substitution.

This is generated rather than hand-kept for a reason. Keeping two copies of the same rulebook by hand does not work. The second one
loses a rule here and a routing row there, nothing compares them, and the first
symptom is an agent on that side behaving differently with no explanation.

## Skills: one source of truth

| Path | Status |
|---|---|
| `.claude/skills/` | **Canonical.** Edit here only. |
| `.agents/skills/` | **Mirror.** A verbatim copy. Never hand-edit. |
| `.claude-plugin/plugin.json` | **Generated** from the skills and commands folders. Never hand-edit. |

After changing any skill or command, run `./_ops/sync-skills.sh`.

**No string substitution, ever.** Skills are model-neutral prose: nothing inside
one should name a tool. A blind find-replace of one tool's name across a mirror
produces a copy referencing a model that does not exist and paths that go
nowhere, and nothing notices until someone tries to use it.

## What is NOT plug-and-play

The knowledge layer works for any tool. The live automation layer does not.
To make a second tool genuinely useful here, wire up on that side:

- **Connectors** - email, files, the work tracker. A second tool can read every
  context and skill file and still not query the tracker or send mail until its
  own connectors are authorised. Aim for parity.
- **Commands** - `.claude/commands/` are Claude-Code-only. Other tools have no
  equivalent, and skills are invoked by intent rather than by a slash command
  anyway, so this costs less than it sounds.
- **Hooks** - `.claude/settings.json` and `.codex/hooks.json` are different
  formats and are maintained separately. The scripts they call are byte
  identical. **Never put a person's absolute mount path in either file**: each
  person mounts the Shared Drive under their own account, which is why the Codex
  file resolves from the working directory instead.
  **Verify the Codex side before relying on it.** Repo-local hook support varies
  by version, and `.codex/hooks.json` may simply be inert in yours. Nothing
  depends on it: the session-marker rule in `AGENTS.md` covers every surface,
  hooks or not, which is exactly why that rule applies to surfaces that have
  hooks as well.
- **Routines** - scheduled tasks live in each person's own assistant, on their
  own machine, not in this folder. See
  `.claude/routines/scheduled-task-prompts.md`.

Until the connectors are set up, a second tool is good for reading context and
applying skills, and cannot touch live systems.

## Quick verification

```
./_ops/sync-skills.sh --check     # skills mirror and manifest are in sync
./_ops/sync-agents.sh --check     # AGENTS.md carries every rule CLAUDE.md does
diff .claude/hooks/log-session.sh .codex/hooks/log-session.sh   # hook scripts identical
```

All three should be silent or say "in sync". The daily admin routine runs the
first two every morning, so drift is caught the next day rather than the next
quarter.
