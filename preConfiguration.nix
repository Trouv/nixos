# This file provides a significant portion of the system configuration.
# In particular, it provides the portion of the system configuration that is
# required for basic function AND improves the nixos-rebuild experience.
# i.e., anything that makes the build faster, or does away with extra
# nixos-rebuild arguments.
{
  pkgs,
  systemSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration/${systemSettings.hostName}.nix
    ./cachix.nix
    ./nvidia.nix
    ./kopiaClientVatia.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."${systemSettings.luksDeviceName}".device = systemSettings.luksDevicePath;
  networking.hostName = systemSettings.hostName;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${systemSettings.primaryUser.username} = {
    isNormalUser = true;
    description = systemSettings.primaryUser.fullname;
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # extra binary cache
    cachix
  ];

  # GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  nvidia.enable = systemSettings.nvidia;

  # The default resolv.conf is buggy on my personal network
  # Letting systemd-resolved manage it seems to work around the issue.
  services.resolved.enable = true;

  kopiaClientVatia.enable = systemSettings.kopiaClientVatia;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
