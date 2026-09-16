# {{BRAND}} — Design Tokens (source of truth)

## Product & audience
- One line: {{what the product is}}
- Primary reader: {{who}} — reading on {{device/context}}

## Voice
- Is: {{adj1}}, {{adj2}}, {{adj3}}
- Is not: {{anti1}}, {{anti2}}, {{anti3}}
- Reference points: {{site/magazine 1}}, {{2}}, {{3}}
- Rule of thumb: "{{e.g. reads like a reference spread in a design magazine, not a SaaS landing}}"

## Color (two-color discipline)
| Token | Hex | Use | Never |
|---|---|---|---|
| `brand.accent` | `{{#RRGGBB}}` | numerals, active dots, links, one rhythm word per headline | large fills, backgrounds |
| `brand.accentDeep` | `{{#RRGGBB}}` | italic rhythm word, hover | |
| `brand.accentSoft` | `{{#RRGGBB}}` | subtle tints, 35% numerals | |
| `brand.ink` | `{{#RRGGBB}}` | body text | |
| `brand.slate` | `{{#RRGGBB}}` | secondary text, hairlines | |
| `brand.paper` | `{{#RRGGBB}}` | page background | |
| `brand.cream` | `{{#RRGGBB}}` | card / section background | |

Off-brand (sweep fails on these Tailwind families): `{{amber|emerald|blue|indigo|violet|rose|orange|fuchsia}}`

## Type (three faces max)
| Role | Face | Load via | Weights |
|---|---|---|---|
| display | `{{Fraunces / Playfair / …}}` | `next/font/google` | {{300i, 500}} |
| body | `{{Geist / Inter / …}}` | `next/font/google` | {{400, 500}} |
| mono | `{{Geist Mono / JetBrains Mono}}` | `next/font/google` | {{400}} |

Tailwind: `font-display`, `font-sans`, `font-mono`. Off-brand: `font-serif`, any other `font-*`.

Type ramp: h1 `{{text-5xl lg:text-6xl}}` · h2 `{{…}}` · lede `{{…}}` · body `{{text-base}}` · caption `{{text-sm}}` · microcaption `{{text-[10px] font-mono uppercase tracking-[0.24em]}}`

## Space / shape
- Section rhythm: `{{py-16 lg:py-24}}`; hairline between sections: `{{border-t border-slate-200/60}}`
- Radius: `{{rounded-none / rounded-sm}}` (pick one, everywhere)
- Shadow: `{{none — use hairlines}}`
- Max text measure: `{{max-w-prose}}`

## Signature devices (what makes it recognizably {{BRAND}})
1. {{e.g. oversized accent/35 numerals `tabular-nums` as chapter markers}}
2. {{e.g. one italic light accent word per headline}}
3. {{e.g. mono uppercase kicker · hairline · right label as section ToC}}

## Logo / wordmark
- Files: `{{path}}`; component: `<{{Brand}}Wordmark />`
- Clear space: {{x}}; min size: {{px}}
- Never: stretch, recolor outside accent/ink, place on busy photo
