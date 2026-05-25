# /cscale Sub-skill Orchestration Map

Which sub-skills `/cscale` calls in each phase, with what arguments, in what order, and what they return.

---

## Sub-skill catalog by phase

### Phase 1. Context load

| Sub-skill | Purpose | Sequential or parallel |
|---|---|---|
| (none) | Pure file I/O plus WebFetch | n/a |

No sub-skills. Phase 1 is read-only file work plus a live-site fetch.

### Phase 2. Tiered competitor map

| Sub-skill | Purpose | When called | Output |
|---|---|---|---|
| `/competitors` | Identify 8 to 10 candidate competitors | Once at phase start, sequential | Candidate list |
| `/competitor-profiling` | Build full profile per competitor | After tiering, 5 to 6 parallel calls | `phase2-competitors/<slug>.json` |
| `/competitive-ads-extractor` | Scrape Facebook plus LinkedIn ad libraries per competitor | Parallel with profiling | Ad screenshots plus messaging analysis |
| `/deep-research` | Funding history, growth-stage signals per competitor | Parallel with profiling | Funding rounds, key terms |

**Prompt scaffolding for `/competitors`:**
```
Identify 8 to 10 candidate competitors for <company_name> (<vertical>, <geo>).
Mix near-peers (similar revenue), mid-tier (3 to 5x ahead), and aspirational (10x or more ahead).
For each: name, URL, one-line description, rough revenue estimate, why they're relevant.
```

**Prompt scaffolding for `/competitor-profiling`:**
```
Build a full profile for <competitor_name> at <url>. Required fields:
name, url, revenue_estimate with source, employee_count with source,
funding_history (each round with date/amount/lead/valuation/terms),
pricing_model, icp in customer voice, top 3 channels, one-line differentiator.
Cite every numeric claim.
```

### Phase 3. Customer and market reality check

| Sub-skill | Purpose | Sequential or parallel |
|---|---|---|
| `/customer-research` | ICP, JTBD, objections, demographic patterns | Sequential, single call |

**Prompt scaffolding:** see [methodology.md](methodology.md) Phase 3 for the exact text.

### Phase 4. Department playbooks

10 parallel Agent calls. Each gets phase1-context.json plus phase3-icp.json plus the Phase 2 competitor summary plus the lane brief.

| Lane | Sub-skills called inside the lane |
|---|---|
| Executive | `/ab-testing`, `/pricing` |
| Product | `/content-strategy`, `/customer-research` (already done, reuse), `/ab-testing` |
| Engineering | (no marketing skill; first-principles roadmap from JTBD) |
| Marketing (Growth) | `/cro`, `/ads`, `/ab-testing`, `/free-tools`, `/lead-magnets`, `/launch` |
| Marketing (Brand) | `/copywriting`, `/copy-editing`, `/social`, `/marketing-psychology` |
| Marketing (Content) | `/content-strategy`, `/programmatic-seo`, `/ai-seo`, `/copywriting` |
| Marketing (Paid) | `/ads`, `/ad-creative`, `/competitive-ads-extractor` (reuse Phase 2 output) |
| Marketing (SEO) | `/seo-audit`, `/programmatic-seo`, `/schema`, `/ai-seo` |
| Marketing (Social) | `/social`, `/community-marketing` |
| Marketing (Email) | `/emails`, `/cold-email` |
| Sales | `/sales-enablement`, `/sales-icp`, `/sales-outreach`, `/sales-objections`, `/sales-prospect`, `/cold-email` |
| Customer Success | `/churn-prevention`, `/onboarding`, `/signup`, `/paywalls` |
| Operations | `/analytics` |
| People | (no marketing skill; org-design pass) |
| Data | `/analytics`, `/ab-testing` |
| AI | `/image` plus your AI agent catalog (Sam, Cloe, Maya, Jessica, etc., or your overrides per cscale.config.json) |

Marketing rolls up the 7 sub-lanes when rendered. The on-page presentation is 10 swim lanes, with the Marketing lane expanding into 7 accordion-style sub-lanes.

### Phase 5. Bonus sections

