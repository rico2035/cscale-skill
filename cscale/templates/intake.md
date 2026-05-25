# /cscale Intake Checklist

The inputs `/cscale` needs before it can run. Required fields stop the skill if missing. Strongly recommended fields trigger a one-line prompt. Optional fields are nice-to-have.

## Required (skill stops if missing)

| Field | Type | Example |
|---|---|---|
| `company_name` | string | `Acme Med Spa`, `Preston Sherry Dental` |
| `website` | url | `https://acmemedspa.com` |
| `vertical` | enum | medspa, dental, HVAC, legal, real estate, home services, other |
| `geo_market` | string | `Tampa FL + 25mi`, `New York metro`, `national` |
| `engagement_context` | enum | existing_retainer, sales_qualified, cold |
| `revenue_range` | enum | under_500k, 500k_2M, 2M_10M, 10M_50M, 50M_plus |
| `owner_or_stakeholder` | string | for the plan ownership column |

## Strongly recommended (skill prompts once if missing)

- **Stated pain in customer's own words.** Verbatim quote when available. Feeds the 18-month thesis.
- **Three known competitors.** Skill tiers them. Otherwise the skill discovers competitors itself, which takes longer.
- **Current channel mix percentages.** SEO, paid, referral, outbound, other. Needed for the now-vs-target chart.
- **Last 90-day topline metrics.** Revenue, leads, conversion rate, average ticket. Feeds the verdict bar.
- **Existing audit report path.** e.g. `public/r/<slug>.html`. Phase 1 reads this for prior diagnosis.
- **Existing proposal path.** e.g. `public/r/<slug>-proposal.html`. Phase 1 reads this for prior commercial terms.
- **Existing intelligence brief path.** e.g. `public/r/<slug>-intelligence.html`. Phase 1 reads this for prior ICP work.

## Optional (improves report quality)

- Org chart (department headcount per lane). Lets the people lane be specific.
- Last fundraise context (have they raised, when, from whom, terms).
- Stated 18-month goal in their words. Used in the 18-month thesis section.
- Known constraints (founder won't sell, no equity dilution allowed, geo-bound by license).
- Tech stack signals (CRM, scheduling, payment, marketing automation). Feeds the AI overlay layer.
- Pricing tiers and average customer LTV. Feeds the expansion-products bonus.

## Slug rules

Slug equals the business name in kebab-case with the TLD appended only when the brand name is the domain stem. Examples:

| Input | Slug | Output filename |
|---|---|---|
| Acme Med Spa + acmemedspa.com | `acme-med-spa` | `public/r/acme-med-spa-cscale.html` |
| prestonsherrydental.com | `prestonsherrydental-com` | `public/r/prestonsherrydental-com-cscale.html` |

Always append `-cscale` to avoid colliding with the audit (`<slug>.html`), proposal (`<slug>-proposal*.html`), and intelligence (`<slug>-intelligence.html`) flavors.

Image assets land at `public/images/cscale/<slug>/*.png` (plus a `competitors/` subfolder).

## Pre-flight checks (skill runs before Phase 1)

1. `glob public/r/<slug>*.html`. If any matches exist, read each and feed Phase 1.
2. `WebFetch <website>`. If it does not respond, flag and ask for an alternate URL or a web.archive.org snapshot.
3. `higgsfield generate --help` or equivalent auth check. If auth fails, set the run flag `skip_images=true` and continue text-only.
4. `cscale.config.json` lookup. If present at `~/.claude/skills/cscale/cscale.config.json` or in the project root, apply agent-name overrides before rendering.

## Run-time budget

| Phase | Wall clock | Notes |
|---|---|---|
| Phase 1 | 15 min | Mostly file I/O plus WebFetch |
| Phase 2 | 45 to 60 min | 5 or 6 parallel competitor profile sub-tasks |
| Phase 3 | 30 min | Single sub-skill call |
| Phase 4 | 90 to 120 min | 10 parallel department-lane sub-tasks |
| Phase 5 | 45 min | 4 parallel bonus sub-tasks |
| Phase 6 | 30 min | Image gen, render, quality bar, commit |
| **Total** | **4 to 6 hours** | Aggressive parallelization assumed |

Higgsfield image generation cost: ~8 images at 1k resolution per report. Trivial compared to analyst time saved.

## When intake fails

If any required input is missing, the skill prints a one-line summary of missing fields and exits. Do not partially run. Examples:

```
Missing required input: vertical.
Pass it as the third argument or set in the intake JSON. Examples: medspa, dental, HVAC.

Missing required input: revenue_range.
This determines the peer tier in the competitor map. Best estimate is fine.
```

## Intake JSON file shape

If passing structured intake (preferred for repeat runs), write it to `.claude/skills/cscale/runs/<slug>/intake.json` before invocation:

```json
{
  "company_name": "Acme Med Spa",
  "website": "https://acmemedspa.com",
  "vertical": "medspa",
  "geo_market": "Tampa FL + 25mi",
  "engagement_context": "sales_qualified",
  "revenue_range": "500k_2M",
  "owner_or_stakeholder": "Olivia",
  "stated_pain": "We get the leads, we just can't book them fast enough.",
  "known_competitors": ["competitor-1.com", "competitor-2.com", "competitor-3.com"],
  "channel_mix": { "seo": 35, "paid": 40, "referral": 15, "outbound": 5, "other": 5 },
  "prior_assets": {
    "audit": "public/r/acme-med-spa.html",
    "proposal": "public/r/acme-med-spa-proposal.html",
    "intelligence_brief": null
  },
  "constraints": ["founder will not sell", "must stay in Florida"],
  "stated_goal": "Triple bookings in 18 months without doubling staff."
}
```
