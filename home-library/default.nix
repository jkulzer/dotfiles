{config, lib, ...}:
{
  imports = [
    ./home.nix
    ./personal.nix

    ./k8s
    ./window-manager
  ];
}
