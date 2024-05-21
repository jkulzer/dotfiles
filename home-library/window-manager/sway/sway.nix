{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      keybindings = import ./sway-keybindings.nix {inherit pkgs;};
      colors = {
        # focused = {
        #   background = "#285577";
        #   border = "#d60270";
        #   childBorder = "#d60270";
        #   indicator = "#d60270";
        #   text = "#ffffff";
        # };
        # focusedInactive = {
        #   background = "#9B4F96";
        #   border = "#9B4F96";
        #   childBorder = "#9B4F96";
        #   indicator = "#0038a8";
        #   text = "#ffffff";
        # };
        # unfocused = {
        #   background = "#285577";
        #   border = "#0038a8";
        #   childBorder = "#0038a8";
        #   indicator = "#0038a8";
        #   text = "#ffffff";
        # };
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
			input = {
				"type:touchpad" =  {
    			natural_scroll = "disabled";
				};
				"type:keyboard" = {
					xkb_layout = "us,de";
    			xkb_options =  "grp:win_space_toggle,compose:caps";
				};
			};
      output = {
        DP-3 = {
          pos = "0 0";
        };
        HDMI-A-1 = {
          pos = "-1680 0";
        };
        "*" = {
          bg = let
            img = builtins.fetchurl {
              url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-stripes-logo.png";
              sha256 = "0cqjkgp30428c1yy8s4418k4qz0ycr6fzcg4rdi41wkh5g1hzjnl";
            };
          in "${img} fill";
        };
      };
      workspaceOutputAssign = [
        {
          workspace = "1";
        }
        {
          workspace = "3";
        }
        {
          workspace = "5";
        }
        {
          workspace = "7";
        }
        {
          workspace = "9";
        }

        {
          workspace = "2";
        }
        {
          workspace = "4";
        }
        {
          workspace = "6";
        }
        {
          workspace = "8";
        }
        {
          workspace = "10";
        }
      ];
    };
  };
}
