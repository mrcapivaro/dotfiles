#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

rofi -mode filebrowser \
    -show filebrowser \
    -theme "$here/../configs/files.rasi"
