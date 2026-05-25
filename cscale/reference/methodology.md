# /cscale Methodology

Detailed playbook for each phase. SKILL.md gives the one-paragraph summary. This file is what the orchestrator follows step by step.

## Working directory convention

Per invocation, create:

```
.claude/skills/cscale/runs/<slug>/
  intake.json                       (or intake.md)
  phase1-context.json
  phase2-competitors/
    <competitor-1-slug>.json
    <competitor-2-slug>.json
    ...
    summary.json
  phase3-icp.json
  phase4-<lane>.json                (one per department, 10 total)
  phase5-pivots.json
  phase5-expansion-products.json
  phase5-retargeting.json
  phase5-investors.json
  phase6-render-manifest.json
```

These working files are not committed. Add the runs path to `.gitignore` if not already covered. The final HTML at `public/r/<slug>-cscale.html` is the only committed artifact.

---

## Phase 1. Context load (target. 15 min)

### Steps

1. `glob public/r/<slug>*.html`. Read every match.
2. For each prior asset, extract structured data: current revenue range, channel mix if stated, biggest leak called out, top 3 recommendations, owner or stakeholder name, geo, vertical, last-modified date.
3. `WebFetch <website>`. Check for changes since the audit. Note new pages, removed pages, headline shifts.
4. Read the intake JSON or markdown. Cross-check intake fields against prior-asset findings. Flag conflicts in `phase1-context.json` under `conflicts`.
5. Build `phase1-context.json` with the union: business basics, current state, prior-recommendation summary, fresh-crawl deltas.

### What if no prior assets exist

- Skip step 1 and 2.
- WebFetch the homepage plus pricing, about, contact, services (if they exist).
- Build phase1-context.json from the crawl alone.
- Set the report flag `first_pass = true`. The cover note in the rendered report should read. "First-pass scaling plan. No prior audit or proposal baseline."

### Exit criteria

- phase1-context.json contains: business_name, vertical, geo, revenue_range, channel_mix_known (bool), biggest_leak, prior_recommendations (array), live_site_delta (string), first_pass (bool).

---

## Phase 2. Tiered competitor map (target. 45 to 60 min)

### Sub-skill orchestration

Run in this order. The first call is sequential, the rest parallelize per competitor.

1. **Call `/competitors`** with the website plus vertical plus geo. Ask for 8 to 10 candidate competitors so the tiering step has options.
2. **Tier them** using the rubric below. Pick 1 or 2 peers, 2 mid-tier, 1 or 2 aspirational. Drop the rest.
3. **For each of the 5 or 6 chosen** (run all in parallel via the Agent tool):
   - `/competitor-profiling` for the company profile.
   - `/competitive-ads-extractor` against Facebook Ad Library and LinkedIn Ad Library.
   - `/deep-research` on funding history (Crunchbase, PitchBook, SEC filings, press releases).
4. **Write one JSON per competitor** to `phase2-competitors/<slug>.json`. Cross-comparison summary to `phase2-competitors/summary.json`.

### Tiering rubric

Score each candidate on five dimensions, 1 to 5 each.

- Revenue range relative to target (1 = same, 3 = 5x, 5 = 10x or more).
- Employee count relative to target.
- Funding stage maturity (bootstrap, seed, A, B, growth, public).
- Channel sophistication (single-channel, two-channel, omnichannel, brand at category level).
- Geographic footprint (single market, regional, national, international).

Sum the five scores.

| Sum | Tier |
|---|---|
| 5 to 10 | Peer |
| 11 to 17 | Mid-tier |
| 18 to 25 | Aspirational |

### Required data per competitor

Every competitor JSON must include all of these or flag the field as `unknown` with a source-search note.

- name, url, slug
- revenue_estimate (with source URL)
- employee_count (with source URL)
- funding_history: array of rounds, each with date, amount, lead, valuation, key terms
- ads: array of 3 to 5 active ads, each with screenshot path, channel, headline, offer, target persona inferred
- pricing_model: string
- icp: one-paragraph customer voice
- top_channels: array of strings (e.g. ["SEO", "Meta", "partner referrals"])
- differentiator: one-line
- last_fundraise_terms: object or null

### Exit criteria

- 5 or 6 competitor JSONs written.
- All ad screenshots downloaded to `public/images/cscale/<slug>/competitors/<competitor-slug>/`.
- `phase2-competitors/summary.json` includes the cross-comparison table.

---

## Phase 3. Customer and market reality check (target. 30 min)

### Sub-skill orchestration

Single call to `/customer-research` with this exact prompt scaffolding:

