{ ... }:

{
  imports = [
    ../../modules/home-manager/cli/bash.nix
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/cli/tmux.nix
    ../../modules/home-manager/cli/yazi.nix
    ../../modules/home-manager/cli/neovim
    ../../modules/home-manager/programming-languages.nix
  ];

  home.username = "mrcapivaro";
  home.homeDirectory = "/home/mrcapivaro";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
