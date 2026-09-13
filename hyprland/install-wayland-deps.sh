#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	wayland-protocols-devel \
	wayland-devel \
	xorg-x11-server-Xwayland
