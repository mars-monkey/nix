# Help is available in the configuration.nix(5) man page.
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
    enableAllFirmware = true;
    pulseaudio.enable = false;
    
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };
  
  powerManagement = {
    enable = true;
    scsiLinkPolicy = "med_power_with_dipm";
  };
  
  system = {
    stateVersion = "23.05";
    
/*    autoUpgrade = {
      enable = false;
      allowReboot = false;
      operation = "boot";
      dates = "daily";
      persistent = false;
    };*/
  };
  
  console = {
    font = "ter-v24b";
    keyMap = "us";
  };
  
  nix = {
    optimise = {
      automatic = true;
      dates = ["17:10"];
    };

    gc = {
      automatic = true;
      persistent = true;
      dates = "17:10";
      options = "--delete-older-than 3d";
    };

    settings = {
      trusted-users = [ "mars-monkey" ];
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
        linuxPackages = in_pkgs.linuxPackages_6_1;
      };
    };
  };
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Vancouver";
  
  fonts.packages = with pkgs; [
    noto-fonts
    liberation_ttf
    corefonts
    merriweather
  ];
  
  networking = {
    hostName = "mars-monkey-machine";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.3" "1.0.0.3" ];
    
    firewall = {
      enable = false;
      logRefusedConnections = true;
    };
  };
  
  programs = {
    system-config-printer.enable = true;
    virt-manager.enable = true;

    adb.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zulu17
      ];
    };
  };
  
  services = {
    flatpak.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    ipp-usb.enable = true;
    locate.enable = true;
    netbird.enable = true;
    printing.enable = true;
    thermald.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    gnome = {
      gnome-keyring.enable = true;
      core-utilities.enable = false;
    };
    
    xserver = {
      enable = true;
      xkb.layout = "us";
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
  
  zramSwap = {
    enable = true;
    memoryMax = 12000000000;
  };

  virtualisation = {
    podman.enable = true;
    libvirtd.enable = true;
  };
   
  environment = {
    systemPackages = with pkgs; [
      cifs-utils
      git
      home-manager
      hplip
      nh
      terminus_font
      vim
      zfs
    ];

    gnome.excludePackages = with pkgs; [
      gnome-tour
    ];
  };
    
  users = {
    mutableUsers = false;
    
    users.mars-monkey = {
      isNormalUser = true;
      description = "Mars Monkey";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "scanner" "lp" "adbusers"];
      hashedPasswordFile = "/etc/passwordFile";
      
      packages = with pkgs; [
     ];
    };
  };    
}
