{...}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kitty
  ];

  xdg.configFile."kitty/kitty.conf" = config.lib.remotefiles.symlink "self" "files/kitty/.config/kitty/kitty.conf";
}
