#!/usr/bin/env bash
set -euo pipefail

# just a wrapper to invoke install-deps and build-and-install
# in squence in one go
#
# example use:
# "$HYRIBYN/common/install.sh" "hyprland-protocols"

STACK_NAME=${1:?stack name is required as 1st arg}

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
export HYRIBYN_DISTRO=${HYRIBYN_DISTRO:-"fedora"}

"$HYRIBYN/hyprland/$STACK_NAME/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprland/$STACK_NAME/build-and-install.sh"
