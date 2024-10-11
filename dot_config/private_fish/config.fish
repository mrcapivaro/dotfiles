if not status is-interactive
    return
end

fastfetch

# [ Evaluations ] #
starship init fish | source
zoxide init fish | source
direnv hook fish | source

# [ Exports ] #
set -gx EDITOR nvim
set -gx VISUAL zed
set -gx PAGER nvimpager
# export LS_COLORS="$LS_COLORS:tw=00;33:ow=01;33"

# [ Aliases ] #
alias tmux="tmux -2"

alias ..="cd .."
alias ....="cd ../.."

alias ls="ls --color=auto -F"

alias vi="nvim"
alias vim="nvim"

alias clera="clear"
alias clare="clear"
alias claer="clear"
alias cler="clear"
alias clar="clear"

alias fzfonts="fc-list :family | awk -F: '{print \$2}' | sort | uniq | fzf | xclip -selection clipboard"

alias less="less -r"

# [ Functions ] #
function fl --wraps ls --description "wrapper of ls to print in a list" 
    ls --color=always -al $argv | awk '{ print $9 }'
end

function cheat
    curl "cheat.sh/$argv" | less
end

function gitall
    if test (count $argv) -eq 0
        set message "update"
    else
        set message $argv
    end
    git add . && git commit -m "$message" && git push
end

function help
    "$argv" --help | $PAGER
end

# [ Path ] #

# Local binaries
set -gx LOCAL_BIN "/home/$USER/.local/bin"
if not contains $LOCAL_BIN $PATH
    set -gx PATH "$LOCAL_BIN" $PATH
end

# Rust
if test -d "$HOME/.cargo"
    source "$HOME/.cargo/env"
end

# PNPM
set -gx PNPM_HOME "/home/mrcapivaro/.local/share/pnpm"
if not contains "$PNPM_HOME" $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Lua
set -gx LUA_PATH '/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua;/home/mrcapivaro/.luarocks/share/lua/5.3/?.lua;/home/mrcapivaro/.luarocks/share/lua/5.3/?/init.lua'
set -gx LUA_CPATH '/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so;/home/mrcapivaro/.luarocks/lib/lua/5.3/?.so'
