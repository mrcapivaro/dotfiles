{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    firefox
    floorp
    chromium
    spotify
    vscode
    libreoffice-qt
    obsidian
    steam
    pcmanfm
    qalculate-gtk
  ];
}
