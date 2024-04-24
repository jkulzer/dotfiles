{
  lib,
  config,
  ...
}: {
  options = {
    jkulzerFlakeLib.graphicalSystem.enable =
      lib.mkEnableOption "enables graphical packages";
    jkulzerFlakeLib.personalSystem.enable =
      lib.mkEnableOption "enables personal packages";
    jkulzerFlakeLib.battery.enable =
      lib.mkEnableOption "enables packages for devices with a battery";
    jkulzerFlakeLib.integratedDisplay.enable =
      lib.mkEnableOption "enables packages for devices with an integrated screen";
    jkulzerFlakeLib.wifi.enable =
      lib.mkEnableOption "enables packages for devices with wifi";
    jkulzerFlakeLib.bluetooth.enable =
      lib.mkEnableOption "enables packages for devices with bluetooth";
    jkulzerFlakeLib.education.enable =
      lib.mkEnableOption "enables packages for university";
    jkulzerFlakeLib.intel.enable =
      lib.mkEnableOption "enables packages for Intel CPUs";
    jkulzerFlakeLib.userName = lib.mkOption {
      type = lib.types.str;
      description = "name of the primary user";
    };
  };
}
