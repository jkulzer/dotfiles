{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager-config = {
    #   # url = "github:jkulzer/home-manager-config";
    #   url = "git+file:///home/johannes/home-manager-config";
    # };
    nixvim = {
      url = "github:jkulzer/nvim-nix";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    # home-manager-config,
    nixvim,
    sops-nix,
    stylix,
    nur,
    ...
  }:
		let
			mkSystem = { hostname, arch }: nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				system = arch;

        pkgs = import nixpkgs {
          system = arch;
          config.allowUnfree = true;
          overlays = [
            (final: prev: {
              neovim = nixvim.packages.x86_64-linux.default;
            })
            inputs.nur.overlay
          ];
        };

        modules = [
					./configuration.nix
          ./hardware/${hostname}.nix

          nur.nixosModules.nur

          stylix.nixosModules.stylix

          ./library

          home-manager.nixosModules.home-manager
          ./home-library

          {
            jkulzerFlakeLib = {
              graphicalSystem.enable = true;
              personalSystem.enable = true;
              userName = "johannes";
              bluetooth.enable = true;
              # education.enable = true;
              # battery.enable = true;
              # wifi.enable = true;
              # bluetooth.enable = true;
              # intel.enable = true;
              # integratedDisplay.enable = true;
            };

						networking.hostName = "${hostname}";
          }

          # {
          #   home-manager.users.johannes = {
          #     imports = [
          #       {
          #         jkulzerFlakeLib = {
          #           graphicalSystem.enable = true;
          #           personalSystem.enable = true;
          #           bluetooth.enable = true;
          #           userName = "johannes";
          #           # battery.enable = true;
          #           # wifi.enable = true;
          #           # integratedDisplay.enable = true;
          #         };
          #       }
          #     ];
          #   };
          # }
        ];
			};
		in {
			nixosConfigurations = {
				desktop = mkSystem { hostname = "desktop"; arch = "x86_64-linux";};
				lenowo-twinkpad = mkSystem { hostname = "lenowo-twinkpad"; arch = "x86_64-linux";};
			};
		};
}
