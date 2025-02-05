{ pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  users.users.nixos = {
    description = "Installation user";
    shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.budgie.enable = true;
    displayManager.lightdm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    python311
    gptfdisk
  ];

  home-manager = {
    backupFileExtension = "hm.bak";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nixos = {
      home.file."install.sh".source = ./install.sh;
      home.file."step1_config.nix".source = ./step1_config.nix;
      home.stateVersion = "25.05";
    };
  };
}
