# Partners

> **Demo content.** Every partner, person and figure under `partners/` is
> invented for this template. Delete all of it during install.

One folder per partner, mirroring `accounts/`. `_partner-list.csv` is the source
of truth; this is a generated view.

Status vocabulary: `prospect` | `onboarding` | `active` | `paused` | `offboarded`.

## The confidentiality direction is reversed here

In `accounts/`, a customer's own commercial terms stay in their folder. Here, a
**partner's costs** stay in their folder, and **our own margin and what we
charge customers never enter `partners/` at all**, in any file, in any form.

The reason is not symmetry. It is that partner folders get shared with partners,
and account folders do not.

## Why partners are a separate top level rather than a kind of account

They are the other side of the same transaction. Different roster, different
status vocabulary, opposite confidentiality direction, and a different set of
people looking after them. Merging them would mean one of those rules quietly
applying to the wrong records.

They stay linked by a cross-posting rule: anything said on a partner call that
concerns a customer is copied into that account's `calls/`, and anything a
customer says about a partner is copied here.

## Partners

| Partner | Type | Status | Owner | Folder |
|---|---|---|---|---|
| Ferrowind Data | data-vendor | active | tobias-frank | [ferrowind-data](ferrowind-data/) |
| Fieldpost Agency | reseller | active | priya-nair | [fieldpost-agency](fieldpost-agency/) |
