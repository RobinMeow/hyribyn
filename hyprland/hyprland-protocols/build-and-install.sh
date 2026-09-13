#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprland-protocols_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprland-protocols_installed() {
	pkg-config --exists "$SOURCE_NAME"
}

source "$HYRIBYN/env.sh"

check_source_state \
	"hyprland-protocols" \
	"$HYRIBYN_HYPRLAND_PROTOCOLS_GITREV"

source_git "https://github.com/hyprwm/hyprland-protocols"
