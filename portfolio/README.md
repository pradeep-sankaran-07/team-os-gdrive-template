# portfolio - the customer book

The cross-portfolio view: every customer side by side, so somebody can answer
"who is off track this week" without opening twelve folders.

## Why this folder is special

It is the **single named exception** to the rule that money does not go in
files. A portfolio dashboard without per-customer values is not much use, so
this folder may hold them, on two conditions that are not negotiable:

1. **Per-customer figures only.**
2. **Never a company-wide total.** A sum across all customers is company
   revenue. Risk is reported as a **share of the portfolio**, never as an amount.

The exception covers this folder and no other path. Giving it its own top-level
folder is what makes the exception auditable: anyone can check whether it is
being respected by looking in one place.

## How to open the dashboard

Open `dashboard.html`. From the Drive mount it opens like any file. **A plain
Drive web link renders blank**, because Drive's preview does not run JavaScript.
That is what `apps-script/serve-dashboard.gs` is for: it serves the same file at
a stable internal URL for people without the mount.

## Files

Paths below are the defaults. The operative values are in `config.yaml`
`customer_dashboard`, and the skill reads them from there.

| File | What it is |
|---|---|
| `dashboard.html` | The build output. Self-contained, no external calls. |
| `crosswalk.csv` | One customer, one row, mapped across every system. |
| `revenue.csv` | The normalised value export: company, month, value. |
| `revenue.meta.json` | Where that export came from and what is assumed about it. |
| `snapshots/<date>.json` | One per build, for week-on-week comparison. |
| `_raw/<date>-<source>.csv` | The untouched original drop. Never edited. |

## Two habits worth copying

**Every data drop keeps a `.meta.json` sidecar** recording where it came from,
when, who exported it, how many rows, what period, what was dropped, and every
assumption that is not confirmed. Writing down `currency_confirmed: false` is
more useful than quietly picking one.

**Nothing is silently excluded.** A row that is out of scope stays, prefixed
`_excluded_`, with a written reason. A customer that vanishes from a dashboard
looks exactly like a customer that was never there.

## If it looks blank or stale

Blank usually means it was opened through the Drive web preview. Use the Apps
Script URL.

Stale means the value export is older than `revenue_stale_days` in
`config.yaml`. The dashboard suppresses derived risk bands rather than showing
old ones as current, and says so on the page. That is deliberate.

## Who to ask

Technical owner: `config.yaml` `admin.runner`. Business owner: whoever owns
customer success.
