#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/hypr/env.sh"
[[ "$RIBYN_HYPR_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "syncing hypr"

# warn about deprecated hyprland.conf file
hypr_conf="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$hypr_conf" ]]; then
	warn "Deprecated hyprland.conf file detected. Delete it to get rid of this warning."
fi

mkdir -p "$HOME/.config/hypr"
rsync -rlpt \
	--exclude="local/" \
	"$RIBYN_ROOT/lib/hypr/config/" \
	"$HOME/.config/hypr/"

mkdir -p "$HOME/.config/hypr/local"
rsync -rlpt \
	--ignore-existing \
	"$RIBYN_ROOT/lib/hypr/config/local/" \
	"$HOME/.config/hypr/local/"

rsync -rlpt \
	"$RIBYN_ROOT/assets/images/wallpapers/fallen-knight-blossom-field-3840x2160.png" \
	"$HOME/.config/hypr/"
rsync -rlpt "$RIBYN_ROOT/assets/images/wallpapers/car-in-grass.jpg" "$HOME/.config/hypr/"

rsync -rlpt "$RIBYN_ROOT/lib/hypr/hyprbye.sh" "$HOME/.local/bin/hyprbye"

mkdir -p "$HOME/.config/systemd/user/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/hypr/hyprland-session.target" \
	"$HOME/.config/systemd/user/"

# eeyore hyprlock
mkdir -p "$HOME/.config/hypr/eeyore/"
rsync -rlpt "$RIBYN_ROOT/assets/images/eeyore.png" "$HOME/.config/hypr/eeyore/eeyore.png"
# didnt like 'em
# rsync -rlpt "$RIBYN_ROOT/assets/images/eeyore-duck-balloon.jpg" "$HOME/.config/hypr/eeyore/"
# rsync -rlpt "$RIBYN_ROOT/assets/images/eeyore-pink-ribbon.jpg" "$HOME/.config/hypr/eeyore/"
# rsync -rlpt "$RIBYN_ROOT/assets/images/cherry-blossom-blue-sky-frog-eye-view.jpg" "$HOME/.config/hypr/eeyore/"

hypr_running=${HYPRLAND_INSTANCE_SIGNATURE:-"not running"}
if [[ $hypr_running == "not running" ]]; then
	info "hyprland is not running. skipping reload config."
else
	info "try reloading hyprland config."
	hyprctl reload
fi

# i-am-root hyprlock
mkdir -p "$HOME/.config/hypr/i-am-root/"

# background
rsync -rlpt \
	"$RIBYN_ROOT/assets/images/groot-relaxing-in-grass.jpg" \
	"$HOME/.config/hypr/i-am-root/"

# profile image (appearance-wise)
rsync -rlpt \
	"$RIBYN_ROOT/assets/images/good-morning-groot.jpg" \
	"$HOME/.config/hypr/i-am-root/"

"$RIBYN_ROOT/lib/hypr/sync-fallen-knight.sh"
