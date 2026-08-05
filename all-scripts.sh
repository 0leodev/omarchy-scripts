#!/bin/bash
set -euo pipefail

# Move into this script's own folder, so it works no matter where you run it from
cd "$(dirname "$0")"

./install-packages.sh
./install-dotfiles.sh
