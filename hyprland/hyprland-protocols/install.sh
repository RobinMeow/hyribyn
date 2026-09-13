#!/usr/bin/env bash
set -euo pipefail

HYRIBYN="$HYRIBYN_ROOT/hyribyn"
"$HYRIBYN/hyprland/hyprland-protocols/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/hyprland-protocols/build-and-install.sh"
