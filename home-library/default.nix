{
  config,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./personal.nix
    ./mobile-device
    ../library/options.nix

    ./k8s
    ./window-manager
    ./wireless
  ];
}
