{
  imports = [
    ./bootloader.nix
    ./flakes.nix
    ./defaults.nix
    ./direnv.nix
    ./options.nix
    ./shell.nix
    ./mobile-device
		./cryptography.nix
		./stylix.nix

    ./graphical
    ./wireless
		./hardware
  ];
}
