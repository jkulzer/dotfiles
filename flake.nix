{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
	  #//TODO TEMPORARY FIX!!!
	  config.permittedInsecurePackages = [
	    "electron-25.9.0"
	  ];
	};

	modules = [
	  ./configuration.nix
	  nixvim.nixosModules.nixvim
	  {
	    programs = import ./neovim.nix;
	  }
	  
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;

	    home-manager.users.johannes = {
	      imports = [
		./home.nix # Misc configs
		./sway.nix # Window Manager config
		./mako.nix # Mako (notification daemon) config
		./gtk.nix # Catppuccin gtk config
		./waybar.nix # Nice statusbar
		./direnv.nix # Automatically enter default.nix environment
		./kitty.nix # Terminal
		./helm.nix # Helm repo configuration
		./bemenu.nix # Application Launcher
	      ];
	    };
	  }
	];
      };
    };
  };
}
