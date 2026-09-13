#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN_ROOT=${HYRIBYN_ROOT:-"$HOME/.local/share/hyribyn"}
export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
source "$HYRIBYN/versions.sh"
echo "syncing hypr"

# TODO: this needs documentation in README.md
rsync -rlpt \
	"$HYRIBYN/bin/"* \
	"$HOME/.local/bin/"

mkdir -p "$HOME/.config/systemd/user/"
rsync -rlpt \
	"$HYRIBYN/lib/hypr/hyprland-session.target" \
	"$HOME/.config/systemd/user/"
