{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodePackages_latest.nodejs

    lua

    go

    (python3.withPackages (ps: with ps; [
      pip
      matplotlib
      numpy
      ipython
      pandas
      scipy
    ]))
    virtualenv

    gcc

    odin
  ];
}
