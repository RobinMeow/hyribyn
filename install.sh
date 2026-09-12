#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/hypr/env.sh"
[[ "$RIBYN_HYPR_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing hypr"

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/lib/hypr/install-hypr-from-source.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		hyprland \
		hyprshutdown \
		hyprpaper \
		hyprpolkitagent \
		xdg-desktop-portal-hyprland \
		wireplumber \
		brightnessctl \
		hyprpicker \
		hyprlock \
		qt6ct
	# hyprpolkitagent auth ui (type in password, when I need admin privl. via GUI apps)
	# xdg-desktop-portal-hyprland (asks for perm. when an app wants to do outside its own window, for security. e.g. screen sharing via discord)
	# (wireplumber) wpctl and brightnessctl are used for keybind for multimedia
	# keyboard buttons, like the fn keys on a laptop
	# grim slurp swappy: screenshot tools that work good together
	# qt5ct qt6ct for dark themed qt apps. also required for live switching themes.
	# removed qt5ct. apparently I can only choose one of em
	# hyprpicker is just nice to have. install standalone cli tool.
elif on_fedora; then
	"$RIBYN_ROOT/lib/hypr/build-stack-from-source.sh"

	# hyprpolkitagent
	# CMake Warning (dev) at /usr/lib64/cmake/Qt6Core/Qt6CoreMacros.cmake:3565 (message):
	#   Qt policy QTP0004 is not set: You need qmldir files for each extra
	#   directory that contains .qml files for your module.  Check
	#   https://doc.qt.io/qt-6/qt-cmake-policy-qtp0004.html for policy details.
	#   Use the qt_policy command to set the policy and suppress this warning.
	#
	# Call Stack (most recent call first):
	#   /usr/lib64/cmake/Qt6Qml/Qt6QmlMacros.cmake:4013 (__qt_internal_setup_policy)
	#   /usr/lib64/cmake/Qt6Qml/Qt6QmlMacros.cmake:1035 (qt6_target_qml_sources)
	#   /usr/lib64/cmake/Qt6Qml/Qt6QmlMacros.cmake:1507 (qt6_add_qml_module)
	#   CMakeLists.txt:35 (qt_add_qml_module)
	# This warning is for project developers.  Use -Wno-dev to suppress it.
	sudo dnf install --assumeyes \
		qt6-qtwayland-devel \
		polkit-devel \
		polkit-qt6-1-devel
	hypr_install "hyprpolkitagent" \
		"https://github.com/hyprwm/hyprpolkitagent.git" \
		"$RIBYN_HYPR_HYPRPOLKITAGENT_GITREV" \
		'[[ -x "/usr/libexec/hyprpolkitagent" ]]'

	sudo dnf install --assumeyes \
		wireplumber \
		brightnessctl \
		qt6ct

	# SC2016 $SOURCE_NAME does not expand here on purpose
	# shellcheck disable=SC2016
	source_bin_exists='command -v $SOURCE_NAME >/dev/null 2>&1'
	hypr_install "hyprshutdown" \
		"https://github.com/hyprwm/hyprshutdown.git" \
		"$RIBYN_HYPR_HYPRSHUTDOWN_GITREV" \
		"$source_bin_exists"

	hypr_install "hyprpaper" \
		"https://github.com/hyprwm/hyprpaper.git" \
		"$RIBYN_HYPR_HYPRPAPER_GITREV" \
		"$source_bin_exists"

	sudo dnf install --assumeyes \
		pam-devel \
		libxkbcommon-devel
	# NOTE: xkbcommon is explicitly listed on hyprpicker gh
	# even tho it builds and installs without. prolly runtime dep.
	hypr_install "hyprlock" \
		"https://github.com/hyprwm/hyprlock.git" \
		"$RIBYN_HYPR_HYPRLOCK_GITREV" \
		"$source_bin_exists"

	sudo dnf install --assumeyes \
		libjpeg-turbo-devel \
		libxkbcommon-devel
	# NOTE: xkbcommon is explicitly listed on hyprpicker gh
	# even tho it builds and installs without. prolly runtime dep.
	hypr_install "hyprpicker" \
		"https://github.com/hyprwm/hyprpicker" \
		"$RIBYN_HYPR_HYPRPICKER_GITREV" \
		"$source_bin_exists"
else
	exit_with_distro_not_supported_msg
fi

# hyprmoncfg only offers yay for arch
# so even on arch I prefer build from source
function build_hyprmoncfg() {
	run_on_arch \
		sudo pacman -S --needed --noconfirm \
		go

	run_on_fedora \
		sudo dnf install --assumeyes \
		go

	go build -o "bin/hyprmoncfg" "./cmd/hyprmoncfg"
	go build -o "bin/hyprmoncfgd" "./cmd/hyprmoncfgd"
	install -Dm755 "bin/hyprmoncfg" "$HOME/.local/bin/hyprmoncfg"
	install -Dm755 "bin/hyprmoncfgd" "$HOME/.local/bin/hyprmoncfgd"
}

hypr_install "hyprmoncfg" \
	"https://github.com/crmne/hyprmoncfg.git" \
	"$RIBYN_HYPR_HYPRMONCFG_GITREV" \
	'command -v hyprmoncfg >/dev/null 2>&1 && command -v hyprmoncfgd >/dev/null 2>&1' \
	build_hyprmoncfg

if [[ "$RIBYN_HYPR_HY3_ENABLED" == "yes" ]]; then
	hypr_install "hy3" \
		"https://github.com/outfoxxed/hy3" \
		"$RIBYN_HYPR_HY3_GITREV" \
		'[[ -f "/usr/lib/libhy3.so" ]]'
fi
