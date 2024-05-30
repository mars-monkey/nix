{ config, pkgs, lib, ... }:

{  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "23.05";
    
    shellAliases = {
      apt = "nala";
      cd = "Use zoxide";
      cl = "clear";
      gp = "git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      hcf = "vim ~/nix/home/home.nix";
      hrb = "home-manager switch --flake ~/nix/home#mars-monkey && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      hup = "nix flake update ~/nix/home";
      int = "ping -c 5 1.1.1.1";
      ls = "eza --oneline --all --sort=modified --icons --git --group-directories-first";
      ll = "eza --oneline --all --sort=modified --icons --git --header --long --group-directories-first";
      l = "eza --oneline --all --sort=modified --icons --git --header --long --group-directories-first";
      pi = "ssh dietpi@192.168.100.5";
      pib = "ssh dietpi@192.168.100.5 -t ./start.sh";
      rm = "trash";
      scf = "sudo vim ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      sup = "nix flake update ~/nix/system";
      ts = "nix run nixpkgs#";
    };
   
    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    packages = with pkgs; [
      andika
      android-tools
      audacity
      baobab
      bat
      bitwarden
      brave
      btop
      calibre
      cargo
      chromium
      clapper
      cmatrix
      corefonts
      cowsay
      denaro
      distrobox
      drawing
      eartag
      easyeffects
      evince
      eza
      fastfetch
      fd
      ferdium
      figlet
      foliate
      gcolor3
      geogebra6
      gh
      gimp
      git
      gnome-connections
      gnome-console
      gnome-obfuscate
      gnome-solanum
      gnome-text-editor
      gnome.dconf-editor
      gnome.eog
      gnome.gnome-calculator
      gnome.gnome-characters
      gnome.gnome-chess
      gnome.gnome-clocks
      gnome.gnome-disk-utility
      gnome.gnome-font-viewer
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-mines
      gnome.gnome-music
      gnome.gnome-power-manager
      gnome.gnome-sound-recorder
      gnome.gnome-sudoku
      gnome.gnome-system-monitor
      gnome.gnome-terminal
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
      hugo
      hw-probe
      inkscape
      intel-gpu-tools
      inter
      iotas
      iperf3
      kdenlive
      keepassxc
      kitty
      lf
      libreoffice
      librewolf
      libva-utils
      localsend
      lolcat
      loupe
      lunar-client
      neofetch
      neovim
      nixos-generators
      nmap
      ntfs3g
      obs-studio
      obsidian
      onlyoffice-bin
      pciutils
      pfetch-rs
      pika-backup
      plocate
      ponysay
      prismlauncher
      protonvpn-gui
      publii
      ripgrep
      rpi-imager
      rustc
      skim
      superTuxKart
      sl
      smbnetfs
      snapshot
      tealdeer
      trash-cli
      tree
      usbutils
      ventoy-full
      vim
      vlc
      webcord
      wget
      whatip
      xfce.thunar
      zola
      zoxide
      zulu17
    ];
  };
  
  programs = {
    home-manager.enable = true;
    bash.enable = true;    
    zoxide.enable = true;

    git = {
      enable = true;
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
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

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
