#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	pam-devel \
	libxkbcommon-devel
