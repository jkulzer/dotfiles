{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.integratedDisplay.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
  };
}
