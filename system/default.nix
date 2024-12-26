{ ... }:
{
    imports = [
        ./hardware.nix
        ./users.nix
        ./locale.nix
        ./networking.nix
        ./programs.nix
        ./battery-limit.nix
    ];

    # Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Hyprland Cachix
    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    
    # Allow unfree packages.
    nixpkgs.config.allowUnfree = true;

    # State version
    system.stateVersion = "24.11";
}