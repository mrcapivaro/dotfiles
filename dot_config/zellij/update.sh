zellij_pane_name_update() {
    [[ -z $ZELLIJ ]] && return
    local current_dir="${PWD/${HOME}/~}"
    command nohup zellij action rename-pane $current_dir >/dev/null 2>&1
}

zellij_pane_name_update
chpwd_functions+=(zellij_pane_name_update)
