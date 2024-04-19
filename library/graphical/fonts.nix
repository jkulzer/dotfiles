{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
    fonts.packages = with pkgs; [
      noto-fonts # Nice default font
      roboto # Cool font
      fira-code # Terminal font
      fira-code-symbols # for icons
    ];
  };
}
