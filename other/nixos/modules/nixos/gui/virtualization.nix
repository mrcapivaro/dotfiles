{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    # socat # needed to fix problems? -> no -> microsoft download block.
  ];
}
