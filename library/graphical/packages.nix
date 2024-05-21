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
        # The best browser
        # firefox

        # Utilities
        libsForQt5.ark # KDE Unzipping tool
        kitty # The terminal of choice

        # Organization
        obsidian # Knowledge manager

        # Communication
        element-desktop # Matrix client
				signal-desktop

        # Media stuff
        mpv
        playerctl
      ];
    };
  };
}
