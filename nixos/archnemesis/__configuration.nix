{
  inputs,
  profiles,
  modules,
  overlays,
  ...
}: {
  lib,
  pkgs,
  ...
}: {
  imports = with profiles; [
    (xkb {
      layout = "it";
      xkbOptions = "caps:swapescape";
    })
    (libinput {})
    (docker {
      storageDriver = "btrfs";
    })
    (qemu {})
    (db.postgres {})
    # (desktop.awesome {})
    (desktop.gnome {})
    (users.nemesis {
      extraGroups = [
        "wheel" # sudo
        "docker" # required for docker
        "video" # for backlight controls
        "libvirt" # for qemu
      ];
      shell = pkgs.zsh;
    })
  ];

  nixpkgs.overlays = with overlays; [
    awesome
    jdt-language-server
    nur
    picom
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.pathsToLink = ["/share/zsh" "/share/themes" "/share/icons"];

  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "archnemesis"; # Define your hostname.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # use latest nix cli
  # nix.package = pkgs.nixUnstable;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # current timezone
  time.timeZone = "Europe/Rome";

  # automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  programs.zsh = {
    enable = true;
  };

  system.stateVersion = "23.05";
}
