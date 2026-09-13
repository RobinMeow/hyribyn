#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function aquamarine_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function aquamarine_installed() {
	pkg-config --exists "$SOURCE_NAME"
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"aquamarine" \
	"$HYRIBYN_AQUAMARINE_GITREV"

source_git "https://github.com/hyprwm/aquamarine"
