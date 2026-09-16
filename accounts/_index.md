# Accounts

> **Demo content.** Every company, person and figure under `accounts/` is
> invented for this template. Any resemblance to a real company is accidental.
> Delete all of it during install; see INSTALL.md phase 3.

One folder per customer and prospect. `_customer-list.csv` is the source of
truth; this file is a generated view. **If they disagree, the CSV wins.**

Stage vocabulary: `prospect` | `onboarding` | `active` | `churned`.

Money is not in this file and not in the CSV. Commercial terms live only in each
account's `profile.md`, under `## Commercial`.

## Active and in flight

| Account | Stage | Health | Owner | Domain | Folder |
|---|---|---|---|---|---|
| Northwind Software | active | amber | sam-okafor | northwind.example | [northwind-software](northwind-software/) |
| Calderwick Media | active | amber | sam-okafor | calderwick.example | [calderwick-media](calderwick-media/) |
| Ashgrove Analytics | onboarding | green | sam-okafor | ashgrove.example | [ashgrove-analytics](ashgrove-analytics/) |
| Harlowe Security | prospect | amber | lena-vossen | harlowe.example | [harlowe-security](harlowe-security/) |

## Churned

| Account | Left | Owner | Folder |
|---|---|---|---|
| Harborline Logistics | 2026-07-31 | priya-nair | [harborline-logistics](harborline-logistics/) |

Churned folders stay. They are swept weekly rather than every run, and they are
where the honest answer to "why do we lose deals like this" lives.

## Adding an account

Add a row to `_customer-list.csv`, then copy `_template/` to
`accounts/<slug>/`. An account that is not on the CSV is never created by
ingestion, however much mail arrives from that domain.
