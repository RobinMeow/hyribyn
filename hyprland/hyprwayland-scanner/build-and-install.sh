#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprwayland-scanner_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprwayland-scanner_installed() {
	pkg-config --exists "$SOURCE_NAME"
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprwayland-scanner" \
	"$HYRIBYN_HYPRWAYLAND_SCANNER_GITREV"

source_git "https://github.com/hyprwm/hyprwayland-scanner.git"
