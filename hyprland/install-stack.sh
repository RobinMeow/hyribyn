#!/usr/bin/env bash
set -euo pipefail

"$HYRIBYN/hyprland/hyprland-protocols/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/hyprland-protocols/build-and-install.sh"

"$HYRIBYN/hyprland/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/build-and-install.sh"
