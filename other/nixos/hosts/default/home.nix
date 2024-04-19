{ ... }:

{
  imports = [
    ../../modules/home-manager/gui/hyprland
    ../../modules/home-manager/gui/themes/gtk-qt.nix
    ../../modules/home-manager/gui/themes/fonts.nix
    ../../modules/home-manager/gui/apps.nix
    ../../modules/home-manager/cli/bash.nix
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/cli/tmux.nix
    ../../modules/home-manager/cli/alacritty.nix
    ../../modules/home-manager/cli/yazi.nix
    ../../modules/home-manager/cli/neovim
    ../../modules/home-manager/programming-languages.nix
    ../../modules/home-manager/drive.nix
  ];

  home.username = "mrcapivaro";
  home.homeDirectory = "/home/mrcapivaro";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
