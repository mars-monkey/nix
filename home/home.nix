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
      scf = "sudo nano ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      sup = "nix flake update ~/nix/system";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    packages = with pkgs; [
      amberol
      andika
      audacity
      baobab
      bitwarden
      blackbox-terminal
      bottles
      brave
      btrbk
      celeste
      chatterino2
      clapper
      denaro
      dialect
      drawing
      eartag
      electron-mail
      epiphany
      evince
      ferdium
      gaphor
      geogebra
      gcolor3
      gh
      git
      gitg
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.pop-shell
      gnomeExtensions.vitals
      gnome.dconf-editor
      gnome.gnome-calculator
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-color-manager
      gnome.eog
      gnome.gnome-font-viewer
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-mines
      gnome.gnome-power-manager
      gnome.gnome-sound-recorder
      gnome.gnome-sudoku
      gnome.gnome-system-monitor
      gnome.gnome-tweaks
      gnome.nautilus
      gnome.simple-scan
      gnome-connections
      gnome-obfuscate
      gnome-solanum
      gnome-text-editor
      gparted
      gradience
      guake
      intel-gpu-tools
      iotas
      jellyfin-web
      jitsi
      kodi-wayland
      libreoffice
      librewolf
      libva-utils
      lunar-client
      mangohud
      neofetch
      newsflash
      nextcloud-client
      nixos-generators
      obs-studio
      onlyoffice-bin
      pika-backup
      pitivi
      plocate
      prismlauncher
      protonvpn-gui
      rpi-imager
      textpieces
      tldr
      vlc
      webcord
      whatip
      youtube-tui
      zoom
    ];
  };
  
  programs = {
    home-manager.enable = true;
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
