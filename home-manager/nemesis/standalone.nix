{
  inputs,
  super,
  overlays,
  ...
}: {
  pkgs = {system}:
    import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = with overlays; [
        nur
        awesome
        picom
        inputs.nixgl.overlay
      ];
    };

  home = {
    config,
    lib,
    pkgs,
    ...
  }: let
    username = config.home.username;
  in {
    imports = with super.profiles; [
      theme
      flavours
      # awesome
      hyprland
      chromium
      code
      zsh
      git
      fonts
      dconf
      neovim
      firefox
    ];

    xdg.configFile."kitty" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/kitty/.config/kitty";

    home.packages = with pkgs; [
      # bottles
      # bitwig-studio
      # deadbeef-with-plugins
      # hyprland
      # jamesdsp
      libreoffice
      mate.atril
      mullvad-browser
      nixgl.nixGLMesa
      qbittorrent
      # strawberry
      # tribler
    ];

    xdg.systemDirs = {
      config = ["/etc/xdg"];
      data = ["/var/lib/flatpak/exports/share" "${config.xdg.dataHome}/flatpak/exports/share"];
    };
  };
}
