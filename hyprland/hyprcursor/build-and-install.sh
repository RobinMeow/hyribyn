#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprcursor_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprcursor_installed() {
	pkg-config --exists "$SOURCE_NAME"
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprcursor" \
	"$HYRIBYN_HYPRCURSOR_GITREV"

source_git "https://github.com/hyprwm/hyprcursor"
