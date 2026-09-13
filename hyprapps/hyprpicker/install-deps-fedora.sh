#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	libjpeg-turbo-devel \
	libxkbcommon-devel
# NOTE: xkbcommon is explicitly listed on hyprpicker gh
# even tho it builds and installs without. prolly runtime dep.
