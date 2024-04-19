{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    environment.systemPackages = with pkgs; [
      bluez # bluetoothctl
    ];
  };
}
