{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

	services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    # Nix helper tools
    # nh
    nix-output-monitor
    nvd
		
		unzip
  ];
}
