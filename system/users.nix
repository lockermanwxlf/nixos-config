{ ... }:
{
    users.users = {
        jake = {
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" "audio" "input" ];
        };
    };
}