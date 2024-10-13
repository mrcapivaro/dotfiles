if not status is-interactive
    return
end

fastfetch

# [ Keybinds ] #

function fish_user_key_bindings
    fish_vi_key_bindings
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
end

# [ Evaluations ] #

starship init fish | source
zoxide init fish | source
direnv hook fish | source

# [ Exports ] #

set -gx EDITOR nvim
set -gx VISUAL zed
set -gx PAGER nvimpager
# export LS_COLORS="$LS_COLORS:tw=00;33:ow=01;33"

# [ 49 ] #

# alias aa=""
# alias as=""
# alias ad=""
# alias af=""
# alias aj=""
# alias ak=""
# alias al=""
alias ss="tmux -2" # ss = seSSions
alias sa="xbps-query -Rs" # sa = Search pAckages/Apps
# alias sd=""
function sf # sf = Search packages, pipe to Fzf and install
    sudo xbps-install (xbps-query -Rs $argv | fzf | sed 's/\[.\] \([^ ]*\).*/\1/')
end
# alias sj=""
# alias sk=""
# alias sl=""
# alias dd=""
# alias da=""
# alias ds=""
# alias df="df"
# alias dj=""
# alias dk=""
# alias dk=""
# alias dl=""
# alias ff=""
# alias fa=""
# alias fs=""
# alias fd=""
# alias fj=""
# alias fk=""
alias fl="yazi" # fl = FiLe manager
# alias jj=""
# alias ja=""
# alias js=""
# alias jd=""
# alias jf=""
# alias jk=""
# alias jl=""
# alias kk=""
# alias ka=""
# alias ks=""
# alias kd=""
# alias kf=""
# alias kj=""
# alias kl=""
# alias ll=""
# alias la=""
alias ls="ls --color=always -F" # ls = LiSt files
# alias ld=""
# alias lf=""
# alias lj=""
# alias lk=""

# [ Aliases ] #

alias ..="cd .."
alias ....="cd ../.."

alias vi="nvim"
alias vim="nvim"

alias clera="clear"
alias clare="clear"
alias claer="clear"
alias cler="clear"
alias clar="clear"

alias fzfonts="fc-list :family | awk -F: '{print \$2}' | sort | uniq | fzf | xclip -selection clipboard"

# [ Functions ] #

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
    source "$HOME/.cargo/env.fish"
end

# PNPM
set -gx PNPM_HOME "/home/mrcapivaro/.local/share/pnpm"
if not contains "$PNPM_HOME" $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Lua
set -gx LUA_PATH '/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua;/home/mrcapivaro/.luarocks/share/lua/5.3/?.lua;/home/mrcapivaro/.luarocks/share/lua/5.3/?/init.lua'
set -gx LUA_CPATH '/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so;/home/mrcapivaro/.luarocks/lib/lua/5.3/?.so'
