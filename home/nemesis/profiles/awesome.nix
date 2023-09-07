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
}: {
  imports = with super; [
  ];

  home.packages = with pkgs; [
    # picom
    # (picom.overrideAttrs (oldAttrs: rec {
    #   pname = "compfy";
    #   version = "1.7.2";
    #   buildInputs = [
    #     pcre2
    #   ]
    #   ++
    #     oldAttrs.buildInputs;
    #   src = pkgs.fetchFromGitHub {
    #     owner = "allusive-dev";
    #     repo = "compfy";
    #     rev = version;
    #     hash = "sha256-7hvzwLEG5OpJzsrYa2AaIW8X0CPyOnTLxz+rgWteNYY=";
    #   };
    #   postInstall = '''';
    # }))
  ];

  xsession = {
    enable = true;
    # scriptPath = "${config.home.homeDirectory}/.xinitrc";
  };

  home.file.".xserverrc" = config.lib.remotefiles.symlink "self" "files/xorg/.xserverrc";
  home.file.".xinitrc" = {
    executable = true;
    text = /* bash */''
      if [ -z "$HM_XPROFILE_SOURCED" ]; then
        . "${config.home.homeDirectory}/${config.xsession.profilePath}"
      fi
      unset HM_XPROFILE_SOURCED

      if [ -f "${config.xresources.path}" ]; then
        ${pkgs.xorg.xrdb}/bin/xrdb -merge ${config.xresources.path}
      fi

      exec ${config.xsession.windowManager.command}
    '';
  };
  xdg.configFile."awesome" = config.lib.remotefiles.symlink "self" "files/awesome/.config/awesome";

  services.gnome-keyring = {
    enable = true;
    components = ["secrets" "ssh" "pkcs11"];
  };

  xsession.windowManager.awesome = {
    enable = true;
    package =
      (pkgs.awesome.overrideAttrs (oa: {
        GI_TYPELIB_PATH = let
          extraGIPackages = with pkgs; [pango.out networkmanager upower playerctl bluez];
          mkGITypeLibPath = pkg: "${pkg}/lib/girepository-1.0";
          extraGITypeLibPaths = lib.forEach extraGIPackages mkGITypeLibPath;
        in
          lib.concatStringsSep ":" extraGITypeLibPaths;
      }))
      .override {
        lua = pkgs.luajit;
        gtk3Support = true;
      };
    luaModules = with pkgs.luajitPackages; [luarocks ldbus cjson stdlib];
  };

  xdg.systemDirs = {
    config = ["/etc/xdg"];
    data = [ "/var/lib/flatpak/exports/share" "${config.xdg.dataHome}/flatpak/exports/share" ];
  };
}
