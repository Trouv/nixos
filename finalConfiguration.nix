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
    inputs.niri.nixosModules.niri
    ./preConfiguration.nix
    ./scripts.nix
  ];

  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gtk"
          "gnome"
        ];
      };
      niri = {
        default = [
          "gtk"
          "gnome"
        ];
      };
    };
  };
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
  ];

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
    wireplumber.enable = true;
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
    inputs.tonearm.packages.${pkgs.stdenv.hostPlatform.system}.tonearm

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

    # temperature sensors
    lm_sensors

    # gamedev
    blender
    krita
    ardour
  ];

  # enables waybar power profiles module
  services.power-profiles-daemon.enable = true;

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

    polarity = "dark";
  };

  # gaming
  programs.gamemode.enable = true; # for performance mode
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true; # install steam
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    protontricks.enable = true;
  };

  # display manager
  services.displayManager = {
    gdm.enable = true;
    defaultSession = "niri";
  };
}
