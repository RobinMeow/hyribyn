#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprlock_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprlock_installed() {
	command -v "$SOURCE_NAME" >/dev/null 2>&1
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprlock" \
	"$HYRIBYN_HYPRLOCK_GITREV"

source_git "https://github.com/hyprwm/hyprlock.git"
