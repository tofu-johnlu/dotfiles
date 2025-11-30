#!/usr/bin/env bash
# Shell Alias Configuration
# This file sources all alias files from the aliases directory
#
# Usage:
#   Source this file in your .zshrc or .bashrc:
#   source ~/.shellalias.sh
#
# Structure:
#   - aliases/navigation.sh  - Directory navigation shortcuts
#   - aliases/ls.sh          - File listing and ls aliases
#   - aliases/git.sh         - Git-related shortcuts
#   - aliases/network.sh     - Network and IP utilities
#   - aliases/system.sh      - System utilities
#   - aliases/dev.sh         - Development tools
#   - aliases/macos.sh       - macOS-specific (conditionally loaded)
#
# To customize:
#   - Edit individual files in the aliases/ directory
#   - Add new category files and source them below
#   - Override aliases in your local .zshrc after sourcing this file

# Get the directory where this script is located
ALIAS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/aliases"

# Source common aliases (cross-platform)
[ -f "$ALIAS_DIR/navigation.sh" ] && source "$ALIAS_DIR/navigation.sh"
[ -f "$ALIAS_DIR/ls.sh" ] && source "$ALIAS_DIR/ls.sh"
[ -f "$ALIAS_DIR/git.sh" ] && source "$ALIAS_DIR/git.sh"
[ -f "$ALIAS_DIR/network.sh" ] && source "$ALIAS_DIR/network.sh"
[ -f "$ALIAS_DIR/system.sh" ] && source "$ALIAS_DIR/system.sh"
[ -f "$ALIAS_DIR/dev.sh" ] && source "$ALIAS_DIR/dev.sh"

# Source OS-specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    [ -f "$ALIAS_DIR/macos.sh" ] && source "$ALIAS_DIR/macos.sh"
fi

# Optional: Source user's custom aliases if they exist
[ -f "$HOME/.aliases.local" ] && source "$HOME/.aliases.local"