```
Target. <company_name> in <vertical>, <geo>.
Mine for the following sources.
1. Reddit threads scoped to <vertical> within <geo> region in the last 24 months.
2. G2 and Trustpilot reviews for the target plus all 5 or 6 competitors from Phase 2.
3. Google reviews for the target's local market (top 50 by recency).
4. Facebook page reviews for any local competitor.
Synthesize:
- ICP-in-a-paragraph in customer voice (no marketing voice).
- Top 3 JTBD with at least 2 verbatim quotes per job.
- Top 5 buying objections with at least 2 verbatim quotes per objection.
- Top 5 positive surprises in 5-star reviews.
- Demographic + psychographic patterns. Age range, life stage, income signals, trigger events.
```

### Exit criteria

- `phase3-icp.json` with all fields populated and citation URLs resolved.
- `phase3-icp.md` rendered version for human review.

---

## Phase 4. Department playbooks (target. 90 to 120 min)

The biggest phase. Ten lanes. Parallelize.

### Lane catalog

| Lane | Sub-skills (see [sub-skills.md](sub-skills.md)) |
|---|---|
| Executive | ab-testing, pricing |
| Product | content-strategy, customer-research, ab-testing |
| Engineering | (first-principles roadmap from JTBD) |
| Marketing (Growth) | cro, ads, ab-testing, free-tools, lead-magnets, launch |
| Marketing (Brand) | copywriting, copy-editing, social, marketing-psychology |
| Marketing (Content) | content-strategy, programmatic-seo, ai-seo, copywriting |
| Marketing (Paid) | ads, ad-creative, competitive-ads-extractor |
| Marketing (SEO) | seo-audit, programmatic-seo, schema, ai-seo |
| Marketing (Social) | social, community-marketing |
| Marketing (Email) | emails, cold-email |
| Sales | sales-enablement, sales-icp, sales-outreach, sales-objections, sales-prospect, cold-email |
| Customer Success | churn-prevention, onboarding, signup, paywalls |
| Operations | analytics |
| People | (no marketing skill; org-design pass) |
| Data | analytics, ab-testing |
| AI | image plus your AI agent catalog (Sam, Cloe, Maya, Jessica, etc., or your overrides per cscale.config.json) |

Marketing splits into 7 sub-lanes when reporting. The ten swim lanes in the report are: Executive, Product, Engineering, Marketing (rolled up with sub-lanes inside), Sales, Customer Success, Operations, People, Data, AI.

### Work item structure

Every department lane must produce a JSON file `phase4-<lane>.json` with at least 4 work items across weeks 1 to 78 (18 months). Each work item:

```json
{
  "week_number": 12,
  "item_title": "Launch programmatic SEO for 'X near me' city pages",
  "item_description": "Generate 47 templated landing pages targeting [service] near [city] queries...",
  "owner_role": "Head of Marketing",
  "success_metric": "Organic sessions to /services/* up 40 percent at week 24",
  "ai_agent": "Cloe",
  "depends_on": ["phase4-marketing-seo:week_8"],
  "estimated_effort_weeks": 3
}
```

### Quality gate

A lane fails the quality bar if any of these are true.

- Fewer than 4 work items across weeks 1 to 78.
- Any work item omits `success_metric` or `ai_agent`.
- Any work item has a success metric that is not measurable (e.g. "improve brand awareness" without a number).
- The lane has no work item in weeks 1 to 6 (no quick win) or weeks 60 to 78 (no late-stage payoff).

### Parallelization

Launch all 10 lanes as parallel Agent calls. Each agent gets the relevant lane brief plus phase1-context.json plus phase3-icp.json plus the Phase 2 competitor summary. Wall clock target. 60 to 90 min when fanned out.

### Exit criteria

- 10 lane JSON files written.
- A roll-up `phase4-summary.json` with the count of work items per lane and the dependency graph.

---

## Phase 5. Bonus sections (target. 45 min, run all four in parallel)

### Bonus 1. Pivot scenarios

Read Phase 4 outputs. Identify the single biggest assumption (usually a channel assumption or a hiring assumption). Write two alternate strategies if that assumption fails by month 6. Each pivot includes. trigger event, alternate channel mix, what shifts in the department plan, expected revenue trajectory delta.

Output: `phase5-pivots.json`.

### Bonus 2. Expansion products to existing customers

Five net-new revenue lines sellable to the current customer base. Each:

- product_name
- price_point (recurring or one-time)
- base_tam = current customer count multiplied by take rate assumption
- annual_revenue_at_target = base_tam times price_point times 12 (if recurring)
- ai_agent that makes it deliverable
- launch_quarter relative to month 0

Output: `phase5-expansion-products.json`.

### Bonus 3. Retargeting and re-engagement from paid leads

Five plays at different funnel stages:

