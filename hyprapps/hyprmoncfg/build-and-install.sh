#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
SOURCERER_DEST="$HYRIBYN_ROOT" source "$HYRIBYN/sourcerer/sourcerer.sh"

function hyprmoncfg_build_and_install() {
	go build -o "bin/hyprmoncfg" "./cmd/hyprmoncfg"
	go build -o "bin/hyprmoncfgd" "./cmd/hyprmoncfgd"
	install -Dm755 "bin/hyprmoncfg" "$HOME/.local/bin/hyprmoncfg"
	install -Dm755 "bin/hyprmoncfgd" "$HOME/.local/bin/hyprmoncfgd"
}

function hyprmoncfg_installed() {
	command -v hyprmoncfg >/dev/null 2>&1 &&
		command -v hyprmoncfgd >/dev/null 2>&1
}

source "$HYRIBYN/versions.sh"

check_source_state \
	"hyprmoncfg" \
	"$HYRIBYN_HYPRMONCFG_GITREV"

source_git "https://github.com/crmne/hyprmoncfg.git"
