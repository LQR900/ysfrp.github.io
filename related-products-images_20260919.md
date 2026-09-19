# Task Artifact — Add "Related Products" images to 10 SEO product pages

**Date:** 2026-09-19
**Workspace:** `E:\文档\ysfrp`
**Files touched:** `{slug}\index.html` for all 10 product slugs (UTF-8 with BOM)

## Objective
For each of the 10 SEO product pages, insert a product thumbnail image (or placeholder)
BEFORE each `<h3>` in the "Related Products" section, and add a hero background-image
where applicable.

## Key findings / reasoning
- **Thumbnails do not exist.** No `assets\images\{slug}-thumbnail.webp` file exists
  (nor `frp-radome-sphere-thumbnail.webp`). Therefore every insert used the
  **placeholder** branch, except the `frp-radome` mapping which the task explicitly
  says to **skip** when its file is missing.
- **Hero images do not exist.** No `assets\images\{slug}-hero.webp` file exists.
  No page uses `class="page-hero"` or `id="hero"`; the hero is
  `<section class="page-header">` with a CSS gradient background. Per the "(if it exists)"
  condition, **no hero changes were made** on any page.
- **Two page variants exist** (matters for future edits):
  - **Group A** (frp-radome, fiberglass-enclosure, custom-frp-shell, carbon-fiber-shell,
    usv-hull): Related cards are compact/single-line; each `.product-top` carries a
    **broken** `style="background-image: url(' + $info.image + ');"` (literal, pre-existing bug).
  - **Group B** (frp-speaker-housing, robot-enclosure, frp-fan-blade, ev-charging-cover,
    custom-composite-parts): Related cards are multi-line and `.product-top` **already has
    a real `<img>`** (`.product-photo`). The new standardized block was still inserted
    before each `<h3>` per the explicit instruction, so Group B cards now show the existing
    top image **and** the new placeholder.
- **Reliable anchor:** `<div class="product-info">` occurs exactly 4× per page and only
  inside the Related Products grid, so insertion was anchored as
  `<div class="product-info">…<h3>`.

## Results (per page)
| Page | Matches | Real img | Placeholder | Skipped (radome) | Errors |
|---|---|---|---|---|---|
| frp-radome | 4 | 0 | 4 | 0 | – |
| fiberglass-enclosure | 4 | 0 | 3 | 1 | – |
| custom-frp-shell | 4 | 0 | 3 | 1 | – |
| carbon-fiber-shell | 4 | 0 | 3 | 1 | – |
| usv-hull | 4 | 0 | 3 | 1 | – |
| frp-speaker-housing | 4 | 0 | 3 | 1 | – |
| robot-enclosure | 4 | 0 | 3 | 1 | – |
| frp-fan-blade | 4 | 0 | 3 | 1 | – |
| ev-charging-cover | 4 | 0 | 4 | 0 | – |
| custom-composite-parts | 4 | 0 | 3 | 1 | – |

**Totals:** 32 placeholder blocks inserted, 8 skipped (frp-radome related entries),
0 real images (no thumbnail files exist). Hero status: unchanged on all 10 (no hero files exist).

## Verification
- All 10 files re-written with UTF-8 **BOM** (bytes `EF BB BF`) — confirmed.
- Emoji bytes in placeholders verified as `F0 9F 93 B7` (📷).
- Inserted markup is div-balanced.
- Backups: `%TEMP%\ysfrp_idx_backup_20260919_110314\` (10 original `index.html`).

## Notes / follow-ups for the main agent
1. **Group B already had real related-product images** in `.product-top`. The literal
   instruction inserted placeholders *in addition*, producing two visuals per card
   (existing top image + "Photo Coming Soon" placeholder). Decide whether to (a) drop the
   Group B placeholders, or (b) replace the existing top images. Flag for user.
2. **Group A `.product-top` background-image is broken** (literal `' + $info.image + '`),
   pre-existing; out of scope but worth fixing.
3. Provide the real `{slug}-thumbnail.webp` assets and re-run to swap placeholders for images.
