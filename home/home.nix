{ config, pkgs, lib, ... }:

{  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "23.05";
    
    shellAliases = {
      
      cl = "clear";
      gp = "git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      hcf = "vim ~/nix/home/home.nix";
      hrb = "home-manager switch --flake ~/nix/home#mars-monkey && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      hup = "nix flake update ~/nix/home";
      int = "ping -c 5 1.1.1.1";
      l = "ls -ahl --color=auto";
      pi = "ssh dietpi@192.168.100.5";
      pib = "ssh dietpi@192.168.100.5 -t ./start.sh";
      rm = "trash";
      scf = "sudo vim ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C push";
      sup = "nix flake update ~/nix/system";
      ts = "nix-shell -p";
    };
   
    sessionVariables = {
      EDITOR = "vim";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    packages = with pkgs; [
      andika
      android-tools
      audacity
      apostrophe
      baobab
      bitwarden
      bibletime
      blackbox-terminal
      bottles      
      brave
      krita
      btrbk
      calibre
      celeste
      chatterino2
      cinnamon.nemo
      clapper
      corefonts
      denaro
      dialect
      distrobox
      drawing
      eartag
      electron-mail
      epiphany
      evince
      eza
      ferdium
      firehol
      gaphor
      gcolor3
      geogebra6
      gh
      gimp
      git
      gitg
      gnome-connections
      gnome-obfuscate
      gnome-secrets
      gnome-solanum
      gnome-text-editor
      gnome.dconf-editor
      gnome.eog
      gnome.gnome-calculator
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-disk-utility
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
      gnome.totem
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.pop-shell
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.supergfxctl-gex
      gnomeExtensions.vitals
      go
      gparted
      guake
      hugo
      intel-gpu-tools
      inter
      iotas
      iperf3
      jellyfin-web
      jitsi
      keepassxc
      kodi-wayland
      leaf
      librewolf
      libreoffice
      libva-utils
      lunar-client
      mangohud
      motrix
      mprocs
      neofetch
      newsflash
      nextcloud-client
      nix-index
      nixos-generators
      nushell
      ntfs3g
      obs-studio
      onlyoffice-bin
      pciutils
      pika-backup
      pitivi
      plocate
      pfetch-rs
      prismlauncher
      protonvpn-gui
      rpi-imager
      snapshot
      speedtest-cli
      speedtest-cli
      starship
      tealdeer
      trash-cli
      usbutils
      ventoy-full
      vim
      virtualbox
      vlc
      webcord
      whatip
      youtube-dl
      zellij
      zoom
      zsh
      zsh-autosuggestions
    ];
  };
  
  programs = {
    home-manager.enable = true;
    zsh.enable = true;
    bash.enable = true;    

    git = {
      enable = true;
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
