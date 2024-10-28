{pkgs, ...}: {
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../wallpaper.jpg;
    # image = builtins.fetchurl {
    #   url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-stripes-logo.png";
    #   sha256 = "0cqjkgp30428c1yy8s4418k4qz0ycr6fzcg4rdi41wkh5g1hzjnl";
    # };

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "share/icons/Bibata-Modern-Ice";
    };

    fonts = {
      sizes = {
        desktop = 9;
      };
    };
  };
}
