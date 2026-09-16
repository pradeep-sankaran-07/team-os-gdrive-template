---
name: acme-brand
description: >
  Apply the Acme Corp visual standard to any output: documents, decks,
  spreadsheets, HTML reports and charts. Load this whenever producing any
  company deliverable, on top of whatever other skill is running.
  Triggers: "make it branded", "add the logo", "use our branding", or any
  request for a report, deck, brief, one-pager or chart that leaves someone's
  screen. NOT for product UI (that is the product design system) and NOT for
  deciding what a public document may claim (use acme-marketing).
when_to_use: Every formal or company-facing artifact, in any format, without being asked.
inputs:
  - the content to be laid out
  - assets/tokens/colors.css and assets/tokens/type.css
output_location: "wherever the calling skill files its output"
owner: maya-chen
status: PUBLISHED v1.0 (2026-09-16)
last_updated: 2026-09-16
---

# Acme brand

The single source of visual truth. Every other skill consumes these values and
none of them redefines a colour or a font. If you find a hex or a font name
written literally inside another skill, that is a bug; move it here.

## Step 1 - Read the tokens

Read `assets/tokens/colors.css` and `assets/tokens/type.css`. Use the token
names, not the literal values, wherever the output format allows it (CSS, HTML,
themes). Where the format cannot take a variable, copy the value from the token
file rather than from memory.

## Step 2 - Apply the standard

| Element | Rule |
|---|---|
| Primary | `--acme-primary` |
| Accent | `--acme-accent`, used sparingly, for emphasis only |
| Ink and surfaces | `--acme-ink`, `--acme-surface`, `--acme-muted` |
| Headings | the display face in `type.css` |
| Body | the text face in `type.css` |
| Office fallback | a system face, for `.docx` and `.xlsx` only, where the brand faces cannot embed |
| Logo | top left of the first page or slide, clear space equal to the logo height |
| Footer | see below |

The footer text is `Acme Corp`, then the domain, then `Confidential`, separated
by pipes.

Charts follow the same palette: primary for the main series, accent for the one
series being pointed at, muted greys for everything else. Never rainbow a chart.

## Step 3 - Check before delivering

- The logo is present and not stretched.
- Every colour in the file appears in `colors.css`. A near-miss hex is invisible
  to the eye and wrong in the file, and the skill promotion gate rejects it.
- No em dashes, anywhere.
- The footer is on every page.

## Boundary: when this does NOT apply

- Product screens and prototypes. This template ships no product-UI skill; if
  you build a product, add one. Do not put a document header and footer on an
  app screen.
- Deciding what a public document is allowed to say: that is `acme-marketing`.
  This skill controls how it looks, not what it claims. Answer both questions.
- Generating an image: `create-branded-image` owns that, and it applies the
  house photographic style rather than this document layout.

## Non-negotiables

- One source of truth for colour and type. Never redefine a value locally.
- If the logo file is not in the session and not in `assets/`, ask for it before
  producing the deliverable. Do not substitute a placeholder and do not draw one.
- The footer's confidentiality line stays on internal documents even when they
  look polished.

## Things that have gone wrong before

- **Change a font in one pass, everywhere, or not at all.** Why: a font name
  written literally into a dozen places, with half of them updated, leaves the OS
  producing two different looks depending on which skill ran. That is what the
  token file is for. (2026-09-16)
