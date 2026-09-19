# Task Artifact: Add Blog Cover Images as Hero Backgrounds

**Date:** 2026-09-19
**Workspace:** E:\文档\ysfrp
**Target dir:** E:\文档\ysfrp\blog\

## Objective
For each of the 7 blog article HTML files, locate the page-hero `<section>` and add a
`background-image` style so the article's cover WebP displays as the hero background.
Write files back as UTF-8 **with BOM**.

## What was found
- All 7 files existed and shared the same hero pattern: a `<section>` whose inline
  `style` begins with `background: linear-gradient(135deg, ...)` and `padding: 120px 0 60px;
  text-align: center;` (2 files also carry `class="page-header"`).
- The hero was matched uniquely via regex on `<section ... style="...linear-gradient...">`
  (the only other `linear-gradient` in each file is a `<div>` card, not a section).
- Every file already had a clear, descriptive `<h1>` (no H1 text changes needed).
- Files already carried a UTF-8 BOM; rewritten with BOM to stay consistent.

## Style added to each hero (appended to the existing `style` attribute)
```
background-image: url('/assets/images/blog-XXX-cover.webp'); background-size: cover; background-position: center;
```
(where `XXX` is the per-article slug). The existing gradient + padding + text-align were kept.

## Files updated (7 / 7)
| File | Cover image | H1 (unchanged) |
|------|-------------|----------------|
| cimie-2026-exhibition.html | /assets/images/blog-cimie-2026-exhibition-cover.webp | Yasheng FRP Exhibits at CIMIE 2026 |
| frp-automotive-trends.html | /assets/images/blog-frp-automotive-trends-cover.webp | FRP in Automotive: Lightweighting the Next Generation |
| frp-enclosures-equipment.html | /assets/images/blog-frp-enclosures-equipment-cover.webp | How FRP Enclosures Protect Sensitive Equipment |
| frp-manufacturing-process.html | /assets/images/blog-frp-manufacturing-process-cover.webp | FRP Manufacturing Process: From Mold to Finished Shell |
| frp-vs-traditional-materials.html | /assets/images/blog-frp-vs-traditional-materials-cover.webp | FRP vs Traditional Materials: A Comprehensive Comparison |
| how-to-choose-frp-radome.html | /assets/images/blog-how-to-choose-frp-radome-cover.webp | How to Choose the Right FRP Radome for Your Application |
| rise-of-usv-hulls.html | /assets/images/blog-usv-hulls-ocean-tech-cover.webp | The Rise of USV Hulls in Modern Maritime Operations |

## Files NOT found / no hero section
- None. All 7 files were located and contained a hero `<section>`.

## Notes
- Implementation detail: `-replace` with a scriptblock is PowerShell 6+ only; this host
  runs Windows PowerShell 5.1, so `[regex]::Replace(..., MatchEvaluator)` was used instead.
- Post-edit cleanup removed a harmless double semicolon (`center;; background-image`) that
  arose from joining the original trailing `;` with the appended `;`. Final files contain 0
  `;;` and retain the UTF-8 BOM.
- CSS behavior: because the appended `background-image: url(...)` appears after the
  `background:` gradient shorthand in the same attribute, the cover image becomes the active
  hero background (the gradient is overridden). White H1 text sits over the cover image.
