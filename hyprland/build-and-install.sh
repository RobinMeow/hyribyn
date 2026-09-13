#!/usr/bin/env bash
set -euo pipefail

function hyprland_installed() {
	command -v hyprland >/dev/null 2>&1
}

function hyprland_build_and_install() {
	make release
	sudo make install
}

SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"
source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprland" \
	"$HYRIBYN_HYPRLAND_GITREV"

source_git "https://github.com/hyprwm/Hyprland"
