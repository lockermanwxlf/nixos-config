{ pkgs, hyprland-pkgs, ... }:
{
    # Waybar
    programs.waybar = {
        enable = true;
        style = builtins.readFile ./res/waybar-style.css;
    };

    # Kitty
    programs.kitty = {
        enable = true;
        font = {
            name = "GoMono Nerd Font";
        };
        settings = {
            confirm_os_window_close = 0;
        };
    };

    # Rofi
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = "dmenu";
    };

    # Hyprpaper
    home.file = {
        ".local/share/wallpapers/wallpaper.jpeg".source = ./res/wallpaper.jpeg;
    };

    services.hyprpaper = {
        enable = true;
        settings = {
            preload = [
                ".local/share/wallpapers/wallpaper.jpeg"
            ];
            wallpaper = [
                ",.local/share/wallpapers/wallpaper.jpeg"
            ];
        };
    };

    # Hyprland
    wayland.windowManager.hyprland = {
        enable = true;
        package = hyprland-pkgs.hyprland;
        settings = {
            "$mod" = "SUPER";
            "$terminal" = "kitty";
            monitor = [
                ", 1920x1200@165.02, 0x0, 1"
            ];
            bind = [
                # Bind application shortcuts.
                "$mod, Q, exec, $terminal"
                "$mod, C, killactive"
                "$mod, M, exec, hyprctl dispatch exit"
                "$mod, R, exec, rofi -show drun -display-drun ''"

                # Other keybinds
                "Alt, Return, fullscreen"
                "$mod, L, exec, hyprlock"
            ] ++ (
                # Bind workspace shortcuts.
                builtins.concatLists(builtins.genList(i:
                let ws = i + 1;
                in [
                    "$mod, code:1${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
                ) 9)
            );
            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, Z, movewindow1"
                "$mod, mouse:273, resizewindow"
                "$mod, X, resizewindow"
            ];
            exec-once = [
                "waybar"
            ];
            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };
            general = {
                gaps_in = 10;
                gaps_out = 10;
                border_size = 2;
                layout = "dwindle";
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
            };
            animations = {
                enabled = true;
                bezier = [
                "easeOutQuint,0.23,1,0.32,1"
                "easeInOutCubic,0.65,0.05,0.36,1"
                "easeInOutCubic,0.65,0.05,0.36,1"
                "linear,0,0,1,1"
                "almostLinear,0.5,0.5,0.75,1.0"
                "quick,0.15,0,0.1,1"
                ];
                animation = [
                "global, 1, 10, default"
                "border, 1, 5.39, easeOutQuint"
                "windows, 1, 4.79, easeOutQuint"
                "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                "windowsOut, 1, 1.49, linear, popin 87%"
                "fadeIn, 1, 1.73, almostLinear"
                "fadeOut, 1, 1.46, almostLinear"
                "fade, 1, 3.03, quick"
                "layers, 1, 3.81, easeOutQuint"
                "layersIn, 1, 4, easeOutQuint, fade"
                "layersOut, 1, 1.5, linear, fade"
                "fadeLayersIn, 1, 1.79, almostLinear"
                "fadeLayersOut, 1, 1.39, almostLinear"
                "workspaces, 1, 1.94, almostLinear, fade"
                "workspacesIn, 1, 1.21, almostLinear, fade"
                "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };
            input = {
                kb_layout = "us";
                follow_mouse = true;
                touchpad = {
                clickfinger_behavior = 1;
                };
            };
            device = {
                name = "logitech-g203-lightsync-gaming-mouse";
                sensitivity = "-0.3";
            };
            decoration = {
                rounding = 10;
                active_opacity = 0.97;
                inactive_opacity = 0.90;
                shadow = {
                enabled = true;
                range = 4;
                render_power = 3;
                color = "rgba(1a1a1aee)";
                };
                blur = {
                enabled = true;
                size = 3;
                passes = 1;
                vibrancy = 0.1696;
                };
            };
        };
    };
}