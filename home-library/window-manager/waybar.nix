{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
				  #workspaces button {
             padding: 0 5px;
         }

         button {
             /* Use box-shadow instead of border so the text isn't offset */
             box-shadow: inset 0 -3px transparent;
             /* Avoid rounded borders under each button name */
             border: none;
             border-radius: 0;
         }
         #clock {
             padding-right: 5px;
             padding-left: 5px;
         }

         #pulseaudio {
             padding-right: 5px;
             padding-left: 5px;
         }

         #language {
             padding: 0 5px;
             margin: 0 5px;
             min-width: 16px;
         }

         #keyboard-state {
             padding: 0 0px;
             margin: 0 5px;
             min-width: 16px;
         }

         #keyboard-state > label {
             padding: 0 5px;
         }

         tooltip {
           border: 1px solid ;
         }

    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = ["sway/workspaces"];
				modules-center = [ "custom/ical-timediff" ];
        modules-right = ["cpu" "sway/language" "pulseaudio" "clock"];
				height = 27;
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
