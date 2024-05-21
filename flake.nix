{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixvim,
		sops-nix,
		stylix,
    ...
  }: {
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
					./hardware/desktop.nix
          ./library
          {
            jkulzerFlakeLib = {
              graphicalSystem.enable = true;
              personalSystem.enable = true;
              userName = "johannes";
            };
          }

					stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
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
      lenowo-twinkpad = nixpkgs.lib.nixosSystem {
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
					./hardware/lenowo-twinkpad.nix
          ./library
					sops-nix.nixosModules.sops
          {
            jkulzerFlakeLib = {
              graphicalSystem.enable = true;
              personalSystem.enable = true;
							education.enable = true;
              battery.enable = true;
              wifi.enable = true;
              bluetooth.enable = true;
							intel.enable = true;
              integratedDisplay.enable = true;
              userName = "johannes";
            };

            networking.hostName = "lenowo-twinkpad";
          }

					stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.johannes = {
              imports = [
                ./home-library
                {
                  jkulzerFlakeLib = {
                    graphicalSystem.enable = true;
                    personalSystem.enable = true;
                    battery.enable = true;
                    bluetooth.enable = true;
                    wifi.enable = true;
                    integratedDisplay.enable = true;
                    userName = "johannes";
                  };
                }
              ];
            };
          }
        ];
      };
    };
  };
}
