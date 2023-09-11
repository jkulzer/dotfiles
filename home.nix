{ config, lib, pkgs, ... }:

{
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";

  services.syncthing = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_size = "10.0";
      background_opacity = "1";
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
        background-color: rgba(214, 2, 112, 0.0);
        border-bottom: 3px rgba(214, 2, 112, 0.0);
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
  # ConfigFile for helm repositories
  home.file.".config/helm/repositories.yaml" = {
    text = ''
    repositories:
    - name: prometheus-community
      url: https://prometheus-community.github.io/helm-charts
    - name: authentik
      url: https://charts.goauthentik.io
    - name: gitea-charts
      url: https://dl.gitea.com/charts/
    - name: grafana-charts
      url: https://grafana.github.io/helm-charts/
    - name: rook-release
      url: https://charts.rook.io/release
    - name: cilium
      url: https://helm.cilium.io/
    - name: zammad
      url: https://zammad.github.io/zammad-helm
    - name: metrics-server
      url: https://kubernetes-sigs.github.io/metrics-server/
    - name: fairwinds-stable
      url: https://charts.fairwinds.com/stable
    - name: argo
      url: https://argoproj.github.io/argo-helm
    - name: infisical-helm-charts
      url: https://dl.cloudsmith.io/public/infisical/helm-charts/helm/charts/
    - name: crossplane-stable
      url: https://charts.crossplane.io/stable
    - name: mittwald
      url: https://helm.mittwald.de
    - name: authelia
      url: https://charts.authelia.com
    - name: harbor
      url: https://helm.goharbor.io
    - name: dragonfly
      url: https://dragonflyoss.github.io/helm-charts
    '';
  }; # helm config ending
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
