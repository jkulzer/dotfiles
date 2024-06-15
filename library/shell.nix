{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    curl
    wget
    dig
    htop
    openssl
    fzf
    fzf-zsh
    nmap
    traceroute
    bat

    neofetch
    onefetch

    neovim

    alejandra # nix formatter
    gh # GitHub CLI
  ];

  programs.zsh = {
    enable = true;
    # Disables the startup wizard
    shellInit = ''
      zsh-newuser-install() { :; }
    '';
    shellAliases = {
      k = "kubectl";
    };
    # Increases the hist size
    histSize = 25000;
    # Useful syntax stuff
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "fzf"
        "kubectl"
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };
}
