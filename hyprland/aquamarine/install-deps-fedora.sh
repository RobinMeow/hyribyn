#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	libinput-devel \
	libseat-devel \
	mesa-libgbm-devel \
	systemd-devel \
	libdisplay-info-devel \
	hwdata-devel
# systemd-devel is fedoras version of libudev.
# see here https://github.com/dcuddeback/libudev-sys
