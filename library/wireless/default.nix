{lib, ...}: {
  imports =
    [
      ./bluetooth.nix
    ]
    ++ lib.optional (builtins.pathExists ./networking.nix) ./networking.nix;
}
