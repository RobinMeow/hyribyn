#!/usr/bin/env bash
set -euo pipefail

if command -v hyprshutdown >/dev/null 2>&1; then
	hyprshutdown
else
	hyprctl dispatch 'hl.dsp.exit()'
fi
