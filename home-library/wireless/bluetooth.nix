{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.bluetooth.enable {
    home.packages = with pkgs; [
      bluetuith
    ];
    home.file.".config/bluetuith/bluetuith.config" = {
      text = ''
        {
          keybindings {
            NavigateUp: 'k'
            NavigateDown: 'j'
            NavigateRight: 'l'
            NavigateLeft: 'h'
          }
        }
      '';
    };
    services.mpris-proxy.enable = true; # Allows media keys from bluetooth headset
  };
}
