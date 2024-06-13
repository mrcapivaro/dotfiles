{ ... }:

{
  users.users.mrcapivaro = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
}
