{ pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    waybar &
    poweralertd &
    swayidle -w &
    swww init &
    sleep 1
    swww img ${./wallpaper.png} &
    hyprctl setcursor "Catppuccin-Mocha-Dark-Cursors" 16 &
    light -N 10 &
  '';
in
{
  imports = [
    ./waybar.nix
    ./app-launcher.nix
  ];

  home.packages = with pkgs; [
    wtype
    wlroots
    wlogout
    wl-clipboard
    wlrctl

    xdg-utils

    # slurp # select regions on wayland? -> grim -> printscreen region?

    libnotify # dep to apps to send data through dunst (necessary?)
    psi-notify # notifier that tries to predict errors in apps
    avizo # notification daemon, especially for media keys (sway)
    dunst # notification daemon for window managers (controlled by dunstctl)

    swayidle # idle sessions daemon

    hyprpicker # color picker
    pyprland # plugins/more options -> adv. scractchpads -> quake term.

    swww # wallpaper

    zathura # pdf and documents viewr

    mpv # video viwer
    playerctl # control video player with cli -> media keys
    ffmpeg_6-full # multimedia framework/cli tool/editor
    gifsicle # cli tool to manage and edit gifs or animations

    imagemagick # images editor
    imv # images viwer
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,highres,auto,1"
        "HDMI-A-1,1920x1080,auto,1,mirror,eDP-1"
      ];

      exec-once = ''${startupScript}/bin/start'';
      env = "XCURSOR_SIZE,24";

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
      };

      decoration = {
        rounding = 0;
        blur.enabled = false;
      };

      animations.enabled = false;
      master.new_is_master = true;

      windowrule = [
        "float,^(qalculate-gtk)$"
        "center,^(qalculate-gtk)$"
      ];

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, alacritty"
        "$mainMod, E, exec, pcmanfm"

        "$mainMod, M, exit"
        "$mainMod, R, exec, hyperctl reload"

        "$mainMod, C, killactive"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"

        "$mainMod, RETURN, exec, rofi -show drun -modi drun,run,window"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "ALT, TAB, togglespecialworkspace, special:magic"

        "$mainMod SHIFT, right, resizeactive, 10 0"
        "$mainMod SHIFT, left, resizeactive, -10 0"
        "$mainMod SHIFT, up, resizeactive, 0 -10"
        "$mainMod SHIFT, down, resizeactive, 0 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