4 parallel Agent calls.

| Bonus | Sub-skills called |
|---|---|
| Pivot scenarios | (reasoning over Phase 4 outputs; no sub-skill) |
| Expansion products | `/pricing`, `/ab-testing`, `/customer-research` (reuse) |
| Retargeting | `/ads`, `/emails`, `/sms` (if present), `/churn-prevention` |
| Investor targets | `/deep-research` |

### Phase 6. Render and ship

| Sub-skill | Purpose |
|---|---|
| `/image` | Generate the 8-image batch via Higgsfield `nano_banana_2` |

---

## Master sub-skill registry

The full set of sub-skills `/cscale` may call across all phases. Verify each exists by checking `~/.claude/skills/<name>/` or the active-skills list. If missing, the orchestrator falls back to inline prompting (see the Fallbacks section below).

| Skill | Phase(s) | One-line purpose for /cscale | Time per call |
|---|---|---|---|
| `deep-research` | 2, 5 | Funding history, investor research, citation-tracked reports | 10 to 20 min |
| `competitive-ads-extractor` | 2 | Pull competitor ads from FB / LinkedIn libraries | 5 min per competitor |
| `competitors` | 2 | Identify candidate competitors | 5 min |
| `competitor-profiling` | 2 | Full structured profile per competitor | 8 to 12 min per competitor |
| `customer-research` | 3 | Reviews, JTBD, objections | 20 min |
| `cro` | 4 | Conversion-rate-optimization work items | 5 to 10 min per lane |
| `copywriting` | 4 | Page-level copy work items | 5 to 10 min per lane |
| `copy-editing` | 4 | Existing-copy refresh work items | 3 to 5 min per lane |
| `ads` | 4 | Paid-campaign strategy work items | 5 to 10 min per lane |
| `ad-creative` | 4 | Headlines, descriptions, RSAs | 5 min per lane |
| `emails` | 4 | Lifecycle email sequences | 5 to 10 min per lane |
| `cold-email` | 4 | B2B prospecting sequences | 5 min per lane |
| `marketing-psychology` | 4 | Persuasion principles applied to copy | 5 min per lane |
| `programmatic-seo` | 4 | City pages, vertical pages at scale | 8 to 15 min per lane |
| `ai-seo` | 4 | LLM citation strategy | 5 to 10 min per lane |
| `seo-audit` | 4 | Technical SEO audit work items | 8 min per lane |
| `schema` | 4 | Structured data work items | 5 min per lane |
| `social` | 4 | Social calendar plus brand voice | 5 to 10 min per lane |
| `community-marketing` | 4 | Community plays | 5 min per lane |
| `analytics` | 4 | Tracking plan plus event taxonomy | 8 to 12 min per lane |
| `ab-testing` | 4, 5 | Experiment backlog | 5 to 10 min per lane |
| `launch` | 4 | Launch playbook for new product lines | 8 min per lane |
| `popups` | 4 | Modal and popup copy | 3 min per lane |
| `free-tools` | 4 | Free-tool lead-magnet ideas | 5 min per lane |
| `lead-magnets` | 4 | Gated-content ideas | 5 min per lane |
| `co-marketing` | 4 | Partner program design | 5 to 10 min per lane |
| `referrals` | 4 | Customer referral program | 5 min per lane |
| `churn-prevention` | 4 | Cancel flows, save offers, dunning | 8 min per lane |
| `onboarding` | 4 | Activation flow work items | 5 to 10 min per lane |
| `signup` | 4 | Signup-flow work items | 5 min per lane |
| `paywalls` | 4 | Upgrade-flow work items | 5 min per lane |
| `pricing` | 4, 5 | Pricing experiments and bundles | 8 min per lane |
| `sales-enablement` | 4 | Battle cards, one-pagers | 5 to 10 min per lane |
| `sales-icp` | 4 | ICP definition | 5 min per lane |
| `sales-outreach` | 4 | Outbound sequences | 5 to 10 min per lane |
| `sales-objections` | 4 | Objection handling | 5 min per lane |
| `sales-prospect` | 4 | Prospect list building | 5 to 10 min per lane |
| `sales-research` | 4 | Account research | 5 min per lane |
| `content-strategy` | 4 | Topic clusters, editorial calendar | 8 to 15 min per lane |
| `image` | 6 | Image generation via Higgsfield | 1 to 2 min per image |

