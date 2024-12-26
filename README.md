# My NixOS Config

My NixOS config using [nixos-unstable](https://github.com/NixOS/nixpkgs/tree/nixos-unstable), [home-manager](https://github.com/nix-community/home-manager), and [Hyprland](https://github.com/hyprwm/Hyprland) flakes.

Programs are put generally in a few files as I've found that with how flakes interact with Git, its more convenient to have fewer files vs. organizing based on workflows or making a file per program.

# Setup

You'll at least want to change the hardware configuration.

```sh
nixos-generate-config --show-hardware-config > ./system/hardware.nix
```

Double-check to make sure its mapping your devices, including LUKS (if used), properly. I've noticed by default `nixos-generate-config` does not add my encrypted swap as a LUKS device.

### Tracking with Git

To track my config with git, I keep this repository at `~/nixos-config`, and I make a symbolic link to `/etc/nixos` with

```sh
sudo ln -s ~/nixos-config /etc/nixos
``` 

# Hyprland Cachix

You may have to temporarily comment out the Hyprland [module](system/programs.nix), run `nixos-rebuild switch` to first apply the Hyprland Cachix settings, then uncomment out the module, and run `nixos-rebuild switch` again in order to get the flake to use the Hyprland build in Cachix. 

Otherwise, Hyprland and its dependencies will be built/compiled locally, which will take a while.