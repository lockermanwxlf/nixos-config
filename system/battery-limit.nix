{ ... }:
{
    systemd.services.batteryLimit = {
        enable = true;
        description = "Limit battery charge.";
        wantedBy = [ "multi-user.target" ];
        script = "echo 70 | tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = "yes";
        };
    };
}