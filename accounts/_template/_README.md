# Account template

Copy this folder to `accounts/<slug>/` to create an account. The account must
already be a row in `_customer-list.csv`; the roster comes first.

| File | What it is |
|---|---|
| `profile.md` | Stable facts. Changes rarely. The commercial terms live here and nowhere else. |
| `summary.md` | Current state. Rewritten as things change, by merging, never by regenerating. |
| `calls/` | One file per call. Append only. |
| `emails/` | One condensed note per substantive thread. Append only. |
| `documents/` | Deliverables, and originals shared with us. |

Filenames everywhere: `<yyyy-mm-dd>-<author-slug>-<kebab-topic>.md`. The date
leads so folders sort chronologically. The author slug is in it so two people
filing on the same day never collide.

A document someone shared with us is kept as the original file, with a
same-named `.md` note next to it holding the condensed version and a pointer
back. Read the note for everyday context; open the original for depth.
