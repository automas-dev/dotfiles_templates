#!/bin/bash

# Exit if any command fails
set -e

SCRIPT_DIR=$(realpath "$(dirname "$0")")

install_script() {
    local script
    script="$1"
    ln -sf "$SCRIPT_DIR/$script" "$HOME/.local/bin/${script%.sh}"
}

install_script script.sh

