{config, lib, ...}:
{
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # Needed for Swaylock to work correctly
    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };
}
