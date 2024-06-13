{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "guilhermepachecobatista@gmail.com";
    userName = "mrcapivaro";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
