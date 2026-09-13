#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	iniparser-devel \
	inotify-tools-devel
