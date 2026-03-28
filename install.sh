#!/usr/bin/env bash
# Symlinks dotfiles into their expected locations.
# Run from the dotfiles repo root.

# https://github.com/olivergondza/bash-strict-mode
set -eEuo pipefail
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# IntelliJ IDEA keymap
# Finds the most recent IntelliJIdea config directory
IDEA_DIR=$(ls -dt ~/Library/Application\ Support/JetBrains/IntelliJIdea* 2>/dev/null | head -1)
if [ -n "$IDEA_DIR" ]; then
    mkdir -p "$IDEA_DIR/keymaps"
    ln -sfv "$DOTFILES_DIR/intellij/keymaps/Emacs_macOS.xml" "$IDEA_DIR/keymaps/Emacs_macOS.xml"
    echo "IntelliJ keymap linked into $IDEA_DIR"
else
    echo "No IntelliJ IDEA config directory found, skipping keymap"
fi
