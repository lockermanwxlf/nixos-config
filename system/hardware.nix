# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5ad56ec7-2d39-4e30-941f-25f9709aeb6e";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-cc40f5b2-a459-49eb-b4a4-49aa718990e8".device = "/dev/disk/by-uuid/cc40f5b2-a459-49eb-b4a4-49aa718990e8";
  boot.initrd.luks.devices."luks-7deaac52-53f3-4447-a07c-68e7a73393b5".device = "/dev/disk/by-uuid/7deaac52-53f3-4447-a07c-68e7a73393b5";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4002-A6DB";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4aac00e6-3bb3-42ea-acd4-bdad4fabc4a3"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
