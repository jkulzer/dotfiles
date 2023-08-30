# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    configurationLimit = 25;
  };

  # Enables the usual predictable behaviour of the /tmp directory
  boot.tmp.cleanOnBoot = true;

  # Enables NTFS support (allows mounting of Windows disks)
  boot.supportedFilesystems = [ "ntfs" ];

  fonts.packages = with pkgs; [
  # Good default font
  noto-fonts
  # Cool looking mondern font
  roboto
  # Needed for a lot icons
  fira-code
  fira-code-symbols
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

      # Terminal stuff
      kitty # The terminal of choice
      # Fetch programs
      neofetch
      hyfetch
      blahaj
      uwufetch
      onefetch # Like neofetch, but for git repos

      # Organization
      obsidian # Knowledge manager

      # Communication
      discord
      element-desktop # Matrix client

      # Sway stuff
      swaybg
      autotiling

      # Coding
      gh # Github CLI, makes the git login easier
      # Golang
      go
      # Rust
      cargo

      # LSPs
      gopls # Golang
      rust-analyzer # Rust

      # Kubernetes stuff
      kubectl
      kustomize
      kubernetes-helm
      talosctl

      # Media controls
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

    # terminal multiplexer (useful when having to debug from tty)
    tmux

    # fzf (fuzzy finder) (dependency for fzf zsh plugin)
    fzf

    # Coding
    cargo # Rust

  ];
  
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
      init = {
        defaultBranch = "main";
      };
    }; # config closed
  };

  # Sets default shell to ZSH
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    # Disables the startup wizard
    shellInit = "zsh-newuser-install() { :; }";
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
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

