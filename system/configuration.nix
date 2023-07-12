# hi Help is available in the configuration.nix(5) man page.
# Edit hardware-configuration.nix as well
 
{ config, lib, modulesPath, pkgs, ... }:
 
{
  imports = [  ];
  
  boot = {
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
    kernelModules = [ "kvm-intel" ];
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {    
    pulseaudio.enable = false;
    
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
      ];
    };
  };
  
  powerManagement = {
    enable = true;
    scsiLinkPolicy = "med_power_with_dipm";
  };
  
  system = {
    stateVersion = "23.05";
    
    autoUpgrade = {
      enable = false;
      allowReboot = false;
      operation = "boot";
      dates = "daily";
      persistent = false;
    };
  };
  
  console = {
    font = "ter-v24b";
    keyMap = "us";
  };
  
  nix = {
    gc = {
      automatic = true;
      persistent = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };

    settings = {
      auto-optimise-store = true;
      
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  
    config = {
      allowUnfree = true;
           
      packageOverrides = in_pkgs : {
        linuxPackages = in_pkgs.linuxPackages_latest;
      };
    };
  };
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Africa/Douala";

  networking = {
    hostName = "mars-monkey-machine";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.3, 1.0.0.3" ];
    
    firewall = {
      enable = true;
      logRefusedConnections = true;
    };
  };

  services = {
    fwupd.enable = true;
    thermald.enable = true;
    locate.enable = true;
    printing.enable = true;
    flatpak.enable = true;
    gvfs.enable = true;
    
    gnome = {
      gnome-keyring.enable = true;
      core-utilities.enable = false;
    };
    
    xserver = {
      enable = true;
      layout = "us";
      # libinput.enable = true;
      excludePackages = [ pkgs.xterm ];
      
      desktopManager = {
        gnome.enable = true;
        xterm.enable = false;
      };

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  
  environment = {

    systemPackages = [
      
    ];

    gnome.excludePackages = with pkgs; [
      gnome-tour
    ];
  };
  
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  
  users = {
    mutableUsers = false;
    
    users.mars-monkey = {
      isNormalUser = true;
      description = "Mars Monkey";
      extraGroups = [ "wheel" "networkmanager" ];
      passwordFile = "/etc/passwordFile";
      
      packages = with pkgs; [
        home-manager
     ];
    };
  };    
}
