# /cscale Required Output Sections

Each of the 14 sections in the rendered report. For each. position, input shape, components, word target, voice rules, and one concrete example (a fictional Tampa-area medspa, "Acme Med Spa," used purely for shape).

---

## 1. Topline plus verdict bar

- **Position.** First `<section>` after `.topbar`. Inside the hero block.
- **HTML id.** `#topline`
- **Components.** `.hero`, `.hero-grid`, `.hero-card`, `.eyebrow`, `.chip`
- **Input shape.**
  ```json
  {
    "company_name": "Acme Med Spa",
    "report_date": "2026-05-23",
    "vertical": "medspa",
    "geo": "Tampa FL + 25mi",
    "one_line_thesis": "Triple bookings in 18 months by closing the 24-hour follow-up gap and stealing the mid-market that the closest local peer is too slow to defend.",
    "headline_metrics": [
      { "label": "Current monthly revenue", "value": "$148k", "delta": null },
      { "label": "18-month target", "value": "$485k", "delta": "+228%" },
      { "label": "Months to payback this plan", "value": "7", "delta": null }
    ]
  }
  ```
- **Word target.** Thesis 35 to 45 words. Metrics. label 4 to 6 words, value tabular.
- **Voice.** Outcome-led. Numbers lead. Name a specific competitor in the thesis when the peer tier is named in section 4.
- **Example thesis.**
  > Triple bookings in 18 months by closing the 24-hour follow-up gap and stealing the mid-market customers that the closest local peer is too slow to defend.

---

## 2. TLDR ladder (peer / mid-tier / aspirational)

- **Position.** Second section. Right under the topline.
- **HTML id.** `#tldr-ladder`
- **Components.** `.tldr-ladder` wrapper, three `.tldr-rung` blocks. Aspirational rung uses `.tldr-rung-aspirational` with the warm-band gradient text treatment.
- **Input shape.**
  ```json
  {
    "rungs": [
      {
        "tier": "peer",
        "where_they_are": "$150k/mo, 60% paid social, 1 location",
        "headline_outcome": "Match their best month every month for 6 months",
        "estimated_months": 6
      },
      {
        "tier": "mid-tier",
        "where_they_are": "$400k/mo, 35% organic, 2 locations, 22-person team",
        "headline_outcome": "Add the second location, ship the membership program, $400k MRR",
        "estimated_months": 12
      },
      {
        "tier": "aspirational",
        "where_they_are": "$2M+/mo, national footprint, recognized brand, Series A funded",
        "headline_outcome": "Raise a seed round, license the playbook to 3 partner clinics",
        "estimated_months": 18
      }
    ]
  }
  ```
- **Word target.** Each rung 12 to 18 words.
- **Voice.** Headline outcome must be a single sentence. Where-they-are uses the chosen competitor's actual numbers.

---

## 3. Where the company is today

- **Position.** Third section.
- **HTML id.** `#current-state`
- **Components.** `.recall`, `.recall-card`, `.recall-table`
- **Input shape.**
  ```json
  {
    "revenue_range": "$148k/mo",
    "channel_mix": [
      { "channel": "Paid social", "share": 52 },
      { "channel": "Walk-in / drive-by", "share": 18 },
      { "channel": "Referral", "share": 14 },
      { "channel": "Google organic", "share": 11 },
      { "channel": "Other", "share": 5 }
    ],
    "icp_fit_score": 6.5,
    "biggest_leak": {
      "name": "24-hour follow-up gap",
      "cost_per_month": "$32,400",
      "source_url": "public/r/<slug>.html#diagnosis"
    },
    "prior_recommendations_status": [
      { "rec": "Wire after-hours SMS", "status": "implemented" },
      { "rec": "Add Spanish service pages", "status": "not started" }
    ]
  }
  ```
- **Word target.** No prose. Pure table plus one callout block for the biggest leak.

---

## 4. Tiered competitor map (5 or 6 competitors)

- **Position.** Fourth section. The longest section.
- **HTML id.** `#competitor-map`
- **Components.** `.competitor-tier-band` (3 of them, color-banded per tier), `.competitor-card` (5 to 6 cards).
- **Tier band colors.**
  - Peer band: `background: var(--green-soft); border-left: 4px solid var(--green);`
  - Mid-tier band: `background: var(--amber-soft); border-left: 4px solid var(--amber);`
  - Aspirational band: `background: var(--warm-band-soft); border-left: 4px solid var(--magenta);`
