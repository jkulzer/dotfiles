{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      gamemode
      discord
      vesktop
    ];
  };
}
