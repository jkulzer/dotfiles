{pkgs, ...}: {
  home.packages = [pkgs.dconf]; # https://github.com/nix-community/home-manager/issues/3113
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-Macchiato-Compact-Pink-dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = ["pink"];
  #       size = "compact";
  #       tweaks = ["rimless" "black"];
  #       variant = "mocha";
  #     };
  #   };
  # };
}
