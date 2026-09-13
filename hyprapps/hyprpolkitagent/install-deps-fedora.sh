#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	qt6-qtwayland-devel \
	polkit-devel \
	polkit-qt6-1-devel
