#!/usr/bin/env bash
set -euo pipefail

# Ensure jq and hyprctl are available
if ! command -v hyprctl &>/dev/null || ! command -v jq &>/dev/null; then
	echo "Error: hyprctl and jq are required."
	exit 1
fi

# NOTE: the old one which didnt read the max available reso and hz
# (in case the other one fails)
#
# monitor_summary=$(hyprctl monitors -j | jq -r '.[] |
# "• Port: \(.name) [ID: \(.id)]
#   Model: \(.make) \(.model)
#   Serial: \(.serial)
#   Resolution: \(.width)x\(.height) @ \(.refreshRate | round)Hz
#   Active WS: \(.activeWorkspace.name)
# -----------------------------------"')
# Build a clean summary block including max available resolution & Hz

monitor_summary=$(hyprctl monitors -j | jq -r '.[] | 
  # Find the highest resolution and refresh rate from availableModes
  (.availableModes | map(
    capture("(?<w>[0-9]+)x(?<h>[0-9]+)@(?<hz>[0-9.]+)Hz") |
    {w: .w|tonumber, h: .h|tonumber, hz: .hz|tonumber, score: ((.w|tonumber)*(.h|tonumber)*1000 + (.hz|tonumber))}
  ) | max_by(.score) // empty) as $max |
"• Port: \(.name) [ID: \(.id)]
  Model: \(.make) \(.model)
  Serial: \(.serial)
  Current:  \(.width)x\(.height) @ \(.refreshRate | round)Hz
  Max Avail: \($max.w // "N/A")x\($max.h // "N/A") @ \($max.hz // "N/A")Hz
  Description: \(.description)
  Active WS: \(.activeWorkspace.name)
-----------------------------------"')

echo "=== Connected Monitors ==="
echo "$monitor_summary"
