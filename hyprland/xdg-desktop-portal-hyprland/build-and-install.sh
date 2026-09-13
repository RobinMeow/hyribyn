#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function xdg-desktop-portal-hyprland_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function xdg-desktop-portal-hyprland_installed() {
	# this one is is actually distro depended, so I extracted, it into
	# a distro specific file. perhaps even distro version depended.
	HYRIBYN_DISTRO=${HYRIBYN_DISTRO:-"fedora"}
	"$HYRIBYN/hyprland/xdg-desktop-portal-hyprland/is-installed-$HYRIBYN_DISTRO.sh"
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"xdg-desktop-portal-hyprland" \
	"$HYRIBYN_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV"

source_git "https://github.com/hyprwm/xdg-desktop-portal-hyprland"
