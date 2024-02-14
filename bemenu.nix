{ config, lib, pkgs, ...}:

{
  programs.bemenu = {
    enable = true;
    settings = {
      line-height =  23;
      width-factor = 0.3;
    };
  };
}
