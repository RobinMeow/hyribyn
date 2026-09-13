#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprland-guiutils_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hyprland-guiutils_installed() {
	command -v hyprland-dialog >/dev/null 2>&1 &&
		command -v hyprland-donate-screen >/dev/null 2>&1 &&
		command -v hyprland-run >/dev/null 2>&1 &&
		command -v hyprland-update-screen >/dev/null 2>&1 &&
		command -v hyprland-welcome >/dev/null 2>&1
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprland-guiutils" \
	"$HYRIBYN_HYPRLAND_GUIUTILS_GITREV"

source_git "https://github.com/hyprwm/hyprland-guiutils"
