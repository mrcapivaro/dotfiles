#!/bin/bash
set -e

# Keymapper setup
KEYMAPPER_SV_DIR="/etc/runit/sv/keymapperd"
if [ -d "$KEYMAPPER_SV_DIR" ]; then
  echo "The keymapper sv folder already exists at $KEYMAPPER_SV_DIR."
else
  echo "Copying keymapper sv files from .config to $KEYMAPPER_SV_DIR."
  sudo cp -r "$HOME/.config/sv/keymapper" /etc/runit/sv/
fi
echo "Symlinking the sv dir to runit."
sudo ln -s /etc/runit/sv/keymapper /run/runit/service/
