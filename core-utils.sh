#!/usr/bin/env bash
set -euo pipefail

RED="\033[38;5;203m"    # #f38ba8
ORANGE="\033[38;5;215m" # #fab387
GREEN="\033[38;5;114m"  # #a6e3a1
BLUE="\033[38;5;109m"   # #89b4fa
# PURPLE="\033[38;5;139m" # #cba6f7
NC="\033[0m" # No Color

error() {
	echo -e "${RED}[ERROR]${NC} $*"
}

warn() {
	echo -e "${ORANGE}[WARN]${NC} $*"
}

success() {
	echo -e "${GREEN}[SUCCESS]${NC} $*"
}

info() {
	echo -e "${BLUE}[INFO]${NC} $*"
}

exit_with_distro_not_supported_msg() {
	error "distro is not supported."
	exit 1
}
