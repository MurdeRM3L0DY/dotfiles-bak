{
  description = "Description for the project";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    haumea = {
      url = "github:nix-community/haumea";
    };
  };

  # tools
  inputs = {
    neovim = {
      url = "github:neovim/neovim/2fce95ec439a1121271798cf00fc8ec9878813fa/?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/78a4ac458e84b92990f985b91a82d452f03e55b6";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    nixgl = {
      url = "github:guibou/nixGL";
    };
  };

  inputs.hyprland = {
    url = "github:hyprwm/Hyprland";
  };

  # sources
  inputs = {
    awesome-src = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };

    picom-ft-labs-src = {
      url = "github:FT-Labs/picom";
      flake = false;
    };
  };

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    home-manager,
    haumea,
    ...
  }: let
    inherit (nixpkgs.lib) mapAttrs mapAttrs' nameValuePair foldl;
    inherit (haumea.lib) load loaders transformers;

    importDefault = {
      src,
      inputs ? {},
      loader ? loaders.scoped,
      transformer ? transformers.liftDefault,
    }:
      load {
        inherit src inputs transformer;
      };

    overlays = importDefault {
      src = ./overlays;
      inputs = {
        inherit inputs;
      };
    };

    homeModules = importDefault {
      src = ./modules/home-manager;
      inputs = {
        inherit inputs;
      };
    };

    homeProfiles = importDefault {
      src = ./profiles/home-manager;
      inputs = {
        inherit inputs;
        modules = homeModules;
      };
    };

    commonHomeProfile = {
      imports = [
        homeModules.remotefiles
      ];

      home.remotefiles."self" = {
        type = "git";
        url = "https://github.com/MurdeRM3L0DY/dotfiles";
        path = "dotfiles";
      };

      programs.man = {
        enable = true;
      };

      xdg = {
        enable = true;
        mime = {
          enable = true;
        };
      };

      news.display = "silent";
    };

    nixosModules = importDefault {
      src = ./modules/nixos;
      inputs = {
        inherit inputs;
      };
    };

    nixosProfiles = importDefault {
      src = ./profiles/nixos;
      inputs = {
        inherit inputs;
        modules = nixosModules;
      };
    };

    home = importDefault {
      src = ./home-manager;
      inputs = {
        inherit inputs overlays;
        modules = homeModules;
        profiles = homeProfiles;
      };
    };

    hosts = importDefault {
      src = ./nixos;
      inputs = {
        inherit inputs overlays;
        modules = nixosModules;
        profiles =
          nixosProfiles
          // {
            users =
              mapAttrs (name: module: c: ({...}: {
                users.users.${name} =
                  c
                  // {
                    inherit name;
                    initialPassword = "";
                    isNormalUser = true;
                  };

                home-manager.users.${name} = {
                  imports = [
                    commonHomeProfile

                    ({osConfig, ...}: {
                      home.stateVersion = osConfig.system.stateVersion;
                    })

                    module.home
                  ];
                };
              }))
              home;
          };
      };
    };
  in {
    nixosConfigurations = mapAttrs (_: host:
      nixpkgs.lib.nixosSystem {
        inherit (host) system;
        modules =
          [
            {
              imports = [home-manager.nixosModules.home-manager];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ]
          ++ host.modules;
      })
    hosts;

    homeConfigurations =
      foldl (
        acc: system:
          acc
          // (mapAttrs' (
              username: module:
                nameValuePair
                "${username}.${system}"
                (home-manager.lib.homeManagerConfiguration {
                  pkgs = module.standalone.pkgs {inherit system;};

                  modules = [
                    commonHomeProfile

                    ({pkgs, ...}: {
                      home.username = username;
                      home.homeDirectory =
                        if pkgs.hostPlatform.isDarwin
                        then "/Users/${username}"
                        else "/home/${username}";

                      programs.home-manager = {
                        enable = true;
                      };

                      targets.genericLinux = {
                        enable = pkgs.hostPlatform.isLinux;
                      };
                    })

                    module.standalone.home
                  ];
                })
            )
            home)
      ) {} (with flake-utils.lib.system; [
        x86_64-linux
      ]);
  };
}
