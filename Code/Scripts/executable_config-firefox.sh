#!/bin/sh
set -e

# Path of the default-release profile
PROFILE_PATH="$HOME/.mozilla/firefox/$(ls ~/.mozilla/firefox/ | awk '/.*default-release/')"
CONF_FILES_PATH="$HOME/.local/share/chezmoi/.other/firefox/"

echo "Copying config files for firefox from dotfiles repo to current default-release profile."
cp "$CONF_FILES_PATH"/* "$PROFILE_PATH"
