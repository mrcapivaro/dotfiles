#!/bin/sh
set -e

CONF_FILES_PATH="$HOME/.config/firefox"
PROFILE_PATH="$HOME/.mozilla/firefox/$(ls $HOME/.mozilla/firefox/ | awk '/default-release/')"

if test "$CONF_FILES_PATH/user.js"; then
	echo "The user.js file already exists inside the default-release profile folder."
else
	echo "Creating the user.js symlink."
	ln -sf "$CONF_FILES_PATH/user.js" "$PROFILE_PATH/user.js"
fi

if test "$CONF_FILES_PATH/chrome"; then
	echo "The chrome folder already exists inside the default-release profile folder."
else
	echo "Creating the chrome/ symlink."
	ln -sf "$CONF_FILES_PATH/chrome" "$PROFILE_PATH/chrome"
fi
