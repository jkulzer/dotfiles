{ lib, config, ...}:
{
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # Needed for sway
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };
    security.polkit.enable = true;
  };
}
