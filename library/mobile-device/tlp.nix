{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.battery.enable {
    services.tlp.enable = true;
    services.thermald.enable = true;
  };
}
