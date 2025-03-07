{ pkgs, ... }:
{

  # Hyprland
  programs.hyprland = {
    enable = true;
  };

  # Waybar
  programs.waybar = {
    enable = true;
  };

  # nm-applet
  programs.nm-applet = {
    enable = true;
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    kitty
    wofi
    git
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/Chicago";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # User
  programs.fish.enable = true;
  users.users.jake = {
    isNormalUser = true;
    description = "Jake Bounds";
    shell = pkgs.fish;
    initialPassword = "";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # State version
  system.stateVersion = "25.05";
}
