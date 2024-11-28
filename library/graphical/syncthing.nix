{ pkgs, ... }:
{
	services.syncthing = {
		enable = true;
		# systemService = true;
		user = "johannes";
		dataDir = "/home/johannes";
	};

	environment.systemPackages = with pkgs; [
		syncthing
	];
}
