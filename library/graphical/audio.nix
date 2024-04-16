{ pkgs, lib, config, ...}:
{
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # Enable sound
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.${config.jkulzerFlakeLib.userName} = {
      packages = with pkgs; [ alsa-utils ];
    };
  };
}
