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
    configurationLimit = 50;
    memtest86.enable = true; # Memtest
  };
  stylix.targets.grub.useImage = true;

  boot.tmp.cleanOnBoot = true;

  # Enables NTFS support (allows mounting of Windows disks)
  boot.supportedFilesystems = ["ntfs"];
}
