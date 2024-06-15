{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd

    unzip
  ];
}
