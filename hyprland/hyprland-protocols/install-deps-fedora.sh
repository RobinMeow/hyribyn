#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	ninja-build \
	cmake \
	gcc \
	make \
	unzip \
	gettext \
	curl
