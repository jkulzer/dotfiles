{ lib, config, ...}:
{
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # enables CUPS
    services.printing.enable = true;
  };
}
