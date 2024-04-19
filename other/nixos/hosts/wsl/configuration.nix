{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/user.nix
    ../../modules/nixos/terminal.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "mrcapivaro" = import ./home.nix;
    };
  };

  wsl.enable = true;
  wsl.defaultUser = "mrcapivaro";

  environment.systemPackages = with pkgs; [ wslu ];
  environment.variables = { BROWSER = "wslview"; };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