- **Input shape (per competitor).**
  ```json
  {
    "name": "Glow Med Spa",
    "url": "https://glowmedspa.example",
    "slug": "glow-med-spa",
    "tier": "peer",
    "revenue_estimate": { "value": "$160k/mo", "source": "https://example.com/source" },
    "employee_count": { "value": 11, "source": "https://linkedin.com/..." },
    "funding_history": [
      { "date": "2024-03-15", "round": "Seed", "amount_usd": 1500000, "lead": "Florida Funders", "valuation_usd": 8000000, "key_terms": "SAFE post-money" }
    ],
    "top_ads": [
      { "channel": "Meta", "headline": "Botox $11/unit this week", "offer": "First-time client", "screenshot": "/images/cscale/<slug>/competitors/glow-med-spa/ad-001.png" }
    ],
    "pricing_model": "a la carte plus $99/mo unlimited facials",
    "icp": "Tampa Bay women 28-48, household income $90k+, drives a leased SUV, follows local micro-influencers.",
    "top_channels": ["Meta", "Walk-in", "Referral"],
    "differentiator": "Saturday open until 8pm",
    "last_fundraise_terms": "Seed extension closing Q3 2026, rumored $3M at $15M post."
  }
  ```
- **Voice.** Each competitor card opens with a one-line "What they do better than you" and one-line "What you can do better than them." Honest. Specific.

---

## 5. The 18-month thesis

- **Position.** Fifth section. Centerpiece of the report.
- **HTML id.** `#thesis`
- **Components.** Single `.scope-card` style block. Image to the right (`hero-thesis.png` per [images.md](images.md)).
- **Input shape.**
  ```json
  {
    "thesis_paragraph": "Acme Med Spa gets to $485k/mo by closing the 24-hour follow-up gap that the peer tier still leaks through, then re-investing the recovered revenue into a second Sarasota location at month 9, then licensing the booking-recovery playbook to 3 partner clinics by month 18. The peer is too slow to defend. The mid-tier is too distracted by their own expansion. The aspirational ceiling is funded but operationally weak in service businesses. The opening is now.",
    "image_path": "/images/cscale/<slug>/hero-thesis.png",
    "image_alt": "18-month thesis visual: serene Tampa beauty treatment room at golden hour, warm coral and magenta lighting."
  }
  ```
- **Word target.** 90 to 130 words.
- **Voice.** Single paragraph. No bullet points. Reads like a memo, not a deck.

---

## 6. Department-by-department plan

- **Position.** Sixth section. The longest by line count.
- **HTML id.** `#departments`
- **Components.** 10 `.dept-lane` blocks. Each lane has a `.dept-lane-header` plus a `.work-item` table.
- **Lanes in this order.** Executive, Product, Engineering, Marketing, Sales, Customer Success, Operations, People, Data, AI.
- **Marketing lane** rolls up the 7 sub-lanes (Growth, Brand, Content, Paid, SEO, Social, Email) inside it using `.dept-sublane` accordions.
- **Work-item row shape.**
  ```json
  {
    "week": 4,
    "item": "Wire after-hours SMS via Cloe agent, route to Maya for scheduling",
    "owner_role": "Head of Operations",
    "metric": "Lead-to-booked-call rate up from 18% to 35% by week 12",
    "ai_agent": "Cloe + Maya"
  }
  ```
- **Quality bar per lane.** Min 4 items. At least one in weeks 1 to 6 (quick win). At least one in weeks 60 to 78 (late payoff). Every item has metric plus ai_agent.
- **Row table headers.**
  | Week | Work item | Owner | Success metric | AI agent |
  |---|---|---|---|---|
- **Voice per lane.** First sentence of the lane header names the outcome, not the activity. Example. "Marketing. Cut cost per booked call from $97 to $42 by month 12."

---

## 7. AI optimization layer

- **Position.** Seventh section. Right after departments so the AI overlay reads as the connective tissue.
- **HTML id.** `#ai-overlay`
- **Components.** `.ai-overlay-matrix` (CSS grid heatmap), plus `.ai-overlay-table` summarizing dollar impact per agent.
- **Matrix axes.** Y-axis. 10 departments. X-axis. weeks 1, 4, 8, 12, 24, 36, 48, 60, 72, 78. Cell color. coral if Cloe, pink if Maya, magenta if Sam, lemon if Jessica, peach if other.
- **Dollar impact table per agent.**
  | Agent | First plug-in week | Last plug-in week | Estimated 18mo $ saved/added |
  |---|---|---|---|
  | Cloe | 4 | 78 | $186k saved (recovered bookings) |
  | Maya | 8 | 72 | $124k saved (scheduling friction) |
  | Sam | 16 | 60 | $84k added (qualified inbound) |
  | Jessica | 24 | 48 | $32k added (readiness consulting) |
- **Voice.** Numbers lead. Agent names come from the active `cscale.config.json` (or the example catalog if no override is set).

---

## 8. Bonus 1. Pivot scenarios

