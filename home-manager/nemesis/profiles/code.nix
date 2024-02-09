{
  inputs,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  username = config.home.username;
  inherit (pkgs) system vscodium;
in {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = let
      extensions = inputs.nix-vscode-extensions.extensions.${system};
    in
      with extensions.vscode-marketplace; [
        ms-vsliveshare.vsliveshare
        ms-python.python
        ms-python.vscode-pylance
        llvm-vs-code-extensions.vscode-clangd
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        golang.go
        rust-lang.rust-analyzer
        slevesque.shader
        tamasfe.even-better-toml
        alefragnani.project-manager
        asvetliakov.vscode-neovim
        mesonbuild.mesonbuild
        # vscodevim.vim
      ];
  };

  # home.packages = with pkgs; [
  #   clang-tools
  # ];

  xdg.configFile."VSCodium" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/code/.config/VSCodium";
  xdg.configFile."Visual Studio Code" = config.lib.remotefiles.symlink "self" "home-manager/${username}/files/code/.config/Visual Studio Code";
}
