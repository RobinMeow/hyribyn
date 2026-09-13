#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprpolkitagent_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprpolkitagent_installed() {
	[[ -x "/usr/libexec/hyprpolkitagent" ]]
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprpolkitagent" \
	"$HYRIBYN_HYPRPOLKITAGENT_GITREV"

source_git "https://github.com/hyprwm/hyprpolkitagent.git"
