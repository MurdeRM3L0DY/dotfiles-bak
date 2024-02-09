{
  inputs,
  profiles,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  username = config.home.username;
in{
  fonts.fontconfig = {
    enable = true;
  };

  xdg.dataFile."fonts" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/fonts/.local/share/fonts";
}
