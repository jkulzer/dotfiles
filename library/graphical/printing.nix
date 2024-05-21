{
  lib,
  config,
	pkgs,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    # enables CUPS
    services.printing.enable = true;

		environment.systemPackages = with pkgs; [
			cups-pdf-to-pdf
		];
  };
}
