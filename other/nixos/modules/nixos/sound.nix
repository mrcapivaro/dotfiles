{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pavucontrol pamixer ];

  sound = {
    enable = true;
    mediaKeys.enable = true;
    mediaKeys.volumeStep = "1";
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
