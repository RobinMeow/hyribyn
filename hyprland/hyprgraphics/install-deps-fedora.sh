#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	libglvnd-devel \
	cairo-devel \
	pango-devel \
	libdrm-devel \
	libjpeg-turbo-devel \
	libwebp-devel \
	librsvg2-devel \
	file-devel
# file has libmagick
# file has libpng-devel
