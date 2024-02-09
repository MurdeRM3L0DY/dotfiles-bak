{inputs, ...}: {
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = "Cartograph CF Regular";
      size = 10;
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir-dark";
    };

    cursorTheme = config.gtk.iconTheme;

    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = ["rimless"];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";

    style = {
      package = pkgs.catppuccin-kvantum.override {
        accent = "Blue";
        variant = "Mocha";
      };
      name = "kvantum";
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig" = {
    text = ''
      [General]
      theme=Catppuccin-Mocha-Blue
    '';
  };

  home.sessionVariables = {
    GTK_THEME = config.gtk.theme.name;
    ICON_THEME = config.gtk.iconTheme.name;
    # GTK_USE_PORTAL = 1;
  };

  xresources.properties = {
    "Xcursor.theme" = config.gtk.cursorTheme.name;
  };

  home.packages = with pkgs; [
    themechanger
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];

  # # gtk2
  # home.file.".gtkrc-2.0" = config.lib.remotefiles.symlink "self" "files/gtk/.gtkrc-2.0";
  #
  # # gtk3
  # xdg.configFile."gtk-3.0/settings.ini" = config.lib.remotefiles.symlink "self" "files/gtk/.config/gtk-3.0/settings.ini";
  # xdg.configFile."gtk-3.0/gtk.css" = config.lib.remotefiles.symlink "self" "files/gtk/.config/gtk-3.0/gtk.css";
  #
  # # gtk4
  # xdg.configFile."gtk-4.0/settings.ini" = config.lib.remotefiles.symlink "self" "files/gtk/.config/gtk-4.0/settings.ini";
  # xdg.configFile."gtk-4.0/gtk.css" = config.lib.remotefiles.symlink "self" "files/gtk/.config/gtk-4.0/gtk.css";
}
