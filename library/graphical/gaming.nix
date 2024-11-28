{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # hardware.graphics = {
    #   enable32Bit = true;
    #   extraPackages = [pkgs.amdvlk];
    #   extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    # };
		programs.gamescope.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
			protontricks.enable = true;
			package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
				extraBwrapArgs = ["--bind /tmp /tmp"];
        extraPkgs =
          pkgs: with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamemode
          ];
      };
      extraCompatPackages = with pkgs; [
       	proton-ge-bin
      ];
    };

    environment.systemPackages = with pkgs; [
			steamcmd
			steam-tui
      mangohud
      gamemode
      discord
      vesktop
    ];
  };
}
