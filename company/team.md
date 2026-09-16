# Team

Prose counterpart to `config.yaml` `people`. If the two disagree, `config.yaml`
wins: it is what the routines read.

**Demo content.** Every person here is fictional.

| Person | Role | Owns | Ask them about |
|---|---|---|---|
| Maya Chen | CEO | company, marketing | positioning, what we may claim publicly, brand |
| Diego Ramirez | Head of Product | product, engineering | roadmap, what ships when, technical feasibility |
| Priya Nair | Head of Sales | sales | pipeline, pricing, anything commercial |
| Lena Vossen | Account Executive | sales, prospects | live deals, competitive situations |
| Sam Okafor | Customer Success Manager | customer-success, onboarding | any active customer, onboarding status, renewals |
| Tobias Frank | RevOps, and the Team OS admin | operations, team-os | this folder, access, the daily routine, the dashboard |

## Access

Everyone is in the team group: read everywhere, write in `accounts/`, `outputs/`
and `_ops/`. Tobias and Maya are also in the admin group, which is Manager on
the whole drive. See [ACCESS-CONTROL.md](../ACCESS-CONTROL.md).

## Adding someone

Add them to the team group. That is the only manual step. Their `outputs/`
folder is created by their first session and the daily admin routine folds them
into `config.yaml` overnight. Then send them `START-HERE.md`.

Do not hand-edit `config.yaml` to add a person, and do not add them to the
roster before they have access: the order matters, because their first session
needs to be able to write.
