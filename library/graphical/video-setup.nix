{
	pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # Needed for sway
    hardware.graphics = {
      enable = true;
			enable32Bit = true;
    };
		# hardware = {
  # 		opengl =
  #   	{
		# 		enable = true;
		# 		driSupport32Bit = true;
		# 		# package = (mesa.overrideAttrs fn).drivers;
		# 		# package32 = (pkgsi686Linux.mesa.overrideAttrs fn).drivers;
  #   	};
		# };
    security.polkit.enable = true;
  };
}
