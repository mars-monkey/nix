{ config, pkgs, lib, ... }:

{  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "23.05";
    
    shellAliases = {
      
      cl = "clear";
      gp = "~/nix/home/gp.sh";
      hcf = "nano ~/nix/home/home.nix";
      hrb = "home-manager switch --flake ~/nix/home#mars-monkey && ~/nix/home/gp.sh";
      hup = "nix flake update ~/nix/home";
      l = "ls -ahl --color=auto";
      scf = "sudo nano ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      sup = "nix flake update ~/nix/system";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORMTHEME = "gnome";
    };
    
    packages = with pkgs; [
      #### GUI ####

      # Shell/terminal
      blackbox-terminal
      zsh
      zsh-autosuggestions
      guake
      # Communication
      webcord
      electron-mail
      jitsi
      zoom
      chatterino2
      # Word Processing
      libreoffice
      onlyoffice-bin # For improved compatibility over libreoffice
      gnome-text-editor
      # Services
      bitwarden
      denaro
      celeste
      kodi-wayland
      jellyfin-web
      pika-backup
      protonvpn-gui
      nextcloud-client
      newsflash # RSS feed reader
      # File editors
      audacity
      pitivi # Video editor
      gimp
      # Utilities
      gnome.gnome-calculator
      gnome.gnome-system-monitor
      gnome.gnome-sound-recorder
      gnome-obfuscate
      baobab # Disk usage analyzer
      whatip
      gnome-solanum # Pomodoro timer
      eartag # File tag editor
      evince # Document viewer
      gcolor3 # Color picker
      clapper # Video viewer
      gnome.eog # Photo viewer
      gnome.gnome-power-manager # Battery stats
      textpieces # Manipulate text without random websites
      dialect # Translate app
      iotas # MD notes app
      drawing
      ventoy-full
      vlc
      virtualbox
      gnome.gnome-clocks
      gnome.gnome-disk-utility
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-characters # Emojis and other chars
      gnome.nautilus
      gnome.simple-scan
      gnome-connections
      gnome-secrets
      gnome.gnome-font-viewer
      obs-studio
      gaphor
      geogebra
      # Partition tools
      gparted
      rpi-imager
      # Settings
      gnome.dconf-editor
      gnome.gnome-tweaks
      # Web browsers
      librewolf
      brave
      epiphany
      ferdium
      # Hypervisors
      bottles      
      # Games
      prismlauncher
      mangohud # System usage stats
      lunar-client
      gnome.gnome-mines
      gnome.gnome-sudoku
      #### Theming ####
      adwaita-qt6
      adwaita-qt
      qgnomeplatform
      qgnomeplatform-qt6
      gradience
      #### CLI ####
      android-tools
      speedtest-cli
      nixos-generators
      nix-index
      gh
      git
      gitg
      youtube-tui
      btrbk
      plocate
      neofetch
      tldr
      #### Libraries/Drivers ####
      ntfs3g
      firehol
      # GPU stuff
      intel-gpu-tools
      libva-utils
      # Fonts
      andika
      # Gnome Extensions
      gnomeExtensions.supergfxctl-gex
      gnomeExtensions.pop-shell
      gnomeExtensions.vitals
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      #gnomeExtensions.ddterm
      # ddterm dependencies
      #gjs
      #vte
    ];
  };
  
  programs = {
    home-manager.enable = true;
    zsh.enable = true;
    bash.enable = true;    

    git = {
      enable = true;
      userEmail = "91227993+mars-monkey@users.noreply.github.com";
      userName = "mars-monkey";
    };
    
    mangohud = {
      enable = true;
      enableSessionWide = true;
    };
  };
  
  # requires reboot to set gtk stuff lol
  gtk = {
    enable = true;
    
    theme = {
      name = "Adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = "0";
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = "0";
    };
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = lib.mkForce "adw-gtk3-dark";
    };
    
    # Extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      
      enabled-extensions = [
        "pop-shell@system76.com"
        "AlphabeticalAppGrid@stuarthayhurst"
        "Vitals@CoreCoding.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
      ];
      
      disabled-extensions = [];
    };
  };
}
