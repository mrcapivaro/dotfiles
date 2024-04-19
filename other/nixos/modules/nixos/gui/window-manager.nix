{ pkgs, inputs, ... }:

let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    package = pkgs-unstable.mesa.drivers;
    package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  };
}
