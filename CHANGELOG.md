# Changelog

All notable changes to `/cscale` will be documented in this file.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] — 2026-05-24

Initial public release.

### Added
- 6-phase methodology (context load, tiered competitor map, customer/market check, 10-lane department playbooks, 4 bonus sections, render + ship).
- Warm-band brand HTML template (`templates/report.html`, 568 lines, hand-built).
- 8-image Higgsfield prompt library (`reference/images.md`).
- Sub-skill orchestration map covering 35+ marketing/sales/research skills (`reference/sub-skills.md`).
- 14-section output spec (`reference/sections.md`).
- Intake checklist with required/recommended/optional fields (`templates/intake.md`).
- Single-command installers (`install.sh` for macOS/Linux/WSL, `install.ps1` for Windows).
- MIT license with attribution requirement (see README).
- `cscale.config.example.json` template for swapping AI agent names.

### Changed (from the internal version this was extracted from)
- Hardcoded telemetry path `docs/PRIME/cscale-reports.json` swapped to local `.claude/cscale-telemetry.json`.
- Internal release-folder reference removed.
- Confidential calibration-run working data excluded from publication.
- Example company names in templates genericized to "Acme Med Spa" placeholder.
- Brand-source comment in `templates/report.html` genericized.

### Security
- Audited: no API keys, tokens, credentials, or private endpoints ship with this repo.
- See [SECURITY.md](SECURITY.md) for reporting and trust model.
