{ lib, config, pkgs, ...}:{
	config = lib.mkIf config.jkulzerFlakeLib.education.enable {
		environment.variables = {
			_JAVA_AWT_WM_NONREPARENTING = 1;
		};
		environment.systemPackages = with pkgs; [
			logisim

    	# support both 32- and 64-bit applications
    	wineWowPackages.stable

    	# winetricks (all versions)
    	winetricks

    	# native wayland support (unstable)
    	wineWowPackages.waylandFull
		];
	};
}
