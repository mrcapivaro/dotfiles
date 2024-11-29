#!/usr/bin/env bash
set -euo pipefail

function run () {
    local name=$1
    local cmd="$@"
    if ! ps -C $name &>/dev/null; then
        $cmd &
    fi
}

function ls-desktop-entries-exec () {
    local dir="$1"
    find "$dir" -type f -name "*.desktop" | xargs -n 1 sed -n "s/^Exec=\(.*\)/\1/p"
}

function run-desktop-entries () {
    local dir="$1"
    local entries_cmds=$(ls-desktop-entries-exec "$dir")

    # NOTE: using a for loop resulted in an error.
    # Using a while loop fixed it. Why? subshells & IFS?
    echo "$entries_cmds" | while IFS= read -r cmd; do
        run "$cmd"
    done
}

run feh --bg-center "$HOME/.config/wallpapers/mountains.png"
run-desktop-entries "$HOME/.config/autostart"

if ! xrandr | grep -q "HDMI-0.*1920x1080"; then
    xrandr --output HDMI-0 --mode "1920x1080"
fi
