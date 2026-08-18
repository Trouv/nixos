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
      url = "git+https://codeberg.org/dergs/Tonearm";
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

              home-manager.users.${systemSettings.primaryUser.username} = import ./home;

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

      # Some machinery for getting a list of systemSettings attrsets from ./systemSettings files
      systemSettingsDir = ./systemSettings;
      systemSettingsPath = name: value: systemSettingsDir + ("/" + name);
      filterSystemSettings = key: value: value == "regular" && nixpkgs.lib.hasSuffix ".nix" key;
      systemSettingsPaths = nixpkgs.lib.mapAttrsToList systemSettingsPath (nixpkgs.lib.filterAttrs filterSystemSettings (builtins.readDir systemSettingsDir));
      pathToSystemSettings = path: (import path) // {hostName = nixpkgs.lib.removeSuffix ".nix" (baseNameOf path);};

      allSystemSettings = nixpkgs.lib.map pathToSystemSettings systemSettingsPaths;

      allSystems =
        nixpkgs.lib.mergeAttrsList
        (
          nixpkgs.lib.map preAndFinalNixosSystemsFromSettings allSystemSettings
        );
    in
      allSystems;
  };
}
