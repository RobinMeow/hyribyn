#!/usr/bin/env bash
set -euo pipefail

# assign git commits and/or tags to build from source from for each app
# git repos are in "$HOME/.local/share/hyribyn/<appname>"

export HYRIBYN_HYPRUTILS_GITREV=${HYRIBYN_HYPRUTILS_GITREV:-"v0.14.1"}
export HYRIBYN_HYPRWAYLAND_SCANNER_GITREV=${HYRIBYN_HYPRWAYLAND_SCANNER_GITREV:-"v0.4.6"}
export HYRIBYN_AQUAMARINE_GITREV=${HYRIBYN_AQUAMARINE_GITREV:-"v0.14.0"}
export HYRIBYN_HYPRLANG_GITREV=${HYRIBYN_HYPRLANG_GITREV:-"v0.6.8"}
export HYRIBYN_HYPRCURSOR_GITREV=${HYRIBYN_HYPRCURSOR_GITREV:-"v0.1.13"}
export HYRIBYN_HYPRGRAPHICS_GITREV=${HYRIBYN_HYPRGRAPHICS_GITREV:-"v0.5.1"}
export HYRIBYN_HYPRLAND_GITREV=${HYRIBYN_HYPRLAND_GITREV:-"v0.56.0"}
export HYRIBYN_HYPRWIRE_GITREV=${HYRIBYN_HYPRWIRE_GITREV:-"v0.3.1"}
export HYRIBYN_HYPRLAND_GUIUTILS_GITREV=${HYRIBYN_HYPRLAND_GUIUTILS_GITREV:-"v0.2.2"}

# one commit after v0.7.0 they swapped to cmake, so I can reuse my build script :)
export HYRIBYN_HYPRLAND_PROTOCOLS_GITREV=${HYRIBYN_HYPRLAND_PROTOCOLS_GITREV:-"3f3860b869014c00e8b9e0528c7b4ddc335c21ab"}
export HYRIBYN_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV=${HYRIBYN_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV:-"v1.4.1"}

# these are additional apps to hypr, based on hypr. but hypr does not depend on them itself
export HYRIBYN_HYPRTOOLKIT_GITREV=${HYRIBYN_HYPRTOOLKIT_GITREV:-"v0.5.4"}
export HYRIBYN_HYPRPOLKITAGENT_GITREV=${HYRIBYN_HYPRPOLKITAGENT_GITREV:-"v0.1.3"}
export HYRIBYN_HYPRSHUTDOWN_GITREV=${HYRIBYN_HYPRSHUTDOWN_GITREV:-"v0.1.1"}
export HYRIBYN_HYPRPAPER_GITREV=${HYRIBYN_HYPRPAPER_GITREV:-"v0.8.4"}
export HYRIBYN_HYPRLOCK_GITREV=${HYRIBYN_HYPRLOCK_GITREV:-"v0.9.6"}
export HYRIBYN_HYPRPICKER_GITREV=${HYRIBYN_HYPRPICKER_GITREV:-"v0.4.7"}
export HYRIBYN_HYPRMONCFG_GITREV=${HYRIBYN_HYPRMONCFG_GITREV:-"v1.13.0"}

# should match above RIBYN_HYPR_HYPRLAND_GITREV
# for fedora
# but for arch, you pray, or override local env to "origin/master"
# which build againgst the latest untagged hyprland release
# which is similar to pacman updates and unlikely to break
export HYRIBYN_HY3_GITREV=${HYRIBYN_HY3_GITREV:-"hl0.56.0"}

# https://alejandrominaya.github.io/hyprland-lua-docs/
# when setting the env to specific git revs it is helpful to know, that
# you need to try to build it in docker, to get the required deps, you
# can just look into the `CMakeLists.txt` to see execat minimum dependencies
# and optional depencencies.
