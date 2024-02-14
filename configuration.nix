# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ pkgs, ... }:
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-25.9.0"
  # ];

  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./bootloader.nix
  ];

  fonts.packages = with pkgs; [
    # Good default font
    noto-fonts
    # Cool looking mondern font
    roboto
    # Needed for a lot icons
    fira-code
    fira-code-symbols
    nerdfonts
    emojione # Open Source Emoji font
  ];

  networking.hostName = "desktop"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Needed for Hyprland (may be obsolete for sway)
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  security.polkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johannes= {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # The best browser
      firefox

      # Utilities
      syncthing # File synchronization software
      libsForQt5.ark # KDE Unzipping tool

      # Terminal stuff

      kitty # The terminal of choice

      # Other tools
      bat

      # Fetch programs
      neofetch
      hyfetch
      blahaj
      uwufetch
      onefetch # Like neofetch, but for git repos
      # Other fun programs
      gay # Like lolcat, but gay

      # Organization
      obsidian # Knowledge manager

      # Communication
      discord
      element-desktop # Matrix client
      vesktop

      # Sway stuff
      swaybg
      autotiling
      wl-clipboard # Can copy to clipboard from the CLI

      # Coding

      # Generic Tools
      gh # Github CLI, makes the git login easier
      gnumake # Needed for operator-sdk (and generally a useful tool)

      # Golang
      go
      operator-sdk # Tool for writing Kubernetes Operators in Golang

      # Rust
      cargo

      # Python
      python3

      # LSPs
      gopls # Golang
      rust-analyzer # Rust

      # Kubernetes stuff
      kubectl
      kustomize
      kubernetes-helm
      talosctl
      kube-capacity # Shows how much resources are allocated by the cpu/memory requests/limits
      
      # Other IAC stuff
      terraform # Should be replaced with opentofu when it gets it first release

      # Networking
      winbox # router configuration software from Mikrotik
      traceroute

      # Media stuff
      mpv
      playerctl
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System Tools
    curl
    wget
    dig # DNS lookup
    htop # like task manager
    openssl # THE cryptographic library

    # terminal multiplexer (useful when having to debug from tty)
    tmux

    # fzf (fuzzy finder) (dependency for fzf zsh plugin)
    fzf

    # Coding
    cargo # Rust

    # just nmap
    nmap

    # audio
    alsa-utils
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Docker
  virtualisation.docker.enable = true;
  
  # A display/login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --width 60 --cmd sway --greeting 'Access restricted to authorized users'";
      };
    };
  };
  # Fixes this bug: https://github.com/apognu/tuigreet/issues/68
  # Found here: https://github.com/apognu/tuigreet/issues/68#issuecomment-1586359960
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Needed for Swaylock to work correctly
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "jkulzer";
        email = "git@jkulzer.dev";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = false;
    }; # config closed
  };

  # Sets default shell to ZSH
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ssh = "kitty +kitten ssh -i ~/.ssh/id_rsa";
    };
    # Disables the startup wizard
    shellInit = "zsh-newuser-install() { :; }";
    # Increases the hist size
    histSize = 25000;
    # Useful syntax stuff
    autosuggestions.enable = true;
    enableCompletion = true;
    # Enables syntax highlighting
    syntaxHighlighting = {
      enable = true;
    };
    # ZSH Plugin system
    ohMyZsh = {
      enable = true;
      plugins = [ 
        "kubectl" # Shortens kubectl to k and has other useful aliases
        "vi-mode" # Enables editing of commands with vim commands (activate normal mode with esc)
        "fzf" # Fuzzy finder
      ];
    };
  };

  # Configures a cool prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  }; 


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  # Open ports in firewall
  networking.firewall.allowedTCPPorts = [ 
    22000 # Syncthing
    5173 # Svelte Dev
  ];
  networking.firewall.allowedUDPPorts = [ 
    22000 # Syncthing
    21027 # Syncthing
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.tailscale.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
