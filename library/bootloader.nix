{
  config,
  pkgs,
  lib,
  ...
}: {
  # Use GRUB (it allows the extra entries to be in a folder to not clutter dualbooting too much)
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    configurationLimit = 25;
  };

  boot.kernelParams = [
    "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
    "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
    "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200" # Catppuccin mocha theme
  ];
  # Enables the usual predictable behaviour of the /tmp directory
  boot.tmp.cleanOnBoot = true;

  # Enables NTFS support (allows mounting of Windows disks)
  boot.supportedFilesystems = ["ntfs"];
}
