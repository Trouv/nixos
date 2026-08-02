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
      url = "github:Trouv/niri-flake/fix/lib-displayinfo-0-3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
    nixosConfigurations = {
      pangolin = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs;
	  systemSettings = {
	    hostName = "pangolin"; 
	    luksDeviceName = "luks-e72a7a07-20ec-444d-a711-c693cf9ed082";
	    luksDevicePath = "/dev/disk/by-uuid/e72a7a07-20ec-444d-a711-c693cf9ed082";
	    hardware-configuration = ./hardware-configuration/pangolin.nix;
	  };
	};
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
          stylix.nixosModules.stylix
        ];
      };
      torrent = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs;
	  systemSettings = {
	    hostName = "torrent";
	    luksDeviceName = "luks-754856e4-a88a-4097-a8e7-2b11635846dc";
	    luksDevicePath = "/dev/disk/by-uuid/754856e4-a88a-4097-a8e7-2b11635846dc";
	    hardware-configuration = ./hardware-configuration/torrent.nix;
	  };
	};
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
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}
