{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard
		waypipe
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    config.common.default = "*";
  };
  # Screen Locker
  programs.swaylock = {
    enable = true;
    settings = {
      font-size = 30;
      show-failed-attempts = true;

      # # The line separating the indicator from the circle inside
      # line-color = "#24273a"; # Violet

      # The donut
      indicator-radius = 200;
      indicator-idle-visible = true;
      indicator-thickness = 20;
      # key-hl-color = "#ea76cb";
      # ring-color = "#f5bde6";
      #
      # ring-clear-color = "#7dc4e4";
      # ring-caps-lock-color = "##eed49f";
      # ring-ver-color = "#fe640b";
      # ring-wrong-color = "#d20f39";
      #
      # inside-clear-color = "#209fb5";
      # inside-caps-lock-color = "#df8e1d";
      # inside-ver-color = "#f5a97f";
      # inside-wrong-color = "#ed8796";
      #
      # # Background color
      # color = "#24273a";
    };
  };
  # autotiling systemd unit
  # Improves tiling experience
  systemd.user.services.autotiling = {
    Unit = {
      Description = "autotiling (makes tiling on sway more sensible)";
      After = ["sway-session.target"];
      PartOf = ["sway-session.target"];
    };
    Install = {
      WantedBy = ["sway-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.autotiling}/bin/autotiling";
      Type = "exec";
      Restart = "on-failure";
    };
  };
	home.sessionVariables = {
    # https://github.com/swaywm/sway/issues/595
    "_JAVA_AWT_WM_NONREPARENTING" = "1";
	};
}
