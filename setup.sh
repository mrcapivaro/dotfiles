#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="${me%/*}"

src="$here/dot_config"

for file in "$src"/*; do
    echo $file

    # get all files
    # make sure their parent folders exist
    # symlink
    # apply properties? (private/executable/...)
done
