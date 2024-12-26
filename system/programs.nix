{ pkgs, hyprland-pkgs, ... }:
{
    # Hyprland
    security.pam.services.hyprlock = {};
    programs.hyprland = {
        enable = true;
        package = hyprland-pkgs.hyprland;
        portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland;
    };

    # Steam
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
    };

    # Podman
    virtualisation = {
        containers.enable = true;
        podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    # System packages
    environment.systemPackages = with pkgs; [
        podman-compose
        git
        networkmanagerapplet
        hyprpolkitagent
    ];
}