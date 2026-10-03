#!/usr/bin/env bash
# Legt die Labels der Planungsstruktur an (einmalig nach dem Anlegen des Repos).
set -euo pipefail
REPO="${1:?Nutzung: scripts/labels.sh owner/repo}"
gh label clone maestroDev3/game --repo "$REPO" --force
