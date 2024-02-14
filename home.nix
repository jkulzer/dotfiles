{ config, lib, pkgs, ... }:

{
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";

  services.syncthing = {
    enable = true;
  };
  # ConfigFile for hyfetch
  home.file.".config/hyfetch.json" = {
    text = ''
      {
        "preset": "bisexual",
        "mode": "rgb",
        "light_dark": "dark",
        "lightness": 0.5,
        "color_align": {
          "mode": "horizontal",
          "fore_back": null
        },
        "backend": "neofetch",
        "distro": null,
        "pride_month_shown": []
      }
    '';
  }; #hyfetch config ending
  home.stateVersion = "23.11";
  #} # End of User config
}
