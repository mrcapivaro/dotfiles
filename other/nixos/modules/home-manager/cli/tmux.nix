{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-Space";
    escapeTime = 25;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -g status-bg black
      set -g status-fg white

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind _ split-window -v -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
    '';
  };
}
