#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/source-manager.sh"

function hypr_build() {
	# WARN: installs into /usr
	# so avoid using the package manager to install these
	# can cause conflicts.
	# will prevent juggling systemd/env vars
	# to excpose the /usr/local paths etc..
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

	cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
	sudo cmake --install build
}

function hypr_install() {
	local name=${1:?1st arg 'name' is required}
	local giturl=${2:?2nd arg 'giturl' is required}
	local gitrev=${3:?3rd arg 'gitrev' is required}
	local is_installed=${4:?4th arg 'is_installed' is required}
	local build_and_install=${5:-hypr_build}

	check_source_state "$name" "$gitrev"

	if [[ "$SOURCE_STATE" == "source n/a" ]]; then
		info "[$SOURCE_NAME] initialising source..."
		init_source "$giturl"
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && "$build_and_install")
	elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
		if bash -c "$is_installed"; then
			info "$SOURCE_NAME already installed. Skipping."
		else
			# edge case. means its already cloned, but build probaly failed.
			clean_source
			info "[$SOURCE_NAME] installing..."
			(cd "$SOURCE_DEST" && "$build_and_install")
		fi
	elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
		clean_source
		update_source "$giturl"
		info "[$SOURCE_NAME] updating..."
		(cd "$SOURCE_DEST" && "$build_and_install")
	fi
}
