#!/usr/bin/env bash
set -euo pipefail

# i think this updates everytime I run the scripts.
# will need some detection to avoid running this on every install run

hyprpm update

# INFO: using yes because hyprpm doesnt offer no-ask or no-confirm flags as
# any good package manager should do for non interactive runs
yes | hyprpm add "https://github.com/hyprwm/hyprland-plugins"
hyprpm enable
