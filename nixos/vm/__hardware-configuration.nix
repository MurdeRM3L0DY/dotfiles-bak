{profiles, ...}: {
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    (profiles.disko {
      disk.vda = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              priority = 1;
              name = "boot";
              start = "1M";
              end = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            vm = {
              name = "vm";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = let
                  mountOptions = ["noatime" "ssd" "discard=async" "compress=zstd" "space_cache=v2"];
                in {
                  "@" = {
                    inherit mountOptions;
                    mountpoint = "/";
                  };
                  "@home" = {
                    inherit mountOptions;
                    mountpoint = "/home";
                  };
                  "@nix" = {
                    inherit mountOptions;
                    mountpoint = "/nix";
                  };
                };
              };
            };
          };
        };
      };
    })
  ];

  boot.extraModulePackages = [];
  boot.initrd = {
    availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
    kernelModules = [];
  };
  boot.kernelModules = ["kvm-amd"];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader = {
    systemd-boot = {
      enable = false;
    };
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
      gfxmodeEfi = "1920x1080";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
