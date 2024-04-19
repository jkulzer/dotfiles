{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.jkulzerFlakeLib.wifi.enable {
    programs.waybar = {
      style = ''
               #network {
          padding-right: 5px;
          padding-left: 5px;
          color: #ffffff;
        }
      '';
      settings = {
        mainBar = {
          modules-right = ["network"];
          network = {
            format-wifi = "{essid}@{ifname}";
          };
        }; # mainBar config end
      }; # waybar settings end
    }; # waybar config end
  };
}
