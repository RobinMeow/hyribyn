#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	qt6-qtbase-devel \
	libuuid-devel \
	pipewire-devel \
	sdbus-cpp-devel
