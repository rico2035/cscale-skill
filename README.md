# /cscale

**Generate a 12-to-18-month company scaling strategy report as a single noindex HTML file, in one Claude Code command.**

Built by [Ric S Kolluri](https://novatar.ai) at [Novatar.ai](https://novatar.ai). MIT-licensed. **Attribution required** (see [License](#license)).

---

## What `/cscale` produces

A single, brand-styled, noindex HTML strategy report at `public/r/<slug>-cscale.html` containing:

- **Topline + verdict bar** with current revenue, 18-month target, payback months
- **TLDR ladder** with three altitude bands: peer, mid-tier, aspirational
- **Where the company is today** (channel mix, biggest leak, prior-recommendation status)
- **Tiered competitor map** of 5 to 6 competitors with funding, ads, pricing, ICP
- **18-month thesis** as a single readable paragraph
- **10 department playbooks** (Executive, Product, Engineering, Marketing, Sales, Customer Success, Operations, People, Data, AI) with week-numbered work items, owners, success metrics
- **AI optimization layer** showing which AI agent plugs into which department in which week
- **Four bonus sections**: pivot scenarios, expansion products to existing customers, retargeting plays, investor targets with comparable financials
- **30 / 60 / 90 day execution** plan
- **Risks and dependencies**
- **Call-to-action** for the next engagement step

Output runs 80 to 250 KB of self-contained HTML with inline SVG charts and 8 brand-styled images (when Higgsfield is configured).

Typical wall clock: **4 to 6 hours** end to end, ~940k Claude tokens, ~8 image generations. Designed as a $10k-plus deliverable.

---

## Install — single command

### macOS / Linux / WSL

```bash
curl -fsSL https://raw.githubusercontent.com/<OWNER>/cscale-skill/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/<OWNER>/cscale-skill/main/install.ps1 | iex
```

> **Inspect before piping.** If you prefer to read the installer first (recommended for any `curl | bash` pattern), open `install.sh` / `install.ps1` in this repo, then run it locally:
>
> ```bash
> git clone https://github.com/<OWNER>/cscale-skill.git
> cd cscale-skill
> bash install.sh        # or: powershell ./install.ps1
> ```

The installer copies the `cscale/` folder into `~/.claude/skills/cscale/`. Once installed, `/cscale` is available in any Claude Code session.

> **Replace `<OWNER>`** with the GitHub username or org that hosts the published repo (see [TODO before publishing](#todo-before-publishing) below).

---

## Quick start

In any Claude Code session, after install:

```
/cscale "Acme Med Spa" https://acmemedspa.com
```

Claude will load the skill, run the pre-flight checks, and walk you through the 6-phase pipeline. Output lands at `public/r/acme-med-spa-cscale.html` (the slug is derived from the company name) plus images at `public/images/cscale/acme-med-spa/`.

You can also pass a structured intake file. See [`examples/intake-example.md`](examples/intake-example.md) and `cscale/templates/intake.md` for the full schema.

---

## Required dependencies

| What | Required? | Why | How to install |
|---|---|---|---|
| **Claude Code** | Yes | This is a Claude Code skill | https://claude.com/claude-code |
| **git** | Yes | Phase 6 commits the rendered HTML | https://git-scm.com |
| **bash** (macOS/Linux/WSL) **or PowerShell** (Windows) | Yes | The installer | Pre-installed on every modern system |
| **Higgsfield CLI** | Optional | Generates the 8 brand images per report. If missing, the report renders text-only with `.no-images` body class. | https://higgsfield.ai (or set up later; the skill degrades gracefully) |
| **Node.js + npm** | Optional | Only needed if your host project has a `npm run build` step the skill can run as a quality gate | https://nodejs.org |

---

## Sub-skills `/cscale` calls

`/cscale` is an orchestrator. It calls 35+ other Claude Code skills across its six phases. **Install them separately** before the first run if you want the full-quality output. Without them, the skill falls back to inline prompting (lower-quality but still functional output).

### Built into Claude Code (no install required)

`WebFetch`, `Glob`, `Read`, `Write`, `Bash`, `Edit`, `Grep`, `Agent`, `TodoWrite`.

### From gstack — install separately

Most sub-skills below are distributed by [gstack](https://github.com/gstack/skills) (confirm the exact repo URL with the gstack maintainer before relying on this link — gstack is an independent project not affiliated with this repo).

Install gstack to get all of these in one go. Or install individually if you only want some.

| Skill | Phase(s) used in cscale | Purpose |
|---|---|---|
| `deep-research` | 2, 5 | Funding history, investor research, citation-tracked reports |
| `competitors` | 2 | Identify 8 to 10 candidate competitors |
| `competitor-profiling` | 2 | Full structured profile per competitor |
| `competitive-ads-extractor` | 2 | Pull competitor ads from FB / LinkedIn libraries |
| `customer-research` | 3, 4, 5 | Reviews, JTBD, objections, ICP voice |
| `cro` | 4 | Conversion-rate-optimization work items |
| `copywriting` | 4 | Page-level copy work items |
| `copy-editing` | 4 | Existing-copy refresh work items |
| `ads` | 4, 5 | Paid-campaign strategy |
| `ad-creative` | 4 | Headlines, descriptions, RSAs |
| `emails` | 4, 5 | Lifecycle email sequences |
| `cold-email` | 4 | B2B prospecting sequences |
| `marketing-psychology` | 4 | Persuasion principles applied to copy |
| `programmatic-seo` | 4 | City pages, vertical pages at scale |
| `ai-seo` | 4 | LLM citation strategy |
| `seo-audit` | 4 | Technical SEO audit |
| `schema` | 4 | Structured data work items |
| `social` | 4 | Social calendar plus brand voice |
| `community-marketing` | 4 | Community plays |
| `analytics` | 4 | Tracking plan plus event taxonomy |
| `ab-testing` | 4, 5 | Experiment backlog |
| `launch` | 4 | Launch playbook for new product lines |
| `popups` | 4 | Modal and popup copy |
| `free-tools` | 4 | Free-tool lead-magnet ideas |
| `lead-magnets` | 4 | Gated-content ideas |
| `co-marketing` | 4 | Partner program design |
| `referrals` | 4 | Customer referral program |
| `churn-prevention` | 4, 5 | Cancel flows, save offers, dunning |
| `onboarding` | 4 | Activation flow work items |
| `signup` | 4 | Signup-flow work items |
| `paywalls` | 4 | Upgrade-flow work items |
| `pricing` | 4, 5 | Pricing experiments and bundles |
| `sales-enablement` | 4 | Battle cards, one-pagers |
| `sales-icp` | 4 | ICP definition |
| `sales-outreach` | 4 | Outbound sequences |
| `sales-objections` | 4 | Objection handling |
| `sales-prospect` | 4 | Prospect list building |
| `sales-research` | 4 | Account research |
| `content-strategy` | 4 | Topic clusters, editorial calendar |
| `image` | 6 | Image generation via Higgsfield |
| `sms` | 5 | (optional) SMS retargeting flows |

### Degrades gracefully

If a sub-skill isn't installed when `/cscale` tries to call it, the orchestrator logs a one-line warning and falls back to inline prompting for that phase. The report still renders, but depth varies by which skills are missing. The phases most affected if you skip the install:

- **Phase 2** without `deep-research` and `competitors`: competitor map will be shallower and lack funding data.
- **Phase 3** without `customer-research`: ICP voice will be inferred, not mined.
- **Phase 5 Bonus 4** without `deep-research`: investor section will be a list of categories, not named funds.
- **Phase 6** without `image`: report renders text-only.

For the full $10k deliverable depth, install gstack.

---

## Configuration

### Override the AI agent names

The methodology uses a concrete catalog of AI agents (Cloe receptionist, Maya scheduling, Sam qualified-inbound, Jessica readiness, Rio reviews, Sofia web chat, Gia SMS, Kai DMs, Theo scheduler, Ava cold-dial outbound) as worked examples. To swap these for your own AI agent names:

1. Copy `cscale.config.example.json` to `~/.claude/skills/cscale/cscale.config.json`
2. Edit the `agents` map to map each example agent to your equivalent
3. The skill will substitute these names throughout the rendered report

If you don't create the file, the example names are used as-is. They function as concrete worked examples that make the AI overlay methodology readable.

### Customize output paths

By default, output lands at:

- HTML: `public/r/<slug>-cscale.html`
- Images: `public/images/cscale/<slug>/`

If your project uses different conventions (e.g., Next.js `public/` vs. Vite `dist/`), edit those paths in `~/.claude/skills/cscale/SKILL.md` under the "Output contract" section before your first run.

### Telemetry (local only)

`/cscale` writes a one-line summary of each run to `.claude/cscale-telemetry.json` in your project. **Nothing is sent over the network.** This file is for your own record (run timings, slug, retainer outcome).

To disable telemetry, simply do not create the file (or delete it after a run). To enable, the skill will create it on first invocation.

---

## License

This project is licensed under the **MIT License** with one explicit attribution expectation:

**You must mention "Built by Ric S Kolluri at Novatar.ai" in any derivative report or product that uses this skill.**

The MIT license already requires the copyright notice to be retained in all copies and substantial portions. This README is restating that requirement in plain language so it's not missed. Concretely:

- Reports generated by `/cscale` should carry a small attribution line in the footer (the included `templates/report.html` already includes this).
- If you fork this repo and ship a modified version, keep the LICENSE file and credit the original work.
- If you use the methodology behind a paid deliverable, a one-line credit ("Methodology by Ric S Kolluri at Novatar.ai") in the deliverable's footer or about-page is the expected courtesy.

The skill is otherwise free to use, fork, modify, and redistribute under MIT terms. See [LICENSE](LICENSE) for the full legal text.

---

## Security

No API keys, tokens, credentials, or private endpoints ship with this repo. The skill uses your own Claude Code session, your own optional Higgsfield session, and your own git config. See [SECURITY.md](SECURITY.md) for the full trust model and how to report security issues.

---

## Contributing

Issues and pull requests welcome. For substantial changes (new phases, new sub-skill integrations, new output sections), open an issue first to discuss the approach.

When contributing:

- Keep the "no AI tells" writing style: no em dashes, no AI vocabulary (leverage, robust, seamless, harness, transformative, etc.), short sentences, numbers lead.
- Don't add telemetry that phones home. Local-only logging only.
- Don't add hardcoded company names, agent names, or paths beyond the example placeholders.

---

## Credits

Methodology refined at [Novatar.ai](https://novatar.ai) across client engagements in 2025 and 2026. The pattern was extracted from a productized $10k+ strategic-scaling deliverable used in sales conversations and retainer expansions.

---

## TODO before publishing

(For the maintainer publishing this repo for the first time.)

- [ ] Replace `<OWNER>` placeholder in the install commands above with the actual GitHub owner/org
- [ ] Confirm the gstack repo URL in the "Sub-skills" table
- [ ] Add a screenshot of an example `/cscale` output to this README (optional but recommended)
- [ ] Confirm `security@novatar.ai` is monitored; otherwise change in SECURITY.md
- [ ] Tag `v1.0.0` after first push
