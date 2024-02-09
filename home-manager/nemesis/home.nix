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
    # awesome
    fonts
    zsh
    kitty
    git
    # neovim
    firefox
    # chromium
  ];

  home.packages = with pkgs; [
  ];
}