- **Position.** Eighth section.
- **HTML id.** `#bonus-pivots`
- **Components.** `.bonus-block` wrapper. 3 `.pivot-card` items.
- **Input shape per pivot.**
  ```json
  {
    "name": "Pivot from B2C local to B2B SaaS",
    "trigger": "If Sarasota expansion misses bookings target by 30% at month 9",
    "alternate_strategy": "License the booking-recovery playbook as software to 25 medspas in FL/GA",
    "first_30_day_moves": ["Productize Cloe workflow", "Sign 3 design partners", "Land first $5k MRR"],
    "expected_outcome": "$45k MRR by month 18 instead of second-location $230k/mo"
  }
  ```
- **Voice.** Frame as branch point, not abandonment. Each pivot opens with the trigger event in plain English.

---

## 9. Bonus 2. Expansion products to existing customers

- **Position.** Ninth section.
- **HTML id.** `#bonus-expansion`
- **Components.** `.bonus-block` wrapper. 5 `.product-card` items in a 2-column grid.
- **Input shape per product.**
  ```json
  {
    "product_name": "Membership program. $99/mo unlimited brow waxing plus 1 facial",
    "price_point": "$99/mo",
    "base_tam_customers": 480,
    "take_rate_assumption": 0.18,
    "annual_revenue_at_target": 102816,
    "ai_agent": "Maya (auto-renewal, churn alerts)",
    "launch_quarter": "Q3 month 8"
  }
  ```
- **Voice.** Each product card includes one sentence on why this customer base will buy it.

---

## 10. Bonus 3. Retargeting and re-engagement from paid leads

- **Position.** Tenth section.
- **HTML id.** `#bonus-retargeting`
- **Components.** `.bonus-block` wrapper. Single table.
- **Table columns.**
  | Play | Trigger event | Channel | Message template | Success metric | AI agent |
  |---|---|---|---|---|---|
- **5 required plays.**
  1. Search retargeting (Performance Max, RLSA)
  2. Dynamic retargeting (Meta DPA, Google Display)
  3. Abandoned-lead SMS (Cloe within 5 min)
  4. Dormant-customer win-back (90-day-no-purchase email plus offer)
  5. Lost-deal nurture (12-week sales-said-no cadence)

---

## 11. Bonus 4. Investor targets and comparable financials

- **Position.** Eleventh section.
- **HTML id.** `#bonus-investors`
- **Components.** `.bonus-block` wrapper. `.investor-table`.
- **Table columns.**
  | Fund / angel | Stage | Sector | Check size | Comparable in this space | Partner |
  |---|---|---|---|---|---|
- **Comparable cell links** to the competitor profile in Section 4 plus the source URL for the round.
- **Quality bar.** Minimum 5 named investors. Each row must show at least one comparable round disclosed (round size minimum, valuation if public).
- **Voice.** First column is fund or angel name in tabular caps. Last column has partner name plus LinkedIn URL.

---

## 12. 30 / 60 / 90 day execution

- **Position.** Twelfth section. Closer to the bottom because it's the immediate "what ships now" frame.
- **HTML id.** `#execution-90`
- **Components.** `.timeline-30-60-90` (Gantt-style with milestone diamonds). Plus three `.plan-step` cards under it for week 1-4, 5-8, 9-12 detail.
- **Input shape.**
  ```json
  {
    "milestones": [
      { "day": 14, "name": "Cloe wired to all inbound channels" },
      { "day": 30, "name": "First 100 recovered bookings logged" },
      { "day": 60, "name": "Programmatic SEO city pages live" },
      { "day": 90, "name": "Membership program soft-launch" }
    ],
    "week_1_4": "...",
    "week_5_8": "...",
    "week_9_12": "..."
  }
  ```

---

## 13. Risks, dependencies, what would change the plan

- **Position.** Thirteenth section.
- **HTML id.** `#risks`
- **Components.** Two-column. Left column. `.risk-table`. Right column. dependencies card.
- **Risk table columns.** Risk, likelihood (low/med/high), impact ($), mitigation, owner.
- **Dependencies.** Hiring milestones, tech swaps, partner deals required, regulatory.

---

## 14. Call to action

- **Position.** Final section.
- **HTML id.** `#cta`
- **Components.** `.close-cta` (matches proposal close card pattern). Charcoal background. Warm-band gradient accent. Two buttons. Primary. "Book the 90-minute kickoff." Ghost. "See the full agent catalog."
- **Voice.** One sentence opener. One sentence on what the kickoff covers. One sentence on what changes after it.

---

# Chart helpers appendix

Inline SVG generators referenced in [methodology.md](methodology.md) Phase 6 Step 3.

## Chart 1. Revenue ladder

Horizontal stacked bar. Three segments. Peer (green), Mid-tier (amber), Aspirational (warm-band gradient).

