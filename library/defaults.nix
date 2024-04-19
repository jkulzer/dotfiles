{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    # Nix helper tools
    nh
    nix-output-monitor
    nvd
  ];
}
