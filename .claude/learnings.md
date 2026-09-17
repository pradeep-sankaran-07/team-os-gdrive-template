# Learnings

Accumulated rules and patterns. Add here when a skill or routine should behave
differently next time.

**The shape of an entry is not optional**, because it is what makes this file
worth keeping:

> **The rule.** Why: the reason. (date, the incident that produced it)

A rule without its reason gets deleted by the next person who finds it
inconvenient. A rule without its incident gets argued with. Keep each entry
short, and edit an entry in place as it moves from proposal to resolved rather
than adding a second one.

---

- **Derive a person's identity from the session, never gate it on the roster.**
  Why: a roster-gated lookup blocks every new joiner behind an admin edit of a
  file only admins can write, so the first thing a new person experiences is a
  failure. The roster overrides the derived slug; it never blocks. (2026-09-16)

- **Every surface writes a session marker, including the ones with hooks.** Why:
  a hook only fires on a machine that has it installed. Excluding the hooked
  surfaces on the assumption they were already covered erases the recorded
  activity of everyone without one, so somebody who did a full week of work
  reads as completely inactive. Duplicates cost nothing; the rollup dedupes to
  one active day per person per date. (2026-09-16)

- **Never read absence of a signal as absence of work.** Why: the instrumentation
  only sees writes. Someone who reads the OS all day leaves no trace it can
  count. Report active days as a floor and say so, and never label the group with
  no recent writes "silent": that word describes the instrumentation, not the
  person, and it reads as an accusation. (2026-09-16)

- **Never use file modification times as evidence of activity.** Why: mtimes
  shift when a synced drive resyncs, so a person whose access is completely
  blocked can read as one of the most active people on the team. (2026-09-16)

- **Mirror verbatim; never find-replace across a mirror.** Why: a blind
  substitution of one tool's name for another's across a copied skills tree
  produced a mirror that referenced a model which did not exist and paths that
  went nowhere, and nothing compared the two trees so it survived for weeks.
  Skills are model-neutral prose: nothing in one should name a tool in the first
  place. (2026-09-16)

- **Model ids live in `config.yaml` and nowhere else.** Why: a model name written
  into a skill is invisible at upgrade time, and the skills that got missed keep
  running on the old tier until someone notices the bill or the quality.
  (2026-09-16)

- **Change a shared value everywhere in one pass, or not at all.** Why: a font
  written literally into a dozen places, with half of them updated, leaves the
  system producing two different looks depending on which skill ran. This is what
  a token file is for. (2026-09-16)

- **Re-read immediately before writing, and merge.** Why: resending a whole field
  from a copy sitting in context silently destroys any edit a person made in
  between, and in systems with no version history that work is simply gone.
  (2026-09-16)

- **Append, never overwrite, for anything two people might write at once.** Why:
  two people sweeping the same shared-domain account produce two files with a
  date-and-author filename, and no conflict. The same operation on one shared
  file produces a lost update. (2026-09-16)

- **Prefer create-only writes for anything team-wide.** Why: it is the only shape
  that works on a surface with connector-grade access and no shell, and it never
  conflicts on a synced drive. Drop a small file; let a daily routine fold it in.
  (2026-09-16)

- **Write the recipe into the state file.** Why: hashes recorded under an
  unspecified procedure are not reproducible, so every later run reads as
  "changed" and the mechanism that depends on them becomes noise. (2026-09-16)

- **A no-op writes no log line; the health pass always writes one.** Why: a log
  full of "nothing happened" is unreadable, but a day with no entry at all is
  indistinguishable from a day the routine did not run. (2026-09-16)

- **Probe what a surface can write, not only what it can read.** Why: two AI
  products can both read this folder correctly and differ completely in what
  they can create. One writes ordinary files; another creates only native Google
  Docs and cannot produce a `.md` at all. Because the reading half works, the
  setup looks healthy, and the failure only surfaces when somebody goes looking
  for a file that was never written. Capability also varies by product rather
  than by device, so a laptop session can fail where a phone session succeeds.
  Test it once per product during install and write down the answer.
  (2026-09-17, found by an early adopter of this template.)

- **Do not end a finished task with an unnecessary question.** Why: a clean
  summary is the finish. A trailing "want me to also..." makes the person do work
  to close the loop. (2026-09-16)
