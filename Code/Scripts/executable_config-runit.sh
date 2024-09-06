#!/bin/bash
set -e

RUNIT_TARGET="/run/runit/service/"

# keymapper begin
KEYMAPPER_CONF_DIR="$HOME/.config/sv/keymapperd"
KEYMAPPER_SV_DIR="/etc/runit/sv/keymapperd"

if [ -d "$KEYMAPPER_SV_DIR" ]; then
	echo "The keymapper sv folder already exists at $KEYMAPPER_SV_DIR."
else
	echo "Copying keymapper sv files from .config to $KEYMAPPER_SV_DIR."
	sudo cp -r "$KEYMAPPER_CONF_DIR" "$KEYMAPPER_SV_DIR"
fi

if [ ! -d "$RUNIT_TARGET/keymapperd" ]; then
	echo "Symlinking the sv dir to runit."
	sudo ln -sf "$KEYMAPPER_SV_DIR" "$RUNIT_TARGET"
fi
# keymapper end

# openntpd start
if [ ! -d "$RUNIT_TARGET/openntpd" ]; then
  echo "No openntpd sv found, creating symlink from /etc/runit to /run/runit."
	sudo ln -sf /etc/runit/sv/openntpd /run/runit/service/
	sudo sv start openntpd
fi
# openntpd end
