#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/state/ribyn/"
logfile="$HOME/.local/state/ribyn/build-stack-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

# CMake Recommended
# https://wiki.hypr.land/Getting-Started/Installation/#cmake-recommended
#
# how to build hyprland on fedora
# https://github.com/hyprwm/Hyprland/discussions/284

source "$RIBYN_ROOT/lib/hypr/env.sh"
source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	error "ERROR: Use pacman on archlinux to install hyperland. use pacman -S hyprland instead."
	exit 1
elif on_fedora; then

	# build order because some of these depend on one another:
	#  1. hyprland-protocols (According to Dergo from discord "it's a git submodule of most of the apps that require it. If you don't have it system-wide, cmake just uses the submodule. It's just a few xml files needed to build other stuff)
	#  2. hyprwayland-scanner
	#  3. hyprutils
	#  4. hyprgraphics
	#  5. hyprlang
	#  6. hyprcursor
	#  7. aquamarine
	#  8. xdg-desktop-portal-hyprland
	#  9. hyprwire
	# 10. hyprtoolkit
	# 11. hyprland
	# 12. hyprland-guiutils (runtime-only dependency. formerly hyprland-qtutils)

	# base deps for almost all of them
	sudo dnf install --assumeyes \
		wayland-protocols-devel \
		wayland-devel \
		xorg-x11-server-Xwayland \
		cmake \
		gcc \
		gcc-c++

	source "$RIBYN_ROOT/core/source-manager.sh"
	source "$RIBYN_ROOT/lib/hypr/install-hypr-from-source.sh"

	# SC2016 $SOURCE_NAME does not expand here on purpose
	# shellcheck disable=SC2016
	pkg_config_exists='pkg-config --exists $SOURCE_NAME'

	hypr_install "hyprland-protocols" \
		"https://github.com/hyprwm/hyprland-protocols" \
		"$RIBYN_HYPR_HYPRLAND_PROTOCOLS_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		pugixml-devel
	hypr_install "hyprwayland-scanner" \
		"https://github.com/hyprwm/hyprwayland-scanner.git" \
		"$RIBYN_HYPR_HYPRWAYLAND_SCANNER_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		pixman-devel
	hypr_install "hyprutils" \
		"https://github.com/hyprwm/hyprutils.git" \
		"$RIBYN_HYPR_HYPRUTILS_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		libglvnd-devel \
		cairo-devel \
		pango-devel \
		libdrm-devel \
		libjpeg-turbo-devel \
		libwebp-devel \
		librsvg2-devel \
		file-devel
	# file has libmagick
	# file has libpng-devel
	hypr_install "hyprgraphics" \
		"https://github.com/hyprwm/hyprgraphics.git" \
		"$RIBYN_HYPR_HYPRGRAPHICS_GITREV" \
		"$pkg_config_exists"

	hypr_install "hyprlang" \
		"https://github.com/hyprwm/hyprlang.git" \
		"$RIBYN_HYPR_HYPRLANG_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		libzip-devel \
		tomlplusplus-devel
	hypr_install "hyprcursor" \
		"https://github.com/hyprwm/hyprcursor" \
		"$RIBYN_HYPR_HYPRCURSOR_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		libinput-devel \
		libseat-devel \
		mesa-libgbm-devel \
		systemd-devel \
		libdisplay-info-devel \
		hwdata-devel
	# 	systemd-devel is fedoras version of libudev. see here https://github.com/dcuddeback/libudev-sys
	hypr_install "aquamarine" \
		"https://github.com/hyprwm/aquamarine" \
		"$RIBYN_HYPR_AQUAMARINE_GITREV" \
		"$pkg_config_exists"

	# xdg-desktop-portal-hyprland
	sudo dnf install --assumeyes \
		qt6-qtbase-devel \
		libuuid-devel \
		pipewire-devel \
		sdbus-cpp-devel
	hypr_install "xdg-desktop-portal-hyprland" \
		"https://github.com/hyprwm/xdg-desktop-portal-hyprland" \
		"$RIBYN_HYPR_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV" \
		'[[ -x "/usr/libexec/xdg-desktop-portal-hyprland" ]]'

	# SC2016 $SOURCE_NAME does not expand here on purpose
	# shellcheck disable=SC2016
	hypr_install "hyprwire" \
		"https://github.com/hyprwm/hyprwire.git" \
		"$RIBYN_HYPR_HYPRWIRE_GITREV" \
		"$pkg_config_exists"

	sudo dnf install --assumeyes \
		iniparser-devel \
		inotify-tools-devel
	hypr_install "hyprtoolkit" \
		"https://github.com/hyprwm/hyprtoolkit.git" \
		"$RIBYN_HYPR_HYPRTOOLKIT_GITREV" \
		"$pkg_config_exists"

	is_hyprland_guiutils_installed='command -v hyprland-dialog >/dev/null 2>&1'
	is_hyprland_guiutils_installed="${is_hyprland_guiutils_installed} && command -v hyprland-donate-screen >/dev/null 2>&1"
	is_hyprland_guiutils_installed="${is_hyprland_guiutils_installed} && command -v hyprland-run >/dev/null 2>&1"
	is_hyprland_guiutils_installed="${is_hyprland_guiutils_installed} && command -v hyprland-update-screen >/dev/null 2>&1"
	is_hyprland_guiutils_installed="${is_hyprland_guiutils_installed} && command -v hyprland-welcome >/dev/null 2>&1"
	hypr_install "hyprland-guiutils" \
		"https://github.com/hyprwm/hyprland-guiutils" \
		"$RIBYN_HYPR_HYPRLAND_GUIUTILS_GITREV" \
		"$is_hyprland_guiutils_installed"

	sudo dnf install --assumeyes \
		glslang-devel \
		re2-devel \
		muParser-devel \
		libXcursor-devel \
		xcb-util-errors-devel \
		xcb-util-wm-devel \
		readline-devel \
		lua-devel \
		libeis-devel

	function build_and_install_hyprland() {
		make release
		sudo make install
	}
	hypr_install "hyprland" \
		"https://github.com/hyprwm/Hyprland" \
		"$RIBYN_HYPR_HYPRLAND_GITREV" \
		'command -v hyprland >/dev/null 2>&1' \
		build_and_install_hyprland
else
	error "distro not supported"
fi
