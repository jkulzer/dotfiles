{ lib, config, pkgs, ...}:{
	config = lib.mkIf config.jkulzerFlakeLib.education.enable {
		environment.variables = {
			_JAVA_AWT_WM_NONREPARENTING = 1;
		};
		environment.systemPackages = with pkgs; [
			logisim
			logisim-evolution

			geogebra6

			eclipses.eclipse-java
		];
	};
}
