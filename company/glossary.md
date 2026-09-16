# Glossary

Terms used across this OS, so the assistant and a new joiner mean the same thing.

| Term | Meaning |
|---|---|
| Account | A customer or prospect with a folder under `accounts/`. Only entries on `accounts/_customer-list.csv` qualify. |
| Stage | `prospect`, `onboarding`, `active` or `churned`. Lives in `profile.md` and the roster CSV. |
| Health | `green`, `amber` or `red`. Inferred from evidence, never hand-set. Lives in `summary.md`. |
| Rep | One AI sales rep. The unit we price on. |
| Sequence | An ordered set of outbound steps across channels. |
| Reply handling | Classifying an inbound reply as interested, objection, out of office or unsubscribe, and routing it. |
| Deliverability guardrails | Warmup, per-mailbox caps and domain health monitoring. Automatic pausing on rising spam signals is the target state, not what ships today. |
| Seeded | An account whose first all-time ingest sweep has completed. Tracked in `accounts/_sweep-state/`. |
| Giving | Feeding context into the shared OS, measured as accounts seeded. |
| Taking | Getting work out of the OS, measured as deliverables produced. |
| Marker | An empty file recording that a session happened. All metadata is in the filename. |
| Surface | Where someone is working: Cowork, the connector on a phone, or a CLI. |
| Drop | An owner's working copy of a skill in their `outputs/` folder, awaiting promotion. |
| Tier | Account size band in the portfolio crosswalk: 1 largest, 3 smallest. |
| Confidence | How well a crosswalk row is evidenced: `high`, `medium` or `low`. |
| Health (partner) | Same three values as an account, inferred from delivery performance, responsiveness and open issues. |
