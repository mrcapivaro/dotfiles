{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.readline = {
    enable = true;
    extraConfig = ''
      C-o: clear-screen
      set completion-ignore-case on
      set colored-stats on
      set completion-prefix-display-length 3
      set mark-symlinked-directories on
      set show-all-if-ambiguous on
      set show-all-if-unmodified on
      set visible-stats on
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -a";
      cd = "z";
      c = "clear";
      cealr = "clear";
      celar = "clear";
      claer = "clear";
      ".." = "cd ..";
      "...." = "cd ../..";
    };
    bashrcExtra = ''
      LS_COLORS=$LS_COLORS:'tw=00;33:ow=01;33:'
      export LS_COLORS

      export PAGER="less -R"
      export LESS="--RAW-CONTROL-CHARS"
      export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
      export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
      export LESS_TERMCAP_me=$(tput sgr0)
      export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
      export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
      export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
      export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
      export LESS_TERMCAP_mr=$(tput rev)
      export LESS_TERMCAP_mh=$(tput dim)
      export LESS_TERMCAP_ZN=$(tput ssubm)
      export LESS_TERMCAP_ZV=$(tput rsubm)
      export LESS_TERMCAP_ZO=$(tput ssupm)
      export LESS_TERMCAP_ZW=$(tput rsupm)

      function cheat() {
        curl cheat.sh/$@ | less
      }

      function cd-nix-store() {
        cd "/nix/store/$(ls /nix/store/ | grep $1 | fzf)"
      }

      export PNPM_HOME="/home/mrcapivaro/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
    '';
  };
}