| Play | Trigger | Channel | Message | Metric | AI agent |
|---|---|---|---|---|---|
| Search retargeting | Visited service page, no booking | Performance Max, RLSA | dynamic | CTR, CPL | Cloe |
| Dynamic retargeting | Cart/booking abandon | Meta DPA, Google Display | service-specific | ROAS | Cloe |
| Abandoned-lead SMS | Form filled, no call back | SMS within 5 min | personal | call-back rate | Cloe |
| Dormant-customer win-back | 90 days no purchase | Email + offer | seasonal | revival rate | Maya |
| Lost-deal nurture | Sales said no | Email cadence 12 weeks | educational | re-engaged % | Maya |

Output: `phase5-retargeting.json`. Each play has message templates and trigger conditions specified.

### Bonus 4. Investor targets and comparable financials

5 to 10 named funds or angels. Source data via `/deep-research`. For each:

- name
- check_size_range (e.g. "$500k to $5M")
- stage_focus (seed, A, B, growth)
- sector_focus (healthtech, consumer services, vertical SaaS, etc.)
- comparable_round (must reference a Phase 2 competitor): competitor name, round size, valuation if disclosed, lead, key terms
- portfolio_relevance (3 to 5 portfolio companies in the target's vertical)
- partner_name + LinkedIn URL
- thesis_match (1-2 lines on why they'd say yes to this company)

Output: `phase5-investors.json`. Quality bar. minimum 5 investors, each with at least one comparable round disclosed.

### Exit criteria

- All 4 phase5-*.json files written.
- Citations resolved for the investor section (no broken URLs).

---

## Phase 6. Render and ship (target. 30 min)

### Step 1. Image batch

Generate 8 images per [images.md](images.md) using Higgsfield. Default. `nano_banana_2 --resolution 1k`. Aspect ratios vary by image (16:9 for heroes, 4:3 for inline supports). Save to `public/images/cscale/<slug>/`.

If Higgsfield auth fails, set body class `.no-images` and skip. Text content stands alone.

### Step 2. Render

Stitch Phase 1 to 5 outputs into the template at [../templates/report.html](../templates/report.html). Replace all `{{HANDLEBARS}}` placeholders. Use the section structure defined in [sections.md](sections.md).

### Step 3. Inline SVG charts

Generate four SVG charts inline:

1. Revenue ladder: peer to mid to aspirational, horizontal stacked bar with tabular labels.
2. Channel mix now-vs-target: side-by-side vertical stacked bars.
3. 30/60/90 day timeline: Gantt-style with milestone diamonds.
4. AI overlay matrix: CSS grid heatmap, departments on Y-axis, weeks on X-axis, cells colored by AI agent.

Templates in [sections.md](sections.md) Chart helpers appendix.

### Step 4. Quality bar

Run all of these. Any failure blocks ship.

- `grep -cP '\x{2014}' public/r/<slug>-cscale.html` returns 0. Zero em dashes (U+2014).
- Banned words sweep returns 0. (Script. `node scripts/lint-banned-words.mjs <file>` if it exists, otherwise inline grep loop.)
- Every `<img>` has a non-empty `alt` attribute.
- Every src path resolves to a file on disk.
- Every external link returns 200 (or is a known noindex prospect link).
- File size between 80 and 250 KB.
- `npm run build` exits 0 (skip this check if the host project has no build step).

### Step 5. Commit and push

```
git add public/r/<slug>-cscale.html public/images/cscale/<slug>/
git commit -m "feat(cscale): <company_name> 18-month scaling report"
git push
```

The hosting platform auto-deploys (Netlify, Vercel, etc.).

### Step 6. Telemetry

Append the run record to `.claude/cscale-telemetry.json` per SKILL.md telemetry contract. Local-only file. Nothing is sent over the network.

---

## Failure modes and recovery

| Failure | Action |
|---|---|
| Higgsfield auth fails | Continue text-only. Set body class `.no-images`. Flag in cover note. |
| Competitor has zero ads in any library | Note "no active ads detected" in the competitor JSON. Do not drop the competitor. |
| `/deep-research` returns conflicting fundraise numbers | Prefer the most recent SEC filing or press release with date. Note the conflict in a footnote. |
| Live website 404s at Phase 1 | Pull from web.archive.org snapshot. Flag the stale snapshot date in the cover note. |
| A department lane returns fewer than 4 work items | Re-prompt the sub-agent with the explicit "minimum 4 items, must include one in weeks 1 to 6 and one in weeks 60 to 78" instruction. If still fails after 2 retries, mark the lane as `partial` in the rendered report. |
| `npm run build` fails | Investigate the HTML. Most common cause. unclosed tag or malformed inline SVG. Do not ship until clean. |
| Quality bar finds an em dash | Replace with period, comma, colon, or parentheses. Re-run the quality bar. Repeat until 0. |
