{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # A display/login manager
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --width 60 --cmd sway --greeting 'Access restricted to authorized users'";
        };
      };
    };
    # Fixes this bug: https://github.com/apognu/tuigreet/issues/68
    # Found here: https://github.com/apognu/tuigreet/issues/68#issuecomment-1586359960
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
