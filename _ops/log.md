# Activity log

Append-only record of what routines and skills did. **Newest at the bottom.**
One line per action:

`- <YYYY-MM-DD> - <actor> - <action> - <target>: <detail>`

`action` is a small controlled vocabulary: `ingest`, `health-check`,
`kb-refresh`, `roster-reconcile`, `drift-check`, `skill-sync`, plus `build` and
`docs` for meta work that is not a person's activity.

A no-op writes nothing, except the daily health pass, which always writes one
line. A log full of "nothing happened" is unreadable; a day with no entry at all
is indistinguishable from a day nothing ran.

---

- 2026-09-16 - build - build - acme-os: seeded the Team OS from the template with demo content for a fictional company.
