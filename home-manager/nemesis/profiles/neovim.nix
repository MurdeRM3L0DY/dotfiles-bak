{inputs, ...}: {
  config,
  pkgs,
  ...
}: let
  username = config.home.username;
  inherit (pkgs) system;
  vscode_ext = inputs.nix-vscode-extensions.extensions.${system};
in {
  programs.neovim = {
    enable = true;
    package = inputs.neovim.packages.${system}.neovim;
    withNodeJs = false;
    withRuby = false;
    withPython3 = true;
    extraPackages = with pkgs; [
      # build
      gcc
      gnumake
      nodePackages.npm

      # language tools
      alejandra
      clang-tools
      # inputs.nixd.packages.${system}.nixd
      jdt-language-server
      ltex-ls
      nodePackages."@tailwindcss/language-server"
      nodePackages.vscode-langservers-extracted
      python3Packages.black
      stylua
      sumneko-lua-language-server
      tree-sitter
      (vscode_ext.vscode-marketplace.ms-python.vscode-pylance.overrideAttrs (oa: {
        installPhase = ''
          cp -r . $out

          mkdir -p $out/bin

          sed -i '/if(!process/s/return!0x1/return!0x0/g' $out/dist/server.bundle.js

          cat > $out/bin/pylance << EOF
          ${pkgs.nodejs}/bin/node $out/dist/server.bundle.js --stdio
          EOF

          chmod +x $out/bin/pylance
        '';
      }))
      # typescript
    ];
    extraLuaPackages = ps:
      with ps; [
        jsregexp
        magick
      ];
    extraPython3Packages = ps:
      with ps; [
        pynvim
        jupyter-client
        cairosvg
        plotly
      ];
  };

  xdg.configFile."nvim" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/nvim/.config/nvim";
}
