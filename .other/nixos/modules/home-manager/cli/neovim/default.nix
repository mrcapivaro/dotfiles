{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt

    lua-language-server
    stylua

    llvmPackages_17.clang-unwrapped
    vscode-extensions.vadimcn.vscode-lldb
    lldb_17

    nodePackages_latest.pyright
    ruff-lsp

    nodePackages_latest.bash-language-server
    shfmt

    vscode-langservers-extracted # html + css + eslint + json
    nodePackages_latest.typescript-language-server
    tailwindcss-language-server
    emmet-ls
    prettierd
    # eslint_d # ? check none ls builtins
  ];

  # https://www.reddit.com/r/NixOS/comments/17el4x7/how_to_setup_neovim_using_lazyvim_using_nixos/
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    # for now, let lazy.nvim manage plugins
    # plugins = with pkgs.vimPlugins; [
    # ];

    # extraLuaConfig = ''
    # '';
  };
}
