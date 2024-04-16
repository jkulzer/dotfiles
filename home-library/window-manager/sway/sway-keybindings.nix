{pkgs}:
with pkgs; let
  modifier = "Mod1";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
in {
  # General stuff
  "${modifier}+q" = "kill";

  # Applications
  "${modifier}+t" = "exec kitty"; # Terminal
  "${modifier}+Return" = "exec kitty"; # Terminal
  "${modifier}+f" = "exec firefox"; # Firefox
  "${modifier}+w" = "exec swaylock"; # Lockscreen
  "${modifier}+d" = "exec vesktop"; # Discord
  "${modifier}+o" = "exec obsidian"; # Obsidian (Note taking tool)
  "${modifier}+g" = "exec gimp"; # Gimp
  "${modifier}+r" = "exec winbox"; # Winbox
  "${modifier}+Space" = "exec bemenu-run"; # bemenu

  # Music control
  "Ctrl+Shift+l" = "exec playerctl next"; # Next Track
  "Ctrl+Shift+h" = "exec playerctl previous"; # Previous Track
  "Ctrl+Shift+Space" = "exec playerctl play-pause"; # Play/Pause current track
  "Ctrl+Shift+j" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; # Volume up by 5%
  "Ctrl+Shift+k" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; # Volume down by 5 %

  # screenshots
  "${modifier}+p" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";

  "${modifier}+${left}" = "focus left; exec $movemouse";
  "${modifier}+${down}" = "focus down; exec $movemouse";
  "${modifier}+${up}" = "focus up; exec $movemouse";
  "${modifier}+${right}" = "focus right; exec $movemouse";

  "${modifier}+Ctrl+${left}" = "move left";
  "${modifier}+Ctrl+${down}" = "move down";
  "${modifier}+Ctrl+${up}" = "move up";
  "${modifier}+Ctrl+${right}" = "move right";

  "${modifier}+1" = "workspace number 1";
  "${modifier}+2" = "workspace number 2";
  "${modifier}+3" = "workspace number 3";
  "${modifier}+4" = "workspace number 4";
  "${modifier}+5" = "workspace number 5";
  "${modifier}+6" = "workspace number 6";
  "${modifier}+7" = "workspace number 7";
  "${modifier}+8" = "workspace number 8";
  "${modifier}+9" = "workspace number 9";
  "${modifier}+0" = "workspace number 10";

  "${modifier}+Shift+1" = "move container to workspace number 1";
  "${modifier}+Shift+2" = "move container to workspace number 2";
  "${modifier}+Shift+3" = "move container to workspace number 3";
  "${modifier}+Shift+4" = "move container to workspace number 4";
  "${modifier}+Shift+5" = "move container to workspace number 5";
  "${modifier}+Shift+6" = "move container to workspace number 6";
  "${modifier}+Shift+7" = "move container to workspace number 7";
  "${modifier}+Shift+8" = "move container to workspace number 8";
  "${modifier}+Shift+9" = "move container to workspace number 9";
  "${modifier}+Shift+0" = "move container to workspace number 10";

  "${modifier}+Shift+c" = "reload";
  "${modifier}+Shift+r" = "restart";
}
