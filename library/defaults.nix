{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd

    unzip
    p7zip
  ];

<<<<<<< Updated upstream
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];
=======
	 swapDevices = [ 
	 	{
			device = "/var/lib/swapfile";
			size = 16*1024;
  	} 
	];

	programs.nix-ld.enable = true;
>>>>>>> Stashed changes
}
