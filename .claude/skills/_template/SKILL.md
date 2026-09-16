---
# Copy this folder to start a new skill. Rename it, fill this in, delete the
# guidance comments, and run ./_ops/sync-skills.sh.
#
# FRONTMATTER SCHEMA. Use exactly these keys, in this order. Two are required
# (name, description); the rest are strongly recommended and are what the daily
# skill-promotion gate checks.

name: _template
# MUST equal the folder name exactly. The promotion gate enforces this, because
# a near-miss here overwrites a different skill.

description: >
  One sentence on what this skill produces. Use when <the situation>.
  Triggers: "<the phrase someone actually types>", "<another one>", "<a third>".
  NOT for <the adjacent case> (use <sibling-skill> instead).
# This field is the routing table. On most surfaces nobody types a skill name,
# so the assistant picks a skill by reading these descriptions. Four things must
# be in it: what it does, a "use when" clause, literal trigger phrasings, and an
# explicit boundary naming the sibling skill for the adjacent case. A
# description without a boundary clause will steal work from its neighbours.

when_to_use: One line, the same situation stated plainly for a human reader.
inputs:
  - the files or information this skill needs before it can start
output_location: "path/with/<slug>/and-a-<yyyy-mm-dd>-filename.md"
owner: <person-slug>
# ONE way to record an owner: this key. Do not also put it in the description or
# in a footer. Note that this key is documentation. The list that actually
# grants update rights is `skill_owners` in config.yaml.
status: DRAFT
# DRAFT | PUBLISHED v<n> (<date>) - <what validated it>
last_updated: 2026-09-16
---

# <Skill name>

One paragraph: what this produces and who reads it. No preamble.

## Step 1 - Gather

Name the exact files to read, in order. Say what to do when one is missing:
record it as missing, never infer it.

## Step 2 - Decide

If the skill has a real judgment call, isolate it into its own step and give the
selection criteria. A skill whose steps are all "write section N" does not need
this step; one that picks an angle, a template or a route does.

## Step 3 - Produce

The sections of the output, numbered, with one line each on what belongs in them.
If the skill runs a script, inline the exact invocation with every flag.

## Step 4 - Record

Every skill ends the same way: write the output to `output_location`, refresh
whatever summary file it belongs to, and append one line to `_ops/log.md`.

## Boundary: when this does NOT apply

Name the adjacent cases and the skill that owns each. Be concrete. This section
and the `description` boundary clause say the same thing twice on purpose,
because one is read by the assistant while routing and the other while working.

## Non-negotiables

Three to five lines. The rules that make the output wrong if broken, not general
good practice.

## Review before delivering (required)

A short checklist for the human who finishes the work. Every customer-facing
skill has one. The skill does about 70 percent; a person adds the judgment.

## Things that have gone wrong before

A running list, newest last, in the house shape:

- **<the rule>.** Why: <the reason>. (<date>, <what happened>)

This section is the reason a skill gets better instead of just getting longer.
Add to it whenever something produced a wrong output, and say what went wrong
rather than only what to do instead.

## Folders

- `references/` - longer material loaded on demand. Point at it by name from the
  steps above; do not inline it here.
- `assets/` - templates, tokens, images. Keep it small; the whole folder is
  mirrored and, for some owners, changes here escalate rather than auto-promote.
