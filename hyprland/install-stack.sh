#!/usr/bin/env bash
set -euo pipefail

"$HYRIBYN/common/install.sh" "hyprland-protocols"
"$HYRIBYN/common/install.sh" "hyprwayland-scanner"

"$HYRIBYN/hyprland/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/build-and-install.sh"
