{ lib, config, ...}:
{
  options = {
    jkulzerFlakeLib.graphicalSystem.enable =
      lib.mkEnableOption "enables graphical packages";
    jkulzerFlakeLib.personalSystem.enable =
      lib.mkEnableOption "enables personal packages";
    jkulzerFlakeLib.userName = lib.mkOption {
      type = lib.types.str;
      description = "name of the primary user";
    };
  };

  imports = [
    ./bootloader.nix
    ./flakes.nix
    ./defaults.nix
    ./direnv.nix
    ./shell.nix

    ./graphical
  ];
}
