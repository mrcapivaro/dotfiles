{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      top_bar = {
        layer = "top";
        position = "bottom";
        height = 36;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "wlr/taskbar" ];
        modules-right = [
          "tray"
          "battery"
          "bluetooth"
          "network"
          "pulseaudio"
          "backlight"
          "group/misc"
          "clock#time"
          "custom/separator"
          "clock#calendar"
          "custom/logout_menu"
        ];

        battery = {
          states = {
            high = 90;
            upper-medium = 70;
            medium = 50;
            lower-medium = 30;
            low = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋{icon} {capacity}%";
          format-plugged = "󰚥{icon} {capacity}%";
          format-time = "{H} h {M} min";
          format-icons = [ "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}";
        };

        "wlr/taskbar" = {
          format = "{icon}{name}";
          max-length = 1;
          icon-size = 20;
          icon-theme = "Colloid";
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-right = "close";
          on-click-middle = "fullscreen";
        };

        tray = {
          icon-size = 16;
          spacing = 2;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent_workspaces = {
            "*" = 5;
          };
        };

        "hyprland/submap" = {
          format = "<span color='#a6da95'>Mode:</span> {}";
          tooltip = false;
        };

        "clock#time" = {
          format = "{:%I:%M}";
        };

        "custom/separator" = {
          format = "|";
        };

        "clock#calendar" = {
          format = "{:%F}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          actions = {
            on-click-right = "mode";
          };
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#f4dbd6'><b>{}</b></span>";
              days = "<span color='#cad3f5'><b>{}</b></span>";
              weeks = "<span color='#c6a0f6'><b>W{}</b></span>";
              weekdays = "<span color='#a6da95'><b>{}</b></span>";
              today = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
            };
          };
        };

        "clock" = {
          format = "{:%I:%M %p %Ez | %a • %h | %F}";
          format-alt = "{:%I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          # locale = "en_US.UTF-8";
          # timezones = [ "Europe/Kyiv"; "America/New_York" ],
          actions = {
            on-click-right = "mode";
          };
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#f4dbd6'><b>{}</b></span>";
              days = "<span color='#cad3f5'><b>{}</b></span>";
              weeks = "<span color='#c6a0f6'><b>W{}</b></span>";
              weekdays = "<span color='#a6da95'><b>{}</b></span>";
              today = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
            };
          };
        };

        "custom/media" = {
          format = "{icon}󰎈";
          restart-interval = 2;
          return-type = "json";
          format-icons = {
            Playing = "";
            Paused = "";
          };
          max-length = 35;
          exec = "bash -c fetch_music_player_data";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl prev";
          on-scroll-up = "playerctl volume 0.05-";
          on-scroll-down = "playerctl volume 0.05+";
          smooth-scrolling-threshold = "0.1";
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} (󰥉 {device_battery_percentage}%)";
          # format-device-preference = [ "device1"; "device2" ], // preference list deciding the displayed device
          tooltip-format = "{controller_alias}\t{controller_address} ({status})\n\n{num_connections} connected";
          tooltip-format-disabled = "bluetooth off";
          tooltip-format-connected = "{controller_alias}\t{controller_address} ({status})\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t({device_battery_percentage}%)";
          max-length = 35;
          on-click = "bash -c bluetooth_toggle";
          on-click-right = "blueman-manager";
        };

        "network" = {
          format = "󰤭";
          format-wifi = "{icon}  ({signalStrength}%) {essid}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-disconnected = "󰤫 ";
          tooltip-format = "wifi <span color='#ee99a0'>off</span>";
          tooltip-format-wifi = "SSID: {essid}({signalStrength}%); {frequency} MHz\nInterface: {ifname}\nIP: {ipaddr}\nGW: {gwaddr}\n\n<span color='#a6da95'>{bandwidthUpBits}</span>\t<span color='#ee99a0'>{bandwidthDownBits}</span>\t<span color='#c6a0f6'>󰹹{bandwidthTotalBits}</span>";
          tooltip-format-disconnected = "<span color='#ed8796'>disconnected</span>";
          # format-ethernet = "󰈀 {ipaddr}/{cidr}";
          # format-linked = "󰈀 {ifname} (No IP)";
          # tooltip-format-ethernet ="Interface: {ifname}\nIP: {ipaddr}\nGW: {gwaddr}\nNetmask: {netmask}\nCIDR: {cidr}\n\n<span color='#a6da95'>{bandwidthUpBits}</span>\t<span color='#ee99a0'>{bandwidthDownBits}</span>\t<span color='#c6a0f6'>󰹹{bandwidthTotalBits}</span>";
          max-length = 35;
          on-click = "bash -c wifi_toggle";
          on-click-right = "alacritty -e nmtui";
        };

        "group/misc" = {
          orientation = "horizontal";
          modules = [
            "custom/recording"
            "custom/geo"
            "custom/media"
            "custom/dunst"
            "custom/night_mode"
            "custom/airplane_mode"
            "idle_inhibitor"
          ];
        };

        "custom/recording" = {
          interval = 1;
          exec-if = "pgrep wf-recorder";
          exec = "bash -c check_recording";
          return-type = "json";
        };

        "custom/geo" = {
          interval = 1;
          exec-if = "pgrep geoclue";
          exec = "bash -c check_geo_module";
          return-type = "json";
        };

        "custom/airplane_mode" = {
          return-type = "json";
          interval = 1;
          exec = "bash -c check_airplane_mode";
          on-click = "bash -c airplane_mode_toggle";
        };

        "custom/night_mode" = {
          return-type = "json";
          interval = 1;
          exec = "bash -c check_night_mode";
          on-click = "bash -c night_mode_toggle";
        };

        "custom/dunst" = {
          return-type = "json";
          exec = "bash -c dunst_pause";
          on-click = "dunstctl set-paused toggle";
          restart-interval = 1;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰛐";
            deactivated = "󰛑";
          };
          tooltip-format-activated = "idle-inhibitor <span color='#a6da95'>on</span>";
          tooltip-format-deactivated = "idle-inhibitor <span color='#ee99a0'>off</span>";
          start-activated = true;
        };

        "custom/logout_menu" = {
          return-type = "json";
          exec = "echo '{ \"text\":\"󰐥\", \"tooltip\": \"logout menu\" }'";
          interval = "once";
          on-click = "bash -c wlogout";
        };

        "backlight" = {
          format = "{icon}  {percent}%";
          format-icons = [ "󰌶" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
          tooltip = false;
          states = {
            high = 90;
            upper-medium = 70;
            medium = 50;
            lower-medium = 30;
            low = 10;
          };
          reverse-scrolling = true;
          reverse-mouse-scrolling = true;
          on-click = "light -A 30";
          on-click-right = "light -U 30";
        };

        "pulseaudio" = {
          states = {
            high = 90;
            upper-medium = 70;
            medium = 50;
            lower-medium = 30;
            low = 10;
          };
          tooltip-format = "{desc}";
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "󰂱 {icon} {volume}% {format_source}";
          format-bluetooth-muted = "󰂱 󰝟 {volume}% {format_source}";
          format-muted = "󰝟 {volume}% {format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 {volume}%";
          format-icons = {
            headphone = "󰋋";
            hands-free = "";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰦧";
            car = "󰄋";
            speaker = "󰓃";
            hdmi = "󰡁";
            hifi = "󰋌";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          reverse-scrolling = true;
          reverse-mouse-scrolling = true;
          on-click = "pavucontrol";
        };

      };
    };

    style = builtins.readFile ./waybar-style.css;
  };
}
