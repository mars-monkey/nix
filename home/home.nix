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
      hcf = "vim ~/nix/home/home.nix";
      hrb = "home-manager switch --flake ~/nix/home#mars-monkey && ~/nix/home/gp.sh";
      hup = "nix flake update ~/nix/home";
      int = "ping -c 5 1.1.1.1";
      l = "ls -ahl --color=auto";
      pi = "ssh casa@192.168.100.102";
      scf = "sudo vim ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine && ~/nix/home/gp.sh";
      sup = "nix flake update ~/nix/system";
    };
    
    sessionVariables = {
      EDITOR = "vim";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    packages = with pkgs; [
      cinnamon.nemo
      vim
      speedtest-cli
      usbutils
      pciutils
      calibre
      tealdeer
      blackbox-terminal
      zsh
      zsh-autosuggestions
      guake
      webcord
      electron-mail
      jitsi
      zoom
      chatterino2
      libreoffice
      onlyoffice-bin
      gnome-text-editor
      bitwarden
      denaro
      celeste
      kodi-wayland
      jellyfin-web
      pika-backup
      protonvpn-gui
      nextcloud-client
      newsflash
      audacity
      pitivi
      gimp
      gnome.gnome-calculator
      gnome.gnome-system-monitor
      gnome.gnome-sound-recorder
      gnome-obfuscate
      baobab
      whatip
      gnome-solanum
      eartag
      evince
      gcolor3
      clapper
      gnome.eog
      gnome.gnome-power-manager
      textpieces
      dialect
      iotas
      drawing
      ventoy-full
      vlc
      virtualbox
      gnome.gnome-clocks
      gnome.gnome-disk-utility
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-characters
      gnome.nautilus
      gnome.simple-scan
      gnome-connections
      gnome-secrets
      gnome.gnome-font-viewer
      obs-studio
      gaphor
      geogebra
      gparted
      rpi-imager
      gnome.dconf-editor
      gnome.gnome-tweaks
      librewolf
      brave
      epiphany
      ferdium
      bottles      
      prismlauncher
      mangohud
      lunar-client
      gnome.gnome-mines
      gnome.gnome-sudoku
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
      ntfs3g
      firehol
      intel-gpu-tools
      libva-utils
      andika
      gnomeExtensions.supergfxctl-gex
      gnomeExtensions.pop-shell
      gnomeExtensions.vitals
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
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
