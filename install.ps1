# /cscale installer (Windows PowerShell)
#
# Copies the cscale skill into $HOME\.claude\skills\cscale\ so Claude Code can find it.
#
# Usage:
#   irm https://raw.githubusercontent.com/<OWNER>/cscale-skill/main/install.ps1 | iex
#
# Local usage (from a cloned checkout):
#   powershell -ExecutionPolicy Bypass -File install.ps1
#   powershell -ExecutionPolicy Bypass -File install.ps1 -Force
#
# Built by Ric S Kolluri at Novatar.ai. MIT licensed. See LICENSE.

[CmdletBinding()]
param(
    [switch]$Force,
    [string]$RepoOwner = $(if ($env:CSCALE_REPO_OWNER) { $env:CSCALE_REPO_OWNER } else { '<OWNER>' }),
    [string]$RepoName  = $(if ($env:CSCALE_REPO_NAME)  { $env:CSCALE_REPO_NAME }  else { 'cscale-skill' }),
    [string]$RepoRef   = $(if ($env:CSCALE_REPO_REF)   { $env:CSCALE_REPO_REF }   else { 'main' })
)

$ErrorActionPreference = 'Stop'

function Write-Title($msg) { Write-Host $msg -ForegroundColor White }
function Write-Ok($msg)    { Write-Host $msg -ForegroundColor Green }
function Write-Warn2($msg) { Write-Host $msg -ForegroundColor Yellow }
function Write-Err($msg)   { Write-Host $msg -ForegroundColor Red }

Write-Title "/cscale installer"
Write-Host ""

$SkillsDir = Join-Path $HOME ".claude\skills"
$TargetDir = Join-Path $SkillsDir "cscale"

# 1. Ensure skills directory exists
if (-not (Test-Path -LiteralPath $SkillsDir)) {
    Write-Host "Creating $SkillsDir"
    New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
}

# 2. Overwrite check
if (Test-Path -LiteralPath $TargetDir) {
    if (-not $Force) {
        Write-Warn2 "$TargetDir already exists."
        $reply = Read-Host "Overwrite? [y/N]"
        if ($reply -notmatch '^(y|Y|yes|YES)$') {
            Write-Host "Aborted. Re-run with -Force to skip this prompt."
            exit 0
        }
    }
    Write-Host "Removing existing $TargetDir"
    Remove-Item -LiteralPath $TargetDir -Recurse -Force
}

# 3. Decide source: local checkout vs. remote download
$ScriptDir = $null
if ($PSCommandPath) {
    $ScriptDir = Split-Path -Parent $PSCommandPath
}
$LocalCscale = if ($ScriptDir) { Join-Path $ScriptDir 'cscale' } else { $null }

if ($LocalCscale -and (Test-Path -LiteralPath $LocalCscale)) {
    Write-Host "Installing from local checkout at $ScriptDir"
    Copy-Item -LiteralPath $LocalCscale -Destination $TargetDir -Recurse
} else {
    $TarUrl = "https://codeload.github.com/$RepoOwner/$RepoName/zip/$RepoRef"
    Write-Host "Downloading $TarUrl"
    $TmpDir = New-Item -ItemType Directory -Path (Join-Path $env:TEMP "cscale-install-$([guid]::NewGuid().ToString('N'))") -Force
    try {
        $ZipPath = Join-Path $TmpDir.FullName 'cscale.zip'
        try {
            Invoke-WebRequest -Uri $TarUrl -OutFile $ZipPath -UseBasicParsing
        } catch {
            Write-Err "Download failed. Check the repo owner/name/ref."
            Write-Err "  owner = $RepoOwner"
            Write-Err "  name  = $RepoName"
            Write-Err "  ref   = $RepoRef"
            exit 1
        }
        Expand-Archive -LiteralPath $ZipPath -DestinationPath $TmpDir.FullName -Force
        $Extracted = Get-ChildItem -LiteralPath $TmpDir.FullName -Directory | Where-Object { $_.Name -like "$RepoName-*" } | Select-Object -First 1
        if (-not $Extracted -or -not (Test-Path -LiteralPath (Join-Path $Extracted.FullName 'cscale'))) {
            Write-Err "Extracted archive did not contain a cscale/ folder."
            exit 1
        }
        Copy-Item -LiteralPath (Join-Path $Extracted.FullName 'cscale') -Destination $TargetDir -Recurse
    } finally {
        if (Test-Path -LiteralPath $TmpDir.FullName) {
            Remove-Item -LiteralPath $TmpDir.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# 4. Final report
Write-Ok "Installed cscale to $TargetDir"
Write-Host ""
Write-Title "Next steps"
Write-Host "  1. Open any project in Claude Code."
Write-Host "  2. Run:  /cscale `"Acme Med Spa`" https://acmemedspa.com"
Write-Host ""
Write-Title "Sub-skills"
Write-Host "  /cscale calls 35+ other skills (deep-research, competitors, cro, ads, emails, etc.)"
Write-Host "  Most are distributed by gstack. See the README in this repo for the full list."
Write-Host "  Without them, /cscale falls back to inline prompting (lower-quality but still works)."
Write-Host ""
Write-Title "Optional: Higgsfield for image generation"
Write-Host "  Without it, reports render text-only. Install at https://higgsfield.ai if you want"
Write-Host "  the 8 brand-styled images per report."
Write-Host ""
Write-Title "License"
Write-Host "  MIT, attribution required. Mention 'Built by Ric S Kolluri at Novatar.ai' in any"
Write-Host "  derivative report. See LICENSE in this repo."