Most of these skills are distributed by gstack. See the project README for the canonical link and install command.

---

## Parallelization plan

ASCII flow.

```
                        START
                          |
                       Phase 1 (15m sequential)
                          |
                       Phase 2 start
                          |
                       /competitors (5m sequential)
                          |
                       tiering decision
                          |
        +-----------------+-----------------+-----------------+
        |                 |                 |                 |
   competitor-1      competitor-2      competitor-3      competitor-4/5/6
   (profile +        (profile +        (profile +        (profile +
    ads +             ads +             ads +             ads +
    funding)          funding)          funding)          funding)
        |                 |                 |                 |
        +-----------------+-----------------+-----------------+
                          |
                       Phase 3 (30m sequential)
                          |
                       Phase 4 start
                          |
        +---+---+---+---+---+---+---+---+---+---+
        |   |   |   |   |   |   |   |   |   |   |
       Exec Prod Eng Mkt Sale CS  Ops Peop Data AI
        +---+---+---+---+---+---+---+---+---+---+
                          |
                       Phase 5 start
                          |
        +----------+----------+----------+
        |          |          |          |
      Pivots   Expansion  Retarget   Investors
        +----------+----------+----------+
                          |
                       Phase 6 start
                          |
                       Image batch (parallel via Higgsfield)
                          |
                       Render template
                          |
                       Quality bar
                          |
                       Commit + push
                          |
                         END
```

Wall clock with aggressive parallelization. 4 to 6 hours.

---

## Fallbacks when a sub-skill is missing

If a Glob check for `~/.claude/skills/<name>/` returns no match, the orchestrator falls back to inline prompting. Fallback prompt scaffolds for the 5 most critical:

### deep-research fallback
```
Research <topic>. Use web search to find primary sources. For each claim, cite the URL.
Synthesize findings into a structured report with sections: scope, key findings, sources.
Be skeptical of single-source claims. Triangulate when possible.
```

### competitors fallback
```
Identify 8 to 10 competitors for <company> in <vertical> at <geo>.
For each: name, URL, rough revenue estimate, why relevant.
Include some near-peers, some 3 to 5x ahead, some 10x or more ahead.
```

### customer-research fallback
```
Research the target customer for <company> in <vertical> at <geo>.
Sources: Reddit (scoped to geo), G2/Trustpilot for the company and competitors, Google reviews local.
Synthesize: ICP-in-a-paragraph in customer voice, top 3 JTBD with quotes, top 5 objections with quotes.
```

### cro fallback
```
For <company> at <url>, identify the 5 highest-impact conversion improvements.
For each: where (page or component), what (specific change), why (data signal or principle), expected lift range.
```

### ads fallback
```
For <company> in <vertical> at <geo>, design a paid-media plan.
Channels in priority order. Audience targeting per channel. Estimated CPC/CPL range.
Bid strategy. Initial budget recommendation. Success metrics.
```

---

## Cost and timing budget

| Phase | Wall clock target | Token budget rough |
|---|---|---|
| Phase 1 | 15 min | 30k tokens |
| Phase 2 | 45 to 60 min | 250k tokens (6 parallel competitor sub-tasks) |
| Phase 3 | 30 min | 50k tokens |
| Phase 4 | 90 to 120 min | 400k tokens (10 parallel lane sub-tasks) |
| Phase 5 | 45 min | 150k tokens (4 parallel bonus sub-tasks) |
| Phase 6 | 30 min | 60k tokens plus ~8 Higgsfield generations |
| **Total** | **4 to 6 hours** | **~940k tokens plus image gen cost** |

Cost is justified by the deliverable's $10k-plus retainer-expansion outcome. The skill is intentionally aggressive on parallelization because the standing rule is "spin up maximum parallel agents."
