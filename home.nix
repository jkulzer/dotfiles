{ config, pkgs, ... }:

{
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";

  # Window Manager
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs."swayfx"; # This uses https://github.com/willpower3309/swayfx instead of the normal sway. swayfx enables blur
    extraConfig = ''
    blur enable
    blur_passes 3
    layer_effects "waybar" blur enable; blur_passes 1;
    '';
    config = {
      terminal = "kitty";
      modifier = "Mod4"; # Super
      keybindings = import ./sway/keybindings.nix {inherit pkgs;};
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
  programs.firefox = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = "0.8";
      background = "#38133B";
    }; # Kitty settings end
  }; # Kitty end
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
    * {
        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
    }

    window#waybar {
        background-color: rgba(214, 2, 112, 0.5);
        border-bottom: 3px rgba(214, 2, 112, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
        border-radius: 0;
    }

    button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
    }

    #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.focused {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
        background-color: #eb4d4b;
    }

    #clock {
        color: #ffffff;
        padding-right: 5px;
        padding-left: 5px;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }

    label:focus {
        background-color: #000000;
    }

    #pulseaudio {
        color: #ffffff;
        padding-right: 5px;
        padding-left: 5px;
    }

    #pulseaudio.muted {
        background-color: #90b1b1;
        color: #2a5c45;
    }

    #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
    }

    #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
    }

    #keyboard-state > label {
        padding: 0 5px;
    }

    tooltip {
      background: rgba(43, 48, 59, 1);
      border: 1px solid rgba(100, 114, 125, 1);
    }

    tooltip label {
      color: white;
    }

    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = ["sway/workspaces"];
        modules-center = ["mpris"];
        modules-right = ["pulseaudio" "clock"];
        pulseaudio = {
          scroll-step = 5; # in %
        };
        mpris = {
          format = "{title} - {artist}";
          tooltip-format = "{album}";
          on-left-click = "previous";
          on-right-click = "next";
          on-double-click = "play-pause";
        };
      }; # mainBar config end
    }; # waybar settings end
  }; # waybar config end
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
