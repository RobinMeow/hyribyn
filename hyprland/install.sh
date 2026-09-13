#!/usr/bin/env bash
set -euo pipefail

"$HYRIBYN/hyprland/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/build-and-install.sh"
