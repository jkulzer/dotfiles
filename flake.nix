{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-config = {
      # url = "github:jkulzer/home-manager-config";
      url = "git+file:///home/johannes/home-manager-config";
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
    nur = {
      url = "github:nix-community/NUR";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    home-manager-config,
    nixvim,
    sops-nix,
    stylix,
    nur,
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
            inputs.nur.overlay
          ];
        };

        modules = [
          ./configuration.nix
          ./hardware/desktop.nix
          nur.nixosModules.nur
          ./library
          {
            jkulzerFlakeLib = {
              graphicalSystem.enable = true;
              personalSystem.enable = true;
              userName = "johannes";
              bluetooth.enable = true;
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
                {
                  jkulzerFlakeLib = {
                    graphicalSystem.enable = true;
                    personalSystem.enable = true;
                    bluetooth.enable = true;
                    userName = "johannes";
                  };
                }
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
            inputs.nur.overlay
          ];
        };

        modules = [
          ./configuration.nix
          ./hardware/lenowo-twinkpad.nix
          nur.nixosModules.nur
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
                home-manager-config.config
                # ./home-library
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
