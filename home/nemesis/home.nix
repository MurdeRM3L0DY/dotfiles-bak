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
    awesome
    fonts
    zsh
    kitty
    git
    neovim
    firefox
  ];

  home.packages = with pkgs; [
    android-tools
    ansible
    bottles
    deluge-gtk
    file
    flavours
    git-repo
    jq
    qbittorrent
    rar
    stow
    themechanger
    unzip
    wezterm
    wget
    yq
    zip
  ];

  # man
  programs.man = {
    enable = true;
  };
}
