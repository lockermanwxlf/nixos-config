{ pkgs, ... }:
{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        nerd-fonts.go-mono
        nerd-fonts.jetbrains-mono
        font-awesome
    ];
}
