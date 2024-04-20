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
    pulseaudio.enable = false;
    
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    opengl = {
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
  time.timeZone = "Africa/Douala";
  
  fonts.packages = with pkgs; [
    noto-fonts
    liberation_ttf
    corefonts
    nerdfonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  networking = {
    hostName = "mars-monkey-machine";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.3, 1.0.0.3" ];
    
    firewall = {
      enable = false;
      logRefusedConnections = true;
    };
  };
  
  programs = {
    virt-manager.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zulu17
      ];
    };
  };
  
  services = {
    fwupd.enable = true;
    thermald.enable = true;
    locate.enable = true;
    printing.enable = true;
    flatpak.enable = true;
    gvfs.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
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
  
  virtualisation = {
    podman.enable = true;
    libvirtd.enable = true;
  };
   
  environment = {
    systemPackages = with pkgs; [
      git
      home-manager
      hplip
      terminus_font
      cifs-utils
      ventoy-full
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
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      hashedPasswordFile = "/etc/passwordFile";
      
      packages = with pkgs; [
     ];
    };
  };    
}
