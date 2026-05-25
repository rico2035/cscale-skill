# Security

## What this repo ships

This repository contains **no API keys, no tokens, no credentials, and no private endpoints**.

The `/cscale` skill is a markdown-and-HTML orchestration package for Claude Code. It runs inside your existing Claude Code session and uses your own authentication for everything it touches:

- **Claude Code itself** uses your Claude Code login. The skill never sees or transmits your API key.
- **Higgsfield** (optional, used for image generation) uses your own `higgsfield` CLI session if you have one installed. The skill never reads or transmits Higgsfield credentials.
- **Git / GitHub** uses your local git config. The skill never pushes anywhere it isn't already authenticated.

If you find a key, token, password, or other credential committed anywhere in this repo, that is a defect. Please report it.

## What this repo does NOT send anywhere

- **No telemetry.** The skill writes a local-only file at `.claude/cscale-telemetry.json` in your project for your own record. Nothing is transmitted to Novatar, the maintainer, or any third party. To disable telemetry entirely, simply do not create that file (or delete it).
- **No analytics.** The installers (`install.sh`, `install.ps1`) do not phone home. They download files from GitHub and copy them into `~/.claude/skills/cscale/`. That's it.
- **No background processes.** The skill does no work outside the foreground Claude Code session.

## Reporting a security issue

For vulnerabilities, sensitive disclosures, or any concern you'd rather not file publicly, email:

```
security@novatar.ai
```

For non-sensitive issues (typos, broken links, doc bugs, missing dependencies), open a public issue on GitHub.

Please **do not** post potential vulnerabilities to public issues, social media, or pull-request comments before they have been triaged.

## Supply chain

The skill itself is plain markdown, HTML, and CSS. There is no JavaScript runtime, no compiled code, and no third-party binary in this repository.

The installers (`install.sh`, `install.ps1`) use standard system tools (`curl`, `tar`, `Invoke-WebRequest`, `Expand-Archive`) only. Read them before piping to `bash` or `iex` if you want to verify.

## Scope of trust

When you install `/cscale`, you are trusting:

1. **The maintainer of this repo** (Ric S Kolluri / Novatar.ai) to ship clean files.
2. **GitHub** to serve the files you requested.
3. **Anthropic's Claude Code** to execute the skill correctly inside your session.
4. **The sub-skills you separately install** (gstack, etc.) to behave as documented. `/cscale` orchestrates them but is not responsible for their behavior.

If any of those trust assumptions feel uncomfortable, you can read every file in this repo before installing. It is all plain text.
