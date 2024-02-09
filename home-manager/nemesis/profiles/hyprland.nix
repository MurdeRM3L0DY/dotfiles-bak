{
  inputs,
  super,
  profiles,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  username = config.home.username;
in {
  imports = with super; [
  ];

  home.packages = with pkgs; [
  ];

  xdg.configFile."hypr" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/hypr/.config/hypr";
  xdg.configFile."ags" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/ags/.config/ags";
}
