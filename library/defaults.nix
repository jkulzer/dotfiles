{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd

    unzip
    p7zip
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
}
