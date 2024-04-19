{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rclone
    rclone-browser
  ];
}
