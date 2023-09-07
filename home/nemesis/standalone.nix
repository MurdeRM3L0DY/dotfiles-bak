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
  }: {
    imports = with super.profiles; [
      theme
      flavours
      awesome
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

    xdg.configFile."kitty" = config.lib.remotefiles.symlink "self" "files/kitty/.config/kitty";

    home.packages = with pkgs; [
      # bottles
      bear
      bitwig-studio
      deadbeef-with-plugins
      htop
      # hyprland
      jamesdsp
      libreoffice
      mate.atril
      nix-index
      nixgl.nixGLMesa
      qbittorrent
      strawberry
      testdisk
      tree
      tribler
      unzip
      vpnc
      zip
    ];
  };

  # man
  programs.man = {
    enable = true;
  };
}
