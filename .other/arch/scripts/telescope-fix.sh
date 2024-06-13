#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Fix the "luv callback error: access denied" error in telescope
# neovim plugin.
# Needs to be ran as sudo/root.
chgrp users "$HOME/.local/share/nvim/telescope_history"
chown mrcapivaro "$HOME/.local/share/nvim/telescope_history"
