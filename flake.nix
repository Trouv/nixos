{
  description = "Trouvy NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim distribution with nice defaults and nix config
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      # fork used to get new background effects like "blur"
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tonearm = {
      url = "git+https://codeberg.org/dergs/Tonearm.git?ref=statemachine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    niri,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = let
      # Takes a systemSettings struct and returns a set of arguments to supply to lib.nixosSystem for the pre-system (initial install)
      preNixosSystemArgsWithSettings = (
        systemSettings: {
          specialArgs = {
            inherit inputs;
            inherit systemSettings;
          };
          modules = [
            ./preConfiguration.nix
          ];
        }
      );

      # Takes a systemSettings struct and returns a nixosSystem for the pre-system (initial install)
      preNixosSystemWithSettings = (
        systemSettings: nixpkgs.lib.nixosSystem (preNixosSystemArgsWithSettings systemSettings)
      );

      # Takes a systemSettings struct and returns a set of arguments to supply to lib.nixosSystem for the final system
      finalNixosSystemArgsWithSettings = (
        systemSettings: {
          specialArgs = {
            inherit inputs;
            inherit systemSettings;
          };
          modules = [
            ./finalConfiguration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.trouv = import ./home/trouv;

              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit systemSettings;
              };
            }
            stylix.nixosModules.stylix
          ];
        }
      );

      # Takes a systemSettings struct and returns a nixosSystem for the final system
      finalNixosSystemWithSettings = (
        systemSettings: nixpkgs.lib.nixosSystem (finalNixosSystemArgsWithSettings systemSettings)
      );

      # defines both a pre-system and final-system for the same systemSettings.
      preAndFinalNixosSystemsFromSettings = (
        systemSettings: {
          "pre-${systemSettings.hostName}" = preNixosSystemWithSettings systemSettings;
          "${systemSettings.hostName}" = finalNixosSystemWithSettings systemSettings;
        }
      );
    in (nixpkgs.lib.mergeAttrsList
      (nixpkgs.lib.map preAndFinalNixosSystemsFromSettings
        [
          {
            hostName = "pangolin";
            luksDeviceName = "luks-e72a7a07-20ec-444d-a711-c693cf9ed082";
            luksDevicePath = "/dev/disk/by-uuid/e72a7a07-20ec-444d-a711-c693cf9ed082";
            hardware-configuration = ./hardware-configuration/pangolin.nix;
            landscapeWidthProportion = 1. / 1.;
            nvidia = false;
          }
          {
            hostName = "torrent";
            luksDeviceName = "luks-754856e4-a88a-4097-a8e7-2b11635846dc";
            luksDevicePath = "/dev/disk/by-uuid/754856e4-a88a-4097-a8e7-2b11635846dc";
            hardware-configuration = ./hardware-configuration/torrent.nix;
            landscapeWidthProportion = 1. / 2.;
            nvidia = false;
          }
          {
            hostName = "oryx";
            luksDeviceName = "luks-9019da06-827c-4c90-9b68-5c0099d89a13";
            luksDevicePath = "/dev/disk/by-uuid/9019da06-827c-4c90-9b68-5c0099d89a13";
            hardware-configuration = ./hardware-configuration/oryx.nix;
            landscapeWidthProportion = 1. / 1.;
            nvidia = true;
          }
        ]));
  };
}
