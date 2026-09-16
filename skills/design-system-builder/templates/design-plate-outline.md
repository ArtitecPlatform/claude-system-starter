# Design Plate — route outline

Route: `/design-plate` (marketing group, no auth, `noindex`). One client component, e.g. `DesignPlateClient.tsx`.
Each section = heading + rendered primitive with sample data + `<pre>` snippet of the exact JSX to copy.

| # | Section | Renders | Snippet exports |
|---|---|---|---|
| 0 | Masthead | "Vol. 00 — Design Plate" editorial bar, rhythm-word title | `EditorialBar`, `PageTitle` |
| 1 | Type ramp | h1…h6, lede, body, caption, microcaption, numerals | class strings |
| 2 | Color plate | swatch + hex + "use for / never for" | token names |
| 3 | Chapter wrapper | kicker · hairline · label, then content | `Section` |
| 4 | Cards | ref card, stat card, media card (image `object-contain` for logos), empty-state card | `RefCard`, `StatCard`, `MediaCard`, `EmptyCard` |
| 5 | Data displays | fact grid, key-value list, timeline, progress, table | `FactGrid`, `KeyValue`, `Timeline`, `Progress` |
| 6 | Forms | input, select, textarea, toggle, submit, error state, sticky rail form | `Field`, `RailForm` |
| 7 | Navigation | header, footer, breadcrumb, tabs, pagination | `Header`, `Footer`, `Tabs` |
| 8 | Feedback | toast, inline error, skeleton, empty state | `Toast`, `Skeleton`, `Empty` |
| 9 | Media | gallery + lightbox, map surface (if any) | `Gallery`, `MapFrame` |
| 10 | Rules | the NEVER list, rendered as a checklist | — |

Acceptance:
- Every primitive used by any page appears here. Grep pages for components not on the plate → add or delete.
- Sample data is realistic but clearly sample (no "John Doe"; use the brand's own domain nouns).
- Page passes `scripts/brand-sweep.sh`.
- Linked from the project `.claude/CLAUDE.md` under "Design System — read before any page design".
