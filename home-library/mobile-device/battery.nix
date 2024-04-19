{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.battery.enable {
    programs.waybar = {
      style = ''
        #battery {
          padding-right: 5px;
          padding-left: 5px;
          color: #ffffff;
        }
      '';
      settings = {
        mainBar = {
          modules-right = ["battery"];
          battery = {
            format = "{power}W@{capacity}%";
            interval = "5";
          };
        }; # mainBar config end
      }; # waybar settings end
    }; # waybar config end
  };
}
