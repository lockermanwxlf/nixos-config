{
    inputs = {
        # Nix Packages
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };

        # Home Manager
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Hyprland
        hyprland = {
            url = "github:hyprwm/Hyprland";
        };
    };

    outputs = { nixpkgs, home-manager, hyprland, ... }:
        let pkgs = nixpkgs.legacyPackages.x86_64-linux;
            specialArgs = {
                hyprland-pkgs = hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
            };
        in
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = specialArgs;

                modules = [
                    ./system
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.backupFileExtension = "hm.bak";
                        home-manager.users.jake = import ./home;
                    }
                ];
            };
        };
    };
}