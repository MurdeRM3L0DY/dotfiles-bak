{
  super,
  inputs,
  modules,
  profiles,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = with super.profiles; [
    theme
    awesome
    fonts
    zsh
    kitty
    git
    neovim
    firefox
    chromium
  ];

  home.packages = with pkgs; [
    android-tools
    ansible
    # bottles
    # deluge-gtk
    file
    flavours
    git-repo
    jq
    # qbittorrent
    rar
    # stow
    themechanger
    unzip
    # wezterm
    wget
    yq
    zip
  ];
}
