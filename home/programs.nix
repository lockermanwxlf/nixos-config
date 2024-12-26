{ pkgs, ... }:
{
    # Git
    programs.git = {
        enable = true;
        userName = "lockermanwxlf";
        userEmail = "95518889+lockermanwxlf@users.noreply.github.com";
    };

    # Firefox
    programs.firefox = {
        enable = true;
        profiles = {
            jake = {
                bookmarks = [{
                    name = "Nix sites";
                    toolbar = true;
                    bookmarks = [
                        {
                            name = "NixOS Wiki";
                            tags = [ "wiki" "nix" ];
                            url = "https://wiki.nixos.org/";
                        }
                        {
                            name = "Home Manager Appendix A.";
                            url = "https://nix-community.github.io/home-manager/options.xhtml";
                        }
                    ];
                }];

                search = {
                    default = "DuckDuckGo";
                    engines = {
                        "Nix Packages" = {
                            urls = [{
                            template = "https://search.nixos.org/packages";
                            params = [
                                { name = "type"; value = "packages"; }
                                { name = "query"; value = "{searchTerms}"; }
                            ];
                            }];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@np" ];
                        };
                        "NixOS Wiki" = {
                            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
                            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
                            updateInterval = 24 * 60 * 60 * 1000; # every day
                            definedAliases = [ "@nw" ];
                        };
                    };
                    force = true;
                };

                settings = {
                    # Open previous windows and tabs.
                    "browser.startup.page" = 3;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "extensions.autoDisableScopes" = 0;
                };
            };
        };
    };

    # VSCode
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
        ];
    };

    # Podman
    services.podman = {
        enable = true;
    };

    # Emacs
    programs.emacs = {
        enable = true;
        extraPackages = epkgs: [
            epkgs.lsp-mode
            epkgs.company
        ];
    };

    # Home packages
    home.packages = with pkgs; [
        android-studio
        gcc
        cmake
        vcpkg
        ninja
        jetbrains.clion
        jetbrains.rider
        dotnetCorePackages.sdk_9_0
        dotnet-ef
        postman
        nixd
        distrobox
        pgadmin4
    ];
}