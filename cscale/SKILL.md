---
name: cscale
description: Generate a 12 to 18 month Company Scale strategy report for a real or sales-qualified client. Use when the user types "/cscale <name> <url>", or says "scale this company", "growth plan", "scaling report", "18-month strategy", "department roadmap", "company scaling playbook", or names a company and asks "what should they do next" or "how do they get to $X". Produces a warm-band-themed noindex HTML strategy at public/r/<slug>-cscale.html with 5 to 6 tiered competitors (peer, mid-tier, aspirational), TLDR plus department-by-department action plan, AI optimization layer, and four bonus sections (pivot scenarios, expansion products for existing customers, retargeting from paid leads, investor targeting with peer fundraising data). Orchestrates 12 plus marketing skills. Invocation. Skill('cscale', args='<company-name> <website>') or "/cscale <name> <url>".
metadata:
  version: 1.0.0
  related: [[customer-intelligence-brief]] [[deep-research]] [[competitive-ads-extractor]] [[competitors]] [[competitor-profiling]] [[customer-research]] [[cro]] [[ads]] [[ad-creative]] [[emails]] [[marketing-psychology]] [[programmatic-seo]] [[ai-seo]] [[churn-prevention]] [[sales-enablement]] [[pricing]] [[image]]
---

<!--
  /cscale skill — Company Scale Strategy Report
  Built by Ric S Kolluri at Novatar.ai · MIT licensed · attribution required.
  See LICENSE and README for terms.
-->

# /cscale. Company Scale Strategy Report

## Purpose

A strategic-scaling deliverable, originally built at Novatar.ai for client engagements, now released for general use. The output answers a single question for the target company. Where are you now, where can you be in 18 months, and what does every department do each week to get there? Sold as the planning artifact behind a $10k plus per month retainer expansion, or as a follow-on engagement after the audit and proposal close.

Distinguishing wedge versus a typical audit report (`public/r/<slug>.html`) and the sales proposal (`public/r/<slug>-proposal.html`).

- **18-month horizon, not 30 days.** The audit diagnoses, the proposal sells, the scaling report directs.
- **Tiered competitor map.** Three altitude bands so the company sees its peer, its near-future, and its aspirational ceiling.
- **Department-level execution.** Every department gets named work items, owner role, week of the plan, and success metric.
- **AI agent overlay.** Every department's plan also names the specific AI agent or workflow that compresses the work.
- **Strategic bonuses.** Pivot scenarios, expansion products for existing customers, retargeting plays, and investor targets with comparable fundraising data.

## Signature

```
/cscale <company-name> <website>
```

Examples.

```
/cscale "Acme Med Spa" https://acmemedspa.com
/cscale https://prestonsherry.com         (name inferred from domain)
```

If only one argument is supplied, parse it. URL-shaped input infers the company name from the domain. Otherwise treat it as company name and look up the website (or ask).

## When to invoke

Trigger when.

- A client signs the retainer and needs a north-star plan for the engagement.
- A sales-qualified prospect already has the audit and the proposal and is asking what the next year looks like.
- You explicitly say scaling, growth plan, 18-month plan, or name a company and ask what they need to do to get to a target.
- A team member needs the by-department playbook for an in-progress retainer.

Do NOT trigger this for.

- Free `/audit` submissions. Use the standard audit-report path.
- Voice-interview leads. Use `/interview-to-deck`.
- Pre-engagement $2 to $5k briefs. Use `/customer-intelligence-brief`.
- Single-page CRO or single-campaign asks. Use `/cro`, `/copywriting`, or `/ads` directly.

## Customizing for your AI agent catalog

The methodology references a concrete catalog of AI agents (Cloe receptionist, Maya scheduling, Sam qualified-inbound, Jessica readiness, Rio reviews, Sofia web chat, Gia SMS, Kai DMs, Theo scheduler, Ava cold-dial outbound) as worked examples. These names come from the original Novatar.ai catalog and are kept in the methodology so readers can see how the AI overlay actually maps to a real product line.

To swap in your own agent names, create `~/.claude/skills/cscale/cscale.config.json` based on the `cscale.config.example.json` shipped in this repo. Map each example agent to your equivalent. The skill reads this file when rendering the AI overlay layer and the department lanes. If the file is missing, the example names are used as-is.

## Output contract

A single noindex HTML file at:

```
public/r/<slug>-cscale.html
```

Slug rule.

```
slug = <business-name-kebab>     e.g. "acme-med-spa", "preston-sherry"
file  = public/r/<slug>-cscale.html
```

Always suffix `-cscale` to avoid colliding with existing audit and proposal slugs. Image assets land at `public/images/cscale/<slug>/*.png`.

The HTML follows the warm-band brand defined in the shell at [templates/report.html](templates/report.html). Charts are inline SVG. Tables use the brand styles already defined in the template. Imagery is generated through Higgsfield `nano_banana_2 --resolution 1k` per [reference/images.md](reference/images.md).

Required output sections, in order, defined in [reference/sections.md](reference/sections.md):

1. **Topline plus verdict bar.** Name, today's date, one-line thesis, three headline numbers.
2. **TLDR ladder.** Three rungs (peer, mid-tier, aspirational) with the headline outcome at each.
3. **Where the company is today.** Current revenue range, channel mix, ICP fit, biggest leak (cited from prior audit if present).
4. **Tiered competitor map.** Five or six competitors split into peer (1 or 2), mid-tier 6 to 12 month target (2), aspirational 12 to 18 month ceiling (1 or 2). Each profile uses the format in [reference/sections.md](reference/sections.md).
5. **The 18-month thesis.** One-paragraph narrative of how the company gets from peer to aspirational.
6. **Department-by-department plan.** Ten swim lanes (Executive, Product, Engineering, Marketing, Sales, Customer Success, Operations, People, Data, AI). Each lane has week-of-plan-numbered work items, owner role, success metric, and the AI agent that supports it. Structure defined in [reference/sections.md](reference/sections.md).
7. **AI optimization layer.** Cross-cutting view of which AI agents (Sam, Cloe, Maya, Jessica, etc.) plug into which department on which week, with the dollar impact.
8. **Bonus 1. Pivot scenarios.** Three branch points if the headline thesis stalls.
9. **Bonus 2. Expansion products to existing customers.** Five product or service-line extensions with TAM math.
10. **Bonus 3. Retargeting and re-engagement from paid leads.** Funnel-stage-based plays (search retargeting, dynamic retargeting, abandoned-lead SMS, dormant-lead win-back, lost-deal nurture).
11. **Bonus 4. Investor targets and comparable financials.** Five to ten named investors with peer fundraising data (round size, valuation if disclosed, lead, key terms) drawn from the competitor tier.
12. **30, 60, 90 day execution.** What ships in the first three months.
13. **Risks, dependencies, what would change the plan.**
14. **Call-to-action.** Book the working session, sign the expansion SOW, etc.

## The 6-phase pipeline

Full detail in [reference/methodology.md](reference/methodology.md). One-paragraph summary per phase.

### Phase 1. Context load (15 min)

Read every prior asset for the company. Audit reports at `public/r/<slug>*.html` (everything matching the slug stem), proposal at `public/r/<slug>-proposal*.html`, any prior intelligence brief at `public/r/<slug>-intelligence.html`. Extract current state numbers, owner name, vertical, geo, stated pain, prior recommendations. WebFetch the live site. Note any updates since the audit. If no prior assets exist, this phase becomes a full first-crawl and the report flags itself as a first-pass scaling plan with no prior baseline.

### Phase 2. Tiered competitor map (45 to 60 min)

Delegate to `/competitors` and `/competitor-profiling` to identify 5 or 6 competitors. Tier them.

- **Peer tier (1 or 2).** Same revenue range, same channel mix, same geo or ICP. The company should already see itself in these.
- **Mid-tier (2).** Three to five times ahead. Six to twelve month target. Companies the target could realistically grow into within the plan window.
- **Aspirational (1 or 2).** Ten times ahead or category-defining. The 12 to 18 month ceiling. Profile what they did between $X and $10X.

For each, run `/competitive-ads-extractor` against their Facebook and LinkedIn ad libraries. Pull `/deep-research` on funding history and growth-stage signals. Sources, citations, and screenshots all required.

### Phase 3. Customer and market reality check (30 min)

Delegate to `/customer-research`. Mine reviews, Reddit, G2, and competitor-review datasets scoped to the target's vertical and geo. The output is one ICP-in-a-paragraph in customer voice, the top three JTBD, and the top five buying objections. Reused by every department's marketing and sales plan downstream.

### Phase 4. Department playbooks (90 to 120 min)

This is the meat. For each of the ten swim lanes, produce week-numbered work items. Use the templates and prompts in [reference/sub-skills.md](reference/sub-skills.md) to delegate.

- Marketing splits into Growth, Brand, Content, Paid, SEO, Social, Email. Pull from `/cro`, `/copywriting`, `/ads`, `/ad-creative`, `/emails`, `/programmatic-seo`, `/ai-seo`, `/social`, `/marketing-psychology`, `/launch`, `/popups`, `/free-tools`, `/lead-magnets`, `/co-marketing`, `/community-marketing`.
- Sales pulls from `/sales-enablement`, `/sales-icp`, `/sales-outreach`, `/sales-objections`, `/sales-prospect`, `/cold-email`.
- Product and Engineering pull from product-marketing patterns plus first-principles thinking on the product roadmap implied by the JTBD.
- Customer Success pulls from `/churn-prevention`, `/onboarding`, `/signup`.
- AI lane pulls from your own agent catalog (Sam receptionist, Cloe customer service, Maya scheduling, Jessica readiness, etc., or your overrides per `cscale.config.json`).

Every work item has. week-of-plan number, owner role (not name), success metric, and which AI agent or workflow plugs in.

### Phase 5. Bonus sections (45 min)

Run the four bonus sections in parallel.

1. **Pivot scenarios.** If the channel mix in Phase 4 stalls at month 6, what are the two alternative directions? Frame as branch points, not abandonments.
2. **Expansion products.** Five product or service-line extensions to sell to existing customers. Each has price point, TAM among current base, and the one AI agent that makes it deliverable.
3. **Retargeting and re-engagement.** Five named plays. Search retargeting (Performance Max, RLSA), dynamic retargeting (Meta, Google Display), abandoned-lead SMS (Cloe), dormant-customer win-back (email plus offer), lost-deal nurture (Maya scheduling cadence).
4. **Investor targets.** Five to ten named funds or angels. For each, the comparable fundraise in the competitor tier (round size, valuation, lead, key terms). `/deep-research` does the legwork. Cite Crunchbase, PitchBook, SEC filings, press releases.

### Phase 6. Render and ship (30 min)

Stitch everything into `public/r/<slug>-cscale.html` against [templates/report.html](templates/report.html). Generate the imagery batch per [reference/images.md](reference/images.md) using Higgsfield `nano_banana_2 --resolution 1k`. Inline SVG charts for the data. Run the quality bar below. Commit and push.

## Voice and brand rules

The deliverable respects a strict no-AI-tells writing style. These rules override any generic skill defaults.

- **No em dashes anywhere.** Replace with period, comma, colon, or parentheses.
- **No AI vocabulary.** Skip leverage, robust, seamless, harness, unleash, unlock, transformative, cutting-edge, next-generation, best-in-class, underscore, spearhead, pivotal, in the realm of, at the intersection of.
- **Numbers lead.** "Recover 47 missed calls a month" beats "AI receptionist."
- **Direct address.** You, your business, your customers. Never the customer, the business.
- **Outcome-led headlines.** Every department lane's first sentence names the outcome, not the activity.
- **Short sentences.** 12 to 18 words average.
- **Warm-band brand.** CSS tokens, type stack, and component library are defined in [templates/report.html](templates/report.html). Do not invent new colors or fonts. Coral, hot pink, magenta, charcoal, paper.

## Skill quality bar

The report is NOT shippable if.

- Any competitor profile lacks a working source URL for every numeric claim.
- Any department lane has fewer than four week-numbered work items across the 18 months.
- Any department lane omits the success metric column or the AI agent column.
- Investor targets section has fewer than 5 named investors with at least one comparable round disclosed.
- TLDR ladder does not show all three altitude bands.
- Any image is missing alt text or referenced by a broken path.
- The HTML fails `npm run build` (when wired into a Vite/Next/etc. site).
- The output contains any em dash or any banned AI vocabulary word.

## Telemetry

After each run, append a record to `.claude/cscale-telemetry.json` in your project (created on first use). This is a local-only file. Nothing is sent over the network.

- Slug, company name, vertical, geo, retainer status (existing client, sales-qualified, cold).
- Phase 1 to 6 timings (target. under 6 hours total including image generation).
- Skill versions used. Number of competitors profiled. Number of investors profiled.
- Did the report unlock an expansion SOW or retainer? (Filled by sales at 30 days.)
- Net expansion revenue at 90 days. (Filled by sales at 90 days.)

This dataset tunes the next version of the skill and validates the deliverable's price point. Disable telemetry entirely by deleting or never creating the file.

## Related skills and assets

- `[[customer-intelligence-brief]]`. The $2 to $5k pre-engagement cousin. Heavier on citations and customer voice, lighter on 18-month strategy.
- `[[interview-to-deck]]`. For post-voice-interview AI readiness decks.
- Standard audit reports. The free top-of-funnel diagnosis. Always check `public/r/<slug>*.html` before invoking `/cscale`.
- The proposal template at `public/r/<slug>-proposal*.html`. The sales-stage close. Always reference if present.
