#!/usr/bin/env bash
set -euo pipefail

# just a wrapper to invoke install-deps and build-and-install
# in squence in one go
#
# example use:
# "$HYRIBYN/common/install-app.sh" "hyprshutdown"

STACK_NAME=${1:?stack name is required as 1st arg}

export HYRIBYN=${HYRIBYN:-"$HYRIBYN_ROOT/hyribyn"}
export HYRIBYN_DISTRO=${HYRIBYN_DISTRO:-"fedora"}

"$HYRIBYN/hyprapp/$STACK_NAME/install-deps-$HYRIBYN_DISTRO.sh"
"$HYRIBYN/hyprapp/$STACK_NAME/build-and-install.sh"
