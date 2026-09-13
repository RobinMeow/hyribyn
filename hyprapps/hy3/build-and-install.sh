#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hy3_build_and_install() {
	"$HYRIBYN/common/default-cmake-build-and-install.sh"
}

function hy3_installed() {
	[[ -f "/usr/lib/libhy3.so" ]]
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hy3" \
	"$HYRIBYN_HY3_GITREV"

source_git "https://github.com/outfoxxed/hy3"
