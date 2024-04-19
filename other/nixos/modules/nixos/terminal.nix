{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # alacritty
    # starship
    # tmux
    # vim
    neovim
    # yazi

    # git
    # gh
    # lazygit
    wget
    ripgrep
    fzf
    jq
    fd
    unzip
    libqalculate
    # zoxide
  ];
}
