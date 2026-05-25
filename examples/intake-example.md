# Example intake — "Acme Med Spa"

A fictional Tampa-area medspa used to show the intake shape `/cscale` expects. Substitute your own real fields.

## Method 1 — pass on the command line

```
/cscale "Acme Med Spa" https://acmemedspa.example
```

The skill will infer slug = `acme-med-spa` and prompt you for the other required fields if they aren't in an intake JSON.

## Method 2 — pre-fill an intake JSON (recommended for repeat runs)

Write the file to `.claude/skills/cscale/runs/acme-med-spa/intake.json` in your project before invoking `/cscale`. The skill reads this on Phase 1.

```json
{
  "company_name": "Acme Med Spa",
  "website": "https://acmemedspa.example",
  "vertical": "medspa",
  "geo_market": "Tampa FL + 25mi",
  "engagement_context": "sales_qualified",
  "revenue_range": "500k_2M",
  "owner_or_stakeholder": "Olivia Reed (Founder & Medical Director)",

  "stated_pain": "We get plenty of leads from Meta. We just can't book them fast enough. By the time we call back, they've gone to Glow.",

  "known_competitors": [
    "https://glowmedspa.example",
    "https://lumeaesthetics.example",
    "https://radiantcollective.example"
  ],

  "channel_mix": {
    "paid_social":   52,
    "walk_in":       18,
    "referral":      14,
    "google_organic":11,
    "other":         5
  },

  "last_90_day_metrics": {
    "monthly_revenue_usd":            148000,
    "monthly_leads":                  640,
    "lead_to_booked_call_rate_pct":   18,
    "average_ticket_usd":             420
  },

  "prior_assets": {
    "audit":              "public/r/acme-med-spa.html",
    "proposal":           "public/r/acme-med-spa-proposal.html",
    "intelligence_brief": null
  },

  "constraints": [
    "Founder will not sell the business",
    "Must stay in Florida (medical-board license)",
    "No equity dilution allowed"
  ],

  "stated_goal": "Triple monthly bookings in 18 months without doubling staff.",

  "tech_stack": {
    "crm":            "GoHighLevel",
    "scheduling":     "Vagaro",
    "payment":        "Square",
    "marketing_auto": "Meta + Mailchimp"
  },

  "pricing_tiers": [
    { "name": "First-visit promo", "price_usd": 99,  "description": "First Botox or facial" },
    { "name": "Membership",        "price_usd": 149, "description": "Monthly unlimited brow + 1 facial" },
    { "name": "Treatment package", "price_usd": 1200,"description": "6-session laser" }
  ],

  "average_customer_ltv_usd": 2400
}
```

## What `/cscale` does with this

- **Phase 1** reads the audit at `public/r/acme-med-spa.html` and the proposal at `public/r/acme-med-spa-proposal.html`. Extracts the diagnosed leak, prior recommendations, and commercial terms.
- **Phase 2** uses the 3 known competitors as starter inputs, then expands the list to 5–6 by tiering. Each gets a full profile + ad scrape + funding history.
- **Phase 3** mines reviews + Reddit + G2 for the Tampa medspa ICP voice.
- **Phase 4** produces 10 department playbooks. The Operations and Marketing lanes pull heavily from the stated leak ("can't book leads fast enough") and the channel mix.
- **Phase 5** uses the customer base, pricing tiers, and LTV to size the expansion-products section. Investor section uses the competitor tier's funding rounds as comparables.
- **Phase 6** renders to `public/r/acme-med-spa-cscale.html` plus 8 images at `public/images/cscale/acme-med-spa/`.

## When fields are missing

The skill won't refuse to run. It will:

1. Skip the field if optional.
2. Prompt you once if strongly recommended.
3. Stop with a one-line "missing X" message if it's required.

The required fields are: `company_name`, `website`, `vertical`, `geo_market`, `engagement_context`, `revenue_range`, `owner_or_stakeholder`. Everything else is recommended or optional.
