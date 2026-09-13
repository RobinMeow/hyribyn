#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}

"$HYRIBYN/hyprland/hyprland-protocols/install-deps-$HYRIBYN_DISTRO.sh"

HYRIBYN_DISTRO=${HYRIBYN_DISTRO:-"fedora"} \
	"$HYRIBYN/hyprland/hyprland-protocols/build-and-install.sh"
