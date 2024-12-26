{ ... }:
{
    # Time zone
    time.timeZone = "America/Chicago";
    
    # Internationalisation
    i18n.defaultLocale = "en_US.UTF-8";

    # Keymap
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };
}