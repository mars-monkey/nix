# Help is available in the configuration.nix(5) man page.
# Edit hardware-configuration.nix as well
 
{ config, lib, modulesPath, pkgs, ... }:
 
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  
  boot = {
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
    kernelModules = [ "kvm-intel" ];
    
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "sr_mod"
      "virtio_blk"
    ];
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
    };
    
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
  
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    
    pulseaudio.enable = false;
    
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
  
  powerManagement = {
    enable = true;
    scsiLinkPolicy = "med_power_with_dipm";
    cpuFreqGovernor = "performance"
  };
  
  system = {
    stateVersion = "23.05";
    
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      operation = "boot";
      dates = "daily";
      persistent = false;
    };
  };
  
  console = {
    font = "ter-v24n";
    keyMap = "us";
  };
  
  nix = {
    gc = {
      automatic = true;
      persistent = true;
      dates = "19:10";
      options = "--delete-older-than 3d";
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
    hostName = "nixos-vm";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
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
    flatpak.enable = true;
    printing.enable = true;
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
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-extension-manager
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
      hashedPassword = "$y$j9T$mzN.ugmqwGhjw/Lfzb0fC/$lS0GEu7Ect6/aCyCmrO7wo6RBnHRxPJkS4bqhTXjKI6";
    };
  };    
}
