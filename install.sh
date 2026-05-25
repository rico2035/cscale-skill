#!/usr/bin/env bash
#
# /cscale installer (macOS / Linux / WSL)
#
# Copies the cscale skill into ~/.claude/skills/cscale/ so Claude Code can find it.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/<OWNER>/cscale-skill/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/<OWNER>/cscale-skill/main/install.sh | bash -s -- -y
#
# Local usage (from a cloned checkout):
#   bash install.sh
#   bash install.sh -y     # skip overwrite prompt
#
# Built by Ric S Kolluri at Novatar.ai. MIT licensed. See LICENSE.

set -euo pipefail

REPO_OWNER="${CSCALE_REPO_OWNER:-<OWNER>}"
REPO_NAME="${CSCALE_REPO_NAME:-cscale-skill}"
REPO_REF="${CSCALE_REPO_REF:-main}"
TARBALL_URL="https://codeload.github.com/${REPO_OWNER}/${REPO_NAME}/tar.gz/${REPO_REF}"

ASSUME_YES=0
for arg in "$@"; do
  case "$arg" in
    -y|--yes) ASSUME_YES=1 ;;
    -h|--help)
      sed -n '1,20p' "$0"
      exit 0
      ;;
  esac
done

SKILLS_DIR="${HOME}/.claude/skills"
TARGET_DIR="${SKILLS_DIR}/cscale"

bold()   { printf '\033[1m%s\033[0m\n' "$*"; }
green()  { printf '\033[32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[33m%s\033[0m\n' "$*"; }
red()    { printf '\033[31m%s\033[0m\n' "$*" >&2; }

bold "/cscale installer"
echo

# 1. Sanity: required tools
for tool in curl tar mkdir cp rm; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    red "Missing required tool: ${tool}"
    exit 1
  fi
done

# 2. Make sure ~/.claude/skills/ exists
if [ ! -d "${SKILLS_DIR}" ]; then
  echo "Creating ${SKILLS_DIR}"
  mkdir -p "${SKILLS_DIR}"
fi

# 3. Overwrite check
if [ -d "${TARGET_DIR}" ]; then
  if [ "${ASSUME_YES}" -ne 1 ]; then
    yellow "${TARGET_DIR} already exists."
    printf "Overwrite? [y/N] "
    read -r reply </dev/tty || reply="n"
    case "$reply" in
      y|Y|yes|YES) ;;
      *)
        echo "Aborted. Pass -y to skip this prompt."
        exit 0
        ;;
    esac
  fi
  echo "Removing existing ${TARGET_DIR}"
  rm -rf "${TARGET_DIR}"
fi

# 4. Decide source: local checkout vs. remote download
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || echo "")"
if [ -n "${SCRIPT_DIR}" ] && [ -d "${SCRIPT_DIR}/cscale" ]; then
  echo "Installing from local checkout at ${SCRIPT_DIR}"
  cp -R "${SCRIPT_DIR}/cscale" "${TARGET_DIR}"
else
  echo "Downloading ${TARBALL_URL}"
  TMP_DIR="$(mktemp -d -t cscale-install-XXXXXX)"
  trap 'rm -rf "${TMP_DIR}"' EXIT
  if ! curl -fsSL "${TARBALL_URL}" -o "${TMP_DIR}/cscale.tar.gz"; then
    red "Download failed. Check the repo owner/name/ref."
    red "  owner = ${REPO_OWNER}"
    red "  name  = ${REPO_NAME}"
    red "  ref   = ${REPO_REF}"
    exit 1
  fi
  tar -xzf "${TMP_DIR}/cscale.tar.gz" -C "${TMP_DIR}"
  EXTRACTED_ROOT="$(find "${TMP_DIR}" -maxdepth 1 -type d -name "${REPO_NAME}-*" | head -n 1)"
  if [ -z "${EXTRACTED_ROOT}" ] || [ ! -d "${EXTRACTED_ROOT}/cscale" ]; then
    red "Extracted tarball did not contain a cscale/ folder."
    exit 1
  fi
  cp -R "${EXTRACTED_ROOT}/cscale" "${TARGET_DIR}"
fi

# 5. Final report
green "Installed cscale to ${TARGET_DIR}"
echo
bold "Next steps"
echo "  1. Open any project in Claude Code."
echo "  2. Run:  /cscale \"Acme Med Spa\" https://acmemedspa.com"
echo
bold "Sub-skills"
echo "  /cscale calls 35+ other skills (deep-research, competitors, cro, ads, emails, etc.)"
echo "  Most are distributed by gstack. See the README in this repo for the full list."
echo "  Without them, /cscale falls back to inline prompting (lower-quality but still works)."
echo
bold "Optional: Higgsfield for image generation"
echo "  Without it, reports render text-only. Install at https://higgsfield.ai if you want"
echo "  the 8 brand-styled images per report."
echo
bold "License"
echo "  MIT, attribution required. Mention 'Built by Ric S Kolluri at Novatar.ai' in any"
echo "  derivative report. See LICENSE in this repo."
