{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6.qtwayland
    qt5.qtwayland
  ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = (pkgs.catppuccin-kvantum.override {
        accent = "Mauve";
        variant = "Mocha";
      });
      name = "kvantum";
    };
  };

  gtk = {
    enable = true;
    theme = {
      # need to update the colloid gtk theme to fix
      # transparent backgrounds "bug"
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid";
    };
    font.name = "Roboto Mono";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 16;
    gtk.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Catppuccin-Mocha-Standard-Mauve-Dark";
      color-scheme = "prefer-dark";
    };
  };

  # symlink gtk3 and gtk4
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Mauve";
    };
  };
}
