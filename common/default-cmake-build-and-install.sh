#!/usr/bin/env bash
set -euo pipefail

# WARN: installs into /usr
# so avoid using the package manager to install these
# can cause conflicts.
# will prevent juggling systemd/env vars
# to excpose the /usr/local paths etc..
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
sudo cmake --install build
