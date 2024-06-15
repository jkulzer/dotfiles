{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    users.users.${config.jkulzerFlakeLib.userName} = {
      # users.users.johannes = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        jetbrains.idea-community
      ];
    };
  };
}
