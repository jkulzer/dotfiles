{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:jkulzer/nvim-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	pkgs = import nixpkgs {
	  system = "x86_64-linux";
	  config.allowUnfree = true;
	  overlays = [
	    (final: prev: {
	      neovim = nixvim.packages.x86_64-linux.default;
	    })
	  ];
	};

	modules = [
	  ./configuration.nix
	  ./library
	  {
	    jkulzerFlakeLib = { 
	      graphicalSystem.enable = true;
	      personalSystem.enable = true;
              userName = "johannes";
	    };
	  }
	  
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;

	    home-manager.users.johannes = {
	      imports = [
	        ./home-library
	      ];
	    };
	  }
	];

      };
    };
  };
}
