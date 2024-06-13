{ pkgs, ... }:

{
  home.packages = with pkgs; [
    roboto
    roboto-mono
    jetbrains-mono
    fantasque-sans-mono
    (nerdfonts.override { fonts = [ "FantasqueSansMono" "JetBrainsMono" ]; })
  ];

  # gtk.font = "FantasqueSansMono";
}
