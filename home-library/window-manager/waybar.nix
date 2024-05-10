{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
         /*
         * Catppuccin Mocha palette
         * Maintainer: rubyowo
         */

         @define-color base   #1e1e2e;
         @define-color mantle #181825;
         @define-color crust  #11111b;

         @define-color text     #cdd6f4;
         @define-color subtext0 #a6adc8;
         @define-color subtext1 #bac2de;

         @define-color surface0 #313244;
         @define-color surface1 #45475a;
         @define-color surface2 #585b70;

         @define-color overlay0 #6c7086;
         @define-color overlay1 #7f849c;
         @define-color overlay2 #9399b2;

         @define-color blue      #89b4fa;
         @define-color lavender  #b4befe;
         @define-color sapphire  #74c7ec;
         @define-color sky       #89dceb;
         @define-color teal      #94e2d5;
         @define-color green     #a6e3a1;
         @define-color yellow    #f9e2af;
         @define-color peach     #fab387;
         @define-color maroon    #eba0ac;
         @define-color red       #f38ba8;
         @define-color mauve     #cba6f7;
         @define-color pink      #f5c2e7;
         @define-color flamingo  #f2cdcd;
         @define-color rosewater #f5e0dc;

         * {
             font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
             font-size: 13px;
      color: @text;
         }

         window#waybar {
             background-color: @base;
             border-bottom: 3px solid @base;
             color: #ffffff;
             transition-property: background-color;
             transition-duration: .5s;
         }

         window#waybar.hidden {
             opacity: 1;
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

				 #cpu {
				 		color: #ffffff;
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
             color: #ffffff;
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
				modules-center = [ "custom/ical-timediff" ];
        modules-right = ["cpu" "sway/language" "pulseaudio" "clock"];
        pulseaudio = {
          scroll-step = 5; # in %
        };
				"custom/ical-timediff" = {
    			return-type = "json";
					interval = 15;
    			exec = "~/projects/waybar-ical-timediff/result/bin/waybar-ical-timediff https://hwrical.zrgr.pw/informatik/semester2/kursa/Tutorium/Gruppe%201/Englisch";
					format = "Lecture Progress: {}";
				};
				clock = {
					interval = 1;
					format = "{:%H:%M:%S}";
					tooltip = "true";
					# tooltip-format = "{%d.%m}";
				};
				cpu = {
					"interval"= 10;
    			"format"= "{load}";
    			"max-length"= 10;
				};
      }; # mainBar config end
    }; # waybar settings end
  }; # waybar config end
}
