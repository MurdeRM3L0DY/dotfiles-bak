{...}: {
  config,
  pkgs,
  ...
}: let
  username = config.home.username;
in{
  home.packages = with pkgs; [
    kitty
  ];

  xdg.configFile."kitty/kitty.conf" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/kitty/.config/kitty/kitty.conf";
}
