{ inputs, pkgs, ... }:

{
  imports = [ inputs.xremap-flake.nixosModules.default ];

  # Probably should be put in a separate file, like: usb.nix
  environment.systemPackages = with pkgs; [
    usbutils
  ];

  services.xremap = {
    userName = "mrcapivaro";
    withWlroots = true;
    watch = true;
    # mouse = true; # disabled my laptop touchpad for some reason
    config = {
      modmap = [
        {
          name = "Capslock to Control, Control to Esc";
          remap = {
            "CapsLock" = "Ctrl_L";
            "Ctrl_L" = "Esc";
          };
        }
      ];
      keymap = [
        {
          name = "Arrow keys with alt + hjkl";
          remap = {
            "Alt_L-j" = "Down";
            "Alt_L-k" = "Up";
            "Alt_L-h" = "Left";
            "Alt_L-l" = "Right";
            "Alt_L-p" = "CapsLock";
          };
        }
      ];
    };
  };
}
