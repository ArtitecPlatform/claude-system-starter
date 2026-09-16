---
name: design-system-builder
description: |
  Use when a project has no design system yet and the user wants one built
  from their brand — fonts, colors, tone, logo — or wants a "design plate"
  (a live page that renders every UI primitive with copy-pastable code) and
  a project skill that enforces it. Triggers: "create a design system",
  "set up our brand styles", "design template", "style guide", "design
  plate", "make Claude design on-brand", "our pages look like AI slop",
  "everything looks like a Tailwind template", "define our fonts and colors".
  Produces: brand tokens, a live design plate page, a sweep script, and a
  generated `<brand>-design-system` skill that auto-loads on design verbs.
---

# Design System Builder

Builds a **brand design system** for a web project in four artifacts, then generates a
project skill so every future "design / redesign / polish" request stays on-brand.

| Artifact | What | Where it lands |
|---|---|---|
| Brand tokens | 2 accent colors max + neutrals, 2–3 typefaces, spacing/radius, tone words | `tailwind.config.*` / CSS vars + `docs/design/tokens.md` |
| Design plate | One live route rendering **every** primitive with sample data + code snippet | `/design-plate` (e.g. `src/app/(marketing)/design-plate/`) |
| Sweep script | grep that fails on off-brand colors/fonts | `scripts/brand-sweep.sh` |
| Project skill | `<brand>-design-system` — MUST/NEVER rules + workflow, triggers on design verbs | `.claude/skills/<brand>-design-system/SKILL.md` |

The plate is the gating mechanism: **anything not on the plate is not part of the system yet.**

## When NOT to use
- Project already has a design plate / style guide → use its own `<brand>-design-system` skill instead.
- User wants a single page designed → `frontend-design` or `ui-ux-pro-max`, then this skill only if they ask to systematize.

## Workflow

### 1. Brand intake (10 min, ask, don't guess)
Fill `templates/tokens.md` with the user. Minimum answers:
- **Product in one line** and **who reads it** (buyer, operator, investor…).
- **Voice**: 3 adjectives + 3 anti-adjectives (e.g. "editorial, quiet, confident" / not "loud, playful, corporate").
- **Reference sites/magazines** they admire (2–3). Screenshots > adjectives.
- **Colors**: 1 primary accent (+ light/dark variants), 1 optional secondary, neutrals (ink/slate/cream/paper). Refuse a third accent — "differentiate categories by color" is the template tell.
- **Type**: display face, body face, mono face. Check licenses. Google Fonts / Fontsource fine.
- **Logo/wordmark**: file + minimum clear-space + never-do list (no stretching, no recolor).
- **Existing pain**: which current pages feel generic? Those become the first redesign targets.

### 2. Encode tokens
- Tailwind: add `colors.brand.{accent,accentDeep,accentSoft,ink,paper}` + `fontFamily.{display,sans,mono}` in `tailwind.config.*`. CSS-vars project: `--brand-accent` etc. in `globals.css`.
- Load fonts via `next/font` (or `@fontsource/*`) — never a `<link>` to a random CDN in a component.
- Write `docs/design/tokens.md` (hex values, font stacks, spacing scale, radius, shadow rules, tone words). Single source of truth outside code.

### 3. Build the design plate
Create one route (`/design-plate`) that renders, in order, with sample data and a `<pre>` code snippet beside each:
1. **Editorial bar / masthead** — page kicker, volume/section label, title with the brand's "rhythm" device (e.g. one italic word in accent).
2. **Type ramp** — h1…h6, lede, body, caption, microcaption (mono uppercase tracking) — every size that's allowed.
3. **Color plate** — swatches with hex + usage note ("accent: numerals, active dots, links — never fills").
4. **Section wrapper** — the chapter component every page section uses (heading + hairline + content).
5. **Cards** — ref card, stat card, media card, empty-state card.
6. **Data displays** — fact grid/table, key-value list, timeline, progress.
7. **Forms** — input, select, textarea, toggle, submit, validation state, sticky rail form.
8. **Navigation** — header, footer, breadcrumb, tabs, pagination.
9. **Feedback** — toast, inline error, loading skeleton, empty state (brand vocabulary, no stock names).
10. **Rules chapter** — the NEVER list rendered on the page itself, so designers and Claude see it.

Extract each primitive into `src/components/<system>/` and export from an index. Pages compose; they do not hand-roll.

### 4. Write the sweep
Copy `scripts/brand-sweep.sh`, edit `OFFBRAND_COLORS` / `OFFBRAND_FONTS` for this project. Wire into `npm run lint` or a pre-commit hook. Exit non-zero on hits.

### 5. Generate the project skill
Copy `templates/brand-design-system.SKILL.md` to `.claude/skills/<brand>-design-system/SKILL.md`. Replace every `{{PLACEHOLDER}}` with intake answers + real component names + real paths. Add the "Never Do" items the user already suffered (their genericized pages). Commit.

### 6. Prove it
Redesign one of the "pain" pages using only plate primitives. Run the sweep. Compare before/after screenshots with the user. If a primitive was missing, add it to the plate **first**, then the page.

## Hard rules for the system you produce
- **Two-color discipline.** One accent (+ its tints) and neutrals. A second accent only with a written reason on the plate.
- **Three typefaces max**: display, body, mono.
- **Every primitive lives on the plate** with a code snippet. No snippet, not a primitive.
- **The NEVER list is concrete.** Name the template patterns to kill (hero + 3 equal gradient cards, avatar grid, circle-node stepper, three-color icon palette, "John Doe" placeholders, tricolon headlines). Vague rules don't stop AI-slop; named patterns do.
- **Empty states over fake data.** If the data isn't there, render a branded empty state, never a placeholder name or unsplash photo.

## Resources
| File | Use |
|---|---|
| `templates/tokens.md` | Brand intake worksheet → becomes `docs/design/tokens.md` |
| `templates/design-plate-outline.md` | Section-by-section spec for the plate route |
| `templates/brand-design-system.SKILL.md` | Template for the generated project skill |
| `scripts/brand-sweep.sh` | Off-brand color/font grep, exit 1 on hits |
