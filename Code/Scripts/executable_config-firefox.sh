#!/bin/sh
set -e

CONF_FILES_PATH="$HOME/.config/firefox"
PROFILE_PATH="$HOME/.mozilla/firefox/$(ls $HOME/.mozilla/firefox/ | awk '/default-release/')"

if [ -e "$CONF_FILES_PATH/user.js" ]; then
  echo "Creating the user.js symlink."
  ln -sf "$CONF_FILES_PATH/user.js" "$PROFILE_PATH/user.js"
else
  echo "The user.js config file does not exist."
fi

if [ -d "$CONF_FILES_PATH/chrome" ]; then
  echo "Creating the chrome/ symlink."
  ln -sf "$CONF_FILES_PATH/chrome" "$PROFILE_PATH/chrome"
else
  echo "The chrome/ config folder does not exist."
fi
