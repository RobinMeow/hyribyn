#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	libzip-devel \
	tomlplusplus-devel
