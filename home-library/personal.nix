{
  lib,
  config,
  pkgs,
  ...
}: {
  # config = lib.mkIf config.jkulzerFlakeLib.personalSystem.enable {

  home.packages = with pkgs; [
    hyfetch
    blahaj
    # uwufetch
    gay
  ];
  # ConfigFile for hyfetch
  home.file.".config/hyfetch.json" = {
    text = ''
      {
        "preset": "rainbow",
        "mode": "rgb",
        "light_dark": "dark",
        "lightness": 0.65,
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
  # };
}
