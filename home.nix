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
