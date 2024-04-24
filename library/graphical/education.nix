{ lib, config, pkgs, ...}:{
	config = lib.mkIf config.jkulzerFlakeLib.education.enable {
		environment.systemPackages = with pkgs; [
			logisim
			logisim-evolution

    	# support both 32- and 64-bit applications
    	wineWowPackages.stable

    	# winetricks (all versions)
    	winetricks

    	# native wayland support (unstable)
    	wineWowPackages.waylandFull
		];
	};
}
