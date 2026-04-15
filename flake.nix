{
  description = "Trouvy NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim distribution with nice defaults and nix config
    nvf.url = "github:NotAShelf/nvf";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.pangolin = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.trouv = import ./home/trouv;

          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };
  };
}
