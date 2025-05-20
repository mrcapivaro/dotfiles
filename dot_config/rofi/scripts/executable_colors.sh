#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

main() {
    local file_dir="$here/colors/all-colors"
    local copy_cmd="xclip -sel clip"

    local color_name=$(cat $file_dir |
        awk '{print $1}' |
        xargs -n 1 |
        rofi \
            -dmenu \
            -p "" \
            -theme "$here/../configs/apps.rasi")

    local color_value=$(cat $file_dir |
        grep "^$color_name\s" |
        awk '{printf "%s", $2}')

    # `"` can not be used with `$copy_cmd`.
    echo -n $color_value | $copy_cmd
}

main "$@"
