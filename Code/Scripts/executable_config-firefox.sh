#!/bin/bash
set -e

CONFIG_PATH="$HOME/.config/firefox"
PROFILES_PATH="$HOME/.mozilla/firefox"
DEF_PROF_NAME=$(awk -F= '/^Default=/ { print $2 }' "$PROFILES_PATH/installs.ini")
DEF_PROF_PATH="$PROFILES_PATH/$DEF_PROF_NAME"

for file in "$CONFIG_PATH"/*; do
	ln -s "$file" "$DEF_PROF_PATH"
done
