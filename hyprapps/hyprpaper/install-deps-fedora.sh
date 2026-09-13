#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	wireplumber \
	brightnessctl \
	qt6ct
