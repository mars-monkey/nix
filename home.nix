{ config, pkgs, ... }:

{
  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "23.05";
    
    shellAliases = {
      ll = "ls -la";
      scf = "sudo nano ~/nix/system/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix/system#mars-monkey-machine";
      srbb = "sudo nixos-rebuild boot --flake ~/nix/system#mars-monkey-machine";
      hcf = "nano ~/nix/home/home.nix";
      hrb = "home-manager switch --flake ~/nix/home#mars-monkey";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      GTK_THEME = "adw-gtk3";
    };
    
    packages = with pkgs; [
      blackbox-terminal
      librewolf
      gh
      git
      gnome.eog
      gnome.nautilus
      gnome-text-editor
      plocate
    ];
  };
    
  programs = {
    home-manager.enable = true;
    bash.enable = true;
  };

  gtk = {
    enable = true;
    
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
