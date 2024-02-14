{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_size = "10.0";
      background_opacity = "1";
      window_padding_width= "5";
    }; # Kitty settings end
  }; # Kitty end
}
