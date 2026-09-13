#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
export HYRIBYN_DISTRO=${HYRIBYN_DISTRO:-"fedora"}

# every project uses cmake to build and install
# if you don't use the recommended installation,
# you have to intall these yourself, or call them
# yourself.
"$HYRIBYN/hyprland/install-cmake-deps-$HYRIBYN_DISTRO.sh"

"$HYRIBYN/common/install.sh" "hyprland-protocols"
"$HYRIBYN/common/install.sh" "hyprwayland-scanner"
"$HYRIBYN/common/install.sh" "hyprutils"
"$HYRIBYN/common/install.sh" "hyprgraphics"
"$HYRIBYN/common/install.sh" "hyprlang"
"$HYRIBYN/common/install.sh" "hyprcursor"

# aquamarine depends on this, as well as others
"$HYRIBYN/hyprland/install-wayland-deps.sh"
"$HYRIBYN/common/install.sh" "aquamarine"

"$HYRIBYN/common/install.sh" "xdg-desktop-portal-hyprland"
"$HYRIBYN/common/install.sh" "hyprwire"
"$HYRIBYN/common/install.sh" "hyprtoolkit"

# hyprland itself
"$HYRIBYN/hyprland/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/build-and-install.sh"

# runtime-only dependency. formerly hyprland-qtutils
"$HYRIBYN/common/install.sh" "hyprland-guiutils"
