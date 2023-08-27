{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.johannes = {
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
          # Hyprpaper SystemD unit
          systemd.user.services.hyprpaper = {
            Unit = {
              Description = "Hyprpaper (Hyprland wallpaper management software)";
              After = [ "graphical-session.target" ];
              PartOf = [ "graphical-session.target" ];
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
            Service = {
              ExecStart = "/etc/profiles/per-user/johannes/bin/hyprpaper";
              Type = "exec";
              Restart = "on-failure";
            };
          };
          # Hyprpaper config
          home.file.".config/hypr/hyprpaper.conf" = {
            text = ''
            preload = ~/dotfiles/wallpaper.png
            wallpaper = DP-3,~/dotfiles/wallpaper.png
            wallpaper = HDMI-A-1,~/dotfiles/wallpaper.png
            '';
          }; #home.file ending
          programs.firefox = {
            enable = true;
          };
          programs.kitty = {
            enable = true;
            shellIntegration.enableZshIntegration = true;
            settings = {
              background_opacity = "0.6";
              background = "#38133B";
            }; # Kitty settings end
          }; # Kitty end
          wayland.windowManager.hyprland = {
            enable = true;
            systemdIntegration = true;
            settings = {
              monitor = [ "DP3,1,auto,auto" "HDM1-A-1,2,auto,auto" ];
              env = "XCURSOR_SIZE=11";
              input = {
                kb_layout = "us";
                follow_mouse = 1;
                numlock_by_default = true;
              };
              general = {
                gaps_in = 2;
                gaps_out = 5;
                border_size = 2;
                "col.active_border" = "rgb(d60270) rgb(0038a8) 90deg";
                "col.inactive_border" = "rgb(a681a4)";
                layout = "dwindle";
              };
              decoration = {
                rounding = 0;
                drop_shadow = "yes";
                "col.shadow" = "rgba(1a1a1aee)";
              };
              animations = {
                enabled = "yes";
              };
              dwindle = {
                pseudotile = "yes";
                preserve_split = "yes";
              };
              master = {
                new_is_master = true;
              };
              "$mainMod" = "SUPER";
              bind = [
              # Open Terminal
              "$mainMod, T, exec, kitty"

              # Move between windows
              "$mainMod, L, movefocus, l"
              "$mainMod, J, movefocus, r"
              "$mainMod, K, movefocus, u"
              "$mainMod, H, movefocus, d"

              # Move between workspaces
              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, 6, workspace, 6"
              "$mainMod, 7, workspace, 7"
              "$mainMod, 8, workspace, 8"
              "$mainMod, 9, workspace, 9"
              "$mainMod, 0, workspace, 10"

              # Move windows to workspace
              "$mainMod CTRL, 1, movetoworkspace, 1"
              "$mainMod CTRL, 2, movetoworkspace, 2"
              "$mainMod CTRL, 3, movetoworkspace, 3"
              "$mainMod CTRL, 4, movetoworkspace, 4"
              "$mainMod CTRL, 5, movetoworkspace, 5"
              "$mainMod CTRL, 6, movetoworkspace, 6"
              "$mainMod CTRL, 7, movetoworkspace, 7"
              "$mainMod CTRL, 8, movetoworkspace, 8"
              "$mainMod CTRL, 9, movetoworkspace, 9"
              "$mainMod CTRL, 0, movetoworkspace, 10"

              # Music control
              "CTRL SHIFT, SPACE, exec, playerctl play-pause"
              "CTRL SHIFT, L , exec, playerctl next"
              "CTRL SHIFT, H, exec, playerctl previous"

              # Shortcuts to open applications
              # Firefox
              "$mainMod, F, exec, firefox"
              # Element
              "$mainMod, M, exec, element-desktop"
              # Discord
              "$mainMod, D, exec, discord"
              # Obsidian
              "$mainMod, O, exec, obsidian"

              # Lockscreen
              "$mainMod, W, exec, swaylock"
              ]; # End of bind array

              binde = [
              # Control Volume
              "CTRL SHIFT, J, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
              "CTRL SHIFT, K, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ]; # End of binde array
                          
              bindm = [
              # Move and resize window with mouse
              "$mainMod, mouse:272, movewindow"
              "$mainMod, mouse:273, resizewindow"
              ];

              workspace = [
              "DP-3,1"
              "DP-3,3"
              "DP-3,5"
              "DP-3,7"
              "DP-3,9"

              "HDMI-A-1,2"
              "HDMI-A-1,4"
              "HDMI-A-1,6"
              "HDMI-A-1,8"
              "HDMI-A-1,10"
              ]; # End of workspace config
            }; # End of Hyprland settings
          }; # End of Hyprland config
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

            '';
            settings = {
              mainBar = {
                layer = "top";
                position = "top";
                modules-left = ["hyprland/workspaces"];
                modules-center = ["mpris"];
                modules-right = ["pulseaudio" "clock"];
                pulseaudio = {
                  scroll-step = 5; # in %
                };
                mpris = {
                  format = "{title} - {artist}";
                  tooltip-format = "{album}";
                };
              }; # mainBar config end
            }; # waybar settings end
          }; # waybar config end
          home.stateVersion = "23.11";
          }; # End of User config
        } # End of home-manager config brackets
      ];
    };
  };
}
