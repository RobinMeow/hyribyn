#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
source "$HYRIBYN/env.sh"
source "$HYRIBYN/core-utils.sh"
info "syncing hypr"

# TODO: this needs documentation in README.md
rsync -rlpt \
	"$HYRIBYN/bin/"* \
	"$HOME/.local/bin/"

mkdir -p "$HOME/.config/systemd/user/"
rsync -rlpt \
	"$HYRIBYN/lib/hypr/hyprland-session.target" \
	"$HOME/.config/systemd/user/"
