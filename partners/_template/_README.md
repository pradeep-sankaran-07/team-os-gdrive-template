# Partner template

Copy to `partners/<slug>/`. The partner must already be a row in
`_partner-list.csv`.

Same shape as an account: `profile.md` for stable facts, `summary.md` for
current state, `calls/` and `documents/` append-only, same filename convention.

Two differences that matter:

- `status` uses the partner vocabulary, which includes `paused` and `offboarded`.
- `## Commercial` holds what we pay them. Our own margin and what we charge
  customers do not appear here, ever.
