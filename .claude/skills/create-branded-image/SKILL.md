---
name: create-branded-image
description: >
  Generate original, on-brand Acme images. Use whenever someone wants a picture
  made rather than written: a marketing or campaign visual, a blog featured
  image, a social or ad image, a banner, a hero, an event or booth graphic, an
  illustration, a placeholder or mockup.
  Triggers: "create an image", "generate a visual/graphic", "make a picture
  of...", "I need a hero image for...", "a featured image for the blog", "a
  banner for the event".
  This applies BY DEFAULT to every image made for the company, the same way
  acme-brand applies to every document. Nobody has to ask for it. The only
  opt-out is an explicit "unbranded" or "in the customer's branding".
  NOT for charts or data visualisations, NOT for diagrams and flowcharts, NOT
  for product UI screens, and NOT for laying out a document (use acme-brand).
when_to_use: Any request whose deliverable is a picture rather than text.
inputs:
  - what the image is for, and where it will appear
  - .claude/skills/acme-brand/assets/tokens/colors.css
  - references/house-style.md
output_location: "outputs/<person-slug>/images/<yyyy-mm-dd>-<topic>/"
owner: maya-chen
status: DRAFT
last_updated: 2026-09-16
---

# Create a branded image

This skill is mandatory by **output type**. Assume every image represents the
company unless told otherwise. The opt-out is explicit words like "unbranded" or
"in the customer's branding", never your own judgement that this one probably
does not matter.

## Step 1 - Establish the brief

What is the image for, where will it appear, and what aspect ratio does that
placement need? A hero, a social card and a booth panel are three different
images, and producing one of them for all three placements wastes the run.

## Step 2 - Build the prompt from the house style

Read `references/house-style.md` and compose the prompt from it. Do not
hand-roll a prompt and do not fall back to a generic look: the house style is
the whole reason this skill exists rather than a raw image call.

Take colour from `acme-brand`'s token file, by value, at prompt time.

## Step 3 - Generate and file

Produce the requested number of variants. File them to `output_location` with a
one-line `README.md` in the folder saying what the brief was, so a variant found
six months later is identifiable.

## Step 4 - If it will be published

`acme-marketing` runs alongside this skill. This one makes the picture; it does
not decide what the picture is allowed to claim or imply.

## Non-negotiables

- Never render a real company's logo or trademark, including Acme's own. The
  logo is composited afterwards from the brand assets, never generated.
- Never generate an image of an identifiable real person.
- Never present a generated image as a photograph of an actual customer,
  facility or event.

## Things that have gone wrong before

- **Generated logos are always wrong.** Why: a model reproduces the shape of a
  mark without its geometry, and the result passes a glance and fails a brand
  review. Composite the real asset instead. (2026-09-16)
