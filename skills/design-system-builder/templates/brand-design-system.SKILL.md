---
name: {{brand}}-design-system
description: |
  Use when designing or redesigning any page in the {{Brand}} web app —
  {{page families: landing, marketing, profile, dashboard…}}. Triggers:
  "design", "redesign", "polish", "make it look better", "build a page",
  "build a section", "improve styling", "make it on-brand", "AI slop",
  "looks like a template". Always read the design plate at
  {{/design-plate}} (source: {{src/app/(marketing)/design-plate/DesignPlateClient.tsx}})
  before proposing visual choices — it renders every allowed primitive
  with sample data and copy-pastable code.
---

# {{Brand}} Design System

Before designing or redesigning any page, **read the design plate first**. It is the live source of truth for every primitive and for what is not allowed.

> Source: `{{plate source path}}`
> Live: `{{/design-plate}}`
> Tokens: `{{docs/design/tokens.md}}`

## Always Do
- **MUST read the design plate** before proposing visual choices. Most surfaces already have an answer.
- **MUST stay inside the vocabulary**: {{signature device 1}}; {{signature device 2}}; {{signature device 3}}. Two-color discipline: `{{accent hex}}` (+ `{{deep}}` / `{{soft}}`) + {{neutrals}} only.
- **MUST reuse `{{@/components/<system>}}` primitives**: {{list exports with one-line purpose}}.
- **MUST call out any new pattern** before proposing it — name what's new, why no existing primitive fits, and add it to the plate before shipping.
- **MUST run the sweep before committing**: `scripts/brand-sweep.sh` (or `grep -nE "{{offbrand regex}}"`). Replace every hit.

## Never Do
- NEVER use `{{amber|emerald|blue|indigo|violet|rose|orange|fuchsia}}-*` utilities. Accent is `{{accent}}`; everything else neutral.
- NEVER use `font-serif` or any face other than `font-display` ({{display}}), `font-sans` ({{body}}), `font-mono` ({{mono}}).
- NEVER ship social-template chrome — generic Save/Share pills, Discord/Twitter buttons, Slack-style sidebar, Reddit-style profile masthead.
- NEVER use stock placeholder names ("John Doe", "Jane Smith", "Marcus Chen") or unsplash people photos. Missing data → branded empty state or hide the section.
- NEVER reach for canonical Tailwind UI patterns: hero + 3 equal gradient cards, 1+4 photo mosaic, circle-node horizontal stepper, avatar grid, three-color icon palette.
- NEVER tricolon a headline ("Clearer X, stronger Y, better Z"). Two assertions beat three platitudes.
- NEVER add a typeface or accent color without adding it to the plate first.
- NEVER duplicate a primitive inline. Import it.
- {{project-specific never #1 — a pattern that already shipped and got killed}}
- {{project-specific never #2}}

## Workflow
1. Identify the page's role ({{landing / profile / dashboard / reference}}).
2. Read the plate section that matches.
3. List the primitives needed. All exist → you're composing, not creating.
4. Missing primitive → propose on the plate first.
5. Compose. Hand-roll only what the system truly lacks.
6. Run the sweep. Fix hits.
7. Re-read the plate's Rules chapter; none should apply to your output.

## Tone
{{Voice sentence from tokens.md — e.g. "Editorial, not corporate. Confident and quiet. When in doubt: less color, more hairline rules; less ornament, more typography; less symmetry, more rhythm."}}
