# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  systemSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    systemSettings.hardware-configuration
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."${systemSettings.luksDeviceName}".device = systemSettings.luksDevicePath;
  networking.hostName = systemSettings.hostName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # discover printers and other machines
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.trouv = {
    isNormalUser = true;
    description = "Trevor Lovell";
    extraGroups = ["networkmanager" "wheel" "input"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    wl-clipboard
    brightnessctl

    # file manager
    nautilus
    # image viewer
    loupe
    # audio player
    decibels
    # video player
    showtime
    # disk usage analyzer
    baobab
    # document scanner
    simple-scan
    # document viewer
    papers
    # calendar
    gnome-calendar
    # calculator
    gnome-calculator
    # maps
    gnome-maps
    # weather
    gnome-weather

    # tidal client
    tonearm
    # media control
    playerctl

    # gaming..
    (heroic.override {
      extraPkgs = pkgs':
        with pkgs'; [
          gamescope
          gamemode
        ];
    })
    lutris # install lutris launcher
    protonup-qt # GUI for installing custom Proton versions like GE_Proton
    (retroarch.withCores (
      cores:
        with cores; [
          snes9x
        ]
    ))

    # x support
    xwayland-satellite

    # backup client
    kopia
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Caps -> Esc
  services.udev.extraHwdb = ''
    evdev:atkbd:*
      KEYBOARD_KEY_3a=esc
  '';

  # enables waybar power profiles module
  services.power-profiles-daemon.enable = true;

  # AMD GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  stylix = {
    enable = true;
    # Jan Brueghel - Flowers in a Basket and a Vase, 1615
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/painting/flower-basket.jpg";
      hash = "sha256-5hiPxQmzM28fIuCXMowpveYE52yWUJLeaaWGH6NYdZg=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    opacity.desktop = 0.9;
    opacity.terminal = 0.9;

    cursor = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
      size = 22;
    };
  };

  # gaming
  programs.gamemode.enable = true; # for performance mode
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true; # install steam
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # kopia snapshot frequency
  systemd.timers."kopia-snapshot-home" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "kopia-snapshot-home.service";
    };
  };
  systemd.services."kopia-snapshot-home" = {
    path = [pkgs.kopia];
    script = "kopia snapshot create /home/trouv";
    serviceConfig = {
      Type = "oneshot";
      User = "trouv";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
