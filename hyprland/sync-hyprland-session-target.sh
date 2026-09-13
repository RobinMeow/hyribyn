#!/usr/bin/env bash
set -euo pipefail

export HYRIBYN_ROOT=${HYRIBYN_ROOT:-"$HOME/.local/share/hyribyn"}
export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
echo "syncing hypr"

if command -v rsync >/dev/null 2>&1; then
	rsync -rlpt \
		"$HYRIBYN/bin/"* \
		"$HOME/.local/bin/"

	mkdir -p "$HOME/.config/systemd/user/"
	rsync -rlpt \
		"$HYRIBYN/hyprland/hyprland-session.target" \
		"$HOME/.config/systemd/user/"
else
	cp \
		"$HYRIBYN/bin/"* \
		"$HOME/.local/bin/"

	mkdir -p "$HOME/.config/systemd/user/"
	cp \
		"$HYRIBYN/hyprland/hyprland-session.target" \
		"$HOME/.config/systemd/user/"
fi
