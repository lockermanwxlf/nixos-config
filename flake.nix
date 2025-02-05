{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        installationIso = inputs.nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./installation/iso.nix
          ];
        };
      };
    };
}
