{ config, lib, pkgs, ... }:

{
  # Window Manager
  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4"; # Super
      keybindings = import ./sway-keybindings.nix {inherit pkgs;};
      colors = {
	focused = {
	  background = "#285577";
	  border = "#d60270";
	  childBorder = "#d60270";
	  indicator = "#d60270";
	  text = "#ffffff";
	};
	focusedInactive= {
	  background = "#285577";
	  border = "#0038a8";
	  childBorder = "#0038a8";
	  indicator = "#0038a8";
	  text = "#ffffff";
	};
	unfocused = {
	  background = "#285577";
	  border = "#0038a8";
	  childBorder = "#0038a8";
	  indicator = "#0038a8";
	  text = "#ffffff";
	};
      };
      gaps = {
	inner = 2;
	outer = 5;
      };
      window = {
	titlebar = false;
      };
      bars = []; # This disables the default bar
      # I don't want to start waybar from here, imo a systemd service provides control
      workspaceOutputAssign = [
	{ workspace = "1";	output = "DP-3";}
	{ workspace = "3";	output = "DP-3";}
	{ workspace = "5";	output = "DP-3";}
	{ workspace = "7";	output = "DP-3";}
	{ workspace = "9";	output = "DP-3";}

	{ workspace = "2";	output = "HDMI-A-1";}
	{ workspace = "4";	output = "HDMI-A-1";}
	{ workspace = "6";	output = "HDMI-A-1";}
	{ workspace = "8";	output = "HDMI-A-1";}
	{ workspace = "10";	output = "HDMI-A-1";}
      ];
    };
  };
  # Screen Locker
  programs.swaylock = {
    enable = true;
    settings = {
      font-size = 30;
      show-failed-attempts = true;

      # The line separating the indicator from the circle inside
      line-color = "9B4F96"; # Violet

      # The donut
      indicator-radius = 200;
      indicator-idle-visible = true;
      indicator-thickness = 20;
      ring-color = "009E54"; # Green

      # Background color
      color = "77287D"; # Violet
    };
  };
  # swaybg systemd unit
  systemd.user.services.swaybg= {
    Unit = {
      Description = "swaybg (sway wallpaper management software)";
      After = [ "sway-session.target" ];
      PartOf = [ "sway-session.target" ];
    };
    Install = {
      WantedBy = [ "sway-session.target" ];
    };
    Service = {
      ExecStart = "/etc/profiles/per-user/johannes/bin/swaybg -i /home/johannes/dotfiles/wallpaper.png -m fill";
      Type = "exec";
      Restart = "on-failure";
    };
  };
  # autotiling systemd unit
  # Improves tiling experience
  systemd.user.services.autotiling= {
    Unit = {
      Description = "autotiling (makes tiling on sway more sensible)";
      After = [ "sway-session.target" ];
      PartOf = [ "sway-session.target" ];
    };
    Install = {
      WantedBy = [ "sway-session.target" ];
    };
    Service = {
      ExecStart = "/etc/profiles/per-user/johannes/bin/autotiling";
      Type = "exec";
      Restart = "on-failure";
    };
  };
}
