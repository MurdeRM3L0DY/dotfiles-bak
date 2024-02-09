{
  inputs,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  username = config.home.username;
in {
  home.packages = with pkgs; [
    flavours
  ];

  # flavours
  xdg.configFile."flavours" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/flavours/.config/flavours";
}
