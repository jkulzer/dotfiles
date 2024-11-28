{ pkgs, ... }:
{
	services.syncthing = {
		enable = true;
		systemService = true;
		# user = "johannes";
	};

	environment.systemPackages = with pkgs; [
		syncthing
	];
	systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
