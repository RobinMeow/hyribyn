#!/usr/bin/env bash
set -euo pipefail

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
