## Build Instructions

### nixos system
* from the nixos installer:
```bash
sudo nix run --extra-experimental-features "nix-command flakes" github:nix-community/disko -- -m disko -f github:MurdeRM3L0DY/dotfiles#archnemesis
sudo nixos-install --flake github:MurdeRM3L0DY/dotfiles#archnemesis
```

### home-manager standalone
* install nix
```bash
TAG=v0.15.1
curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/${TAG}" | sh -s -- install --diagnostic-endpoint='' --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```
* activate home-manager configuration
```bash
nix run home-manager/master -- switch --flake github:MurdeRM3L0DY/dotfiles#nemesis.{host-architecture}
```