```html
<svg viewBox="0 0 600 80" xmlns="http://www.w3.org/2000/svg" class="svg-chart svg-revenue-ladder">
  <rect x="0" y="20" width="160" height="40" fill="#16653410" stroke="#166534" stroke-width="2" rx="6"/>
  <text x="80" y="46" text-anchor="middle" font-family="Inter Tight, sans-serif" font-weight="700" font-size="14" fill="#166534">{{PEER_LABEL}}</text>
  <rect x="170" y="20" width="200" height="40" fill="#B4530920" stroke="#B45309" stroke-width="2" rx="6"/>
  <text x="270" y="46" text-anchor="middle" font-family="Inter Tight, sans-serif" font-weight="700" font-size="14" fill="#B45309">{{MID_LABEL}}</text>
  <defs>
    <linearGradient id="warmband" x1="0" x2="1">
      <stop offset="0%" stop-color="#FF8A5B"/>
      <stop offset="50%" stop-color="#FF4DB8"/>
      <stop offset="100%" stop-color="#C026D3"/>
    </linearGradient>
  </defs>
  <rect x="380" y="20" width="220" height="40" fill="url(#warmband)" rx="6"/>
  <text x="490" y="46" text-anchor="middle" font-family="Inter Tight, sans-serif" font-weight="700" font-size="14" fill="#FFFFFF">{{ASPIRATIONAL_LABEL}}</text>
</svg>
```

## Chart 2. Channel mix now vs target

Two side-by-side vertical stacked bars. Now on left, target on right. Color per channel.

```html
<svg viewBox="0 0 320 240" xmlns="http://www.w3.org/2000/svg" class="svg-chart svg-channel-mix">
  <!-- Now bar -->
  <g transform="translate(40,20)">
    <text x="40" y="0" text-anchor="middle" font-family="IBM Plex Mono, monospace" font-size="10" fill="#5B6172">NOW</text>
    <!-- segments stacked bottom-up, one rect per channel; widths/colors injected at render -->
  </g>
  <!-- Target bar -->
  <g transform="translate(180,20)">
    <text x="40" y="0" text-anchor="middle" font-family="IBM Plex Mono, monospace" font-size="10" fill="#C026D3">18-MONTH TARGET</text>
    <!-- segments stacked bottom-up -->
  </g>
</svg>
```

## Chart 3. 30/60/90 timeline

Gantt-style horizontal bar with milestone diamonds.

```html
<svg viewBox="0 0 720 120" xmlns="http://www.w3.org/2000/svg" class="svg-chart svg-timeline">
  <line x1="40" y1="60" x2="680" y2="60" stroke="#D5D2CA" stroke-width="2"/>
  <text x="40"  y="90" font-family="IBM Plex Mono, monospace" font-size="10" fill="#5B6172">D0</text>
  <text x="240" y="90" text-anchor="middle" font-family="IBM Plex Mono, monospace" font-size="10" fill="#5B6172">D30</text>
  <text x="440" y="90" text-anchor="middle" font-family="IBM Plex Mono, monospace" font-size="10" fill="#5B6172">D60</text>
  <text x="640" y="90" text-anchor="middle" font-family="IBM Plex Mono, monospace" font-size="10" fill="#5B6172">D90</text>
  <!-- milestone diamonds at injected positions -->
  <polygon points="240,52 248,60 240,68 232,60" fill="#C026D3"/>
  <text x="240" y="40" text-anchor="middle" font-family="Inter, sans-serif" font-size="11" font-weight="600" fill="#1A1F2E">{{MILESTONE_30_LABEL}}</text>
</svg>
```

## Chart 4. AI overlay matrix

CSS grid heatmap. Departments on Y-axis (10 rows), weeks on X-axis (10 columns). Cell color per agent.

```html
<div class="ai-overlay-matrix" role="img" aria-label="AI agent coverage matrix across 10 departments and 10 milestone weeks">
  <div class="matrix-corner"></div>
  <div class="matrix-col-head">W1</div>
  <div class="matrix-col-head">W4</div>
  <!-- ...more week heads -->
  <div class="matrix-row-head">Executive</div>
  <div class="matrix-cell" data-agent="none"></div>
  <div class="matrix-cell" data-agent="jessica"></div>
  <!-- ...more cells -->
</div>
```

CSS for cell colors:

```css
.ai-overlay-matrix { display: grid; grid-template-columns: 140px repeat(10, 1fr); gap: 2px; background: var(--line); }
.matrix-cell { aspect-ratio: 1 / 1; background: var(--surface); }
.matrix-cell[data-agent="cloe"]    { background: var(--coral); }
.matrix-cell[data-agent="maya"]    { background: var(--pink); }
.matrix-cell[data-agent="sam"]     { background: var(--magenta); }
.matrix-cell[data-agent="jessica"] { background: var(--lemon); }
.matrix-cell[data-agent="other"]   { background: var(--peach); }
.matrix-cell[data-agent="none"]    { background: var(--paper-2); }
```
