# /////////////////////////
# //                     //
# //  Nix Configuration  //
# //                     //
# //   System Settings   //
# //                     //
# /////////////////////////

{ config, lib, pkgs, ... }:


{

  # // Imports //
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/core/network.nix
      ../../modules/core/nvidia.nix
      ../../modules/core/pipewire.nix
      ../../modules/core/virtualisation.nix
    ];


  # // Bootloader //
  boot.loader = {
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      efiInstallAsRemovable = true;
    };
  };


  # // Linux kernel //
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # // Timezone //
  time.timeZone = "Europe/Moscow";

  # // Services //
  services = {

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      windowManager.i3.enable = true;
      displayManager.startx.enable = true;

      # / Keyboard Settings (X11) / 
      xkb.layout = "us,ru";
      xkb.variant = "";
      xkb.options = "grp:win_space_toggle";


    };
    
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '{${config.programs.niri.package}/bin/niri-session}'";
          user = "greeter";
        };
      };
    };

    gvfs.enable = true;
    udisks2.enable = true;

  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      niri = {
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  # / Double Suspend fix /
  # systemd.services.systemd-suspend = {
  #   environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  # };

  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];


  # // Hardware Settings //
  hardware = {

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
        libvdpau
      ];
    };
  };

  # // Nix Settings //
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


  # // Users //
  users.users.theanontrarrr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "libvirtd" "kvm" ];
    packages = with pkgs; [
      tree
    ];
  };

  users.users.lfs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "lfs" ];
    home = "/home/lfs";
  };

  # // Programs //
  programs = {
    
    kitty.enable = true;

    firefox.enable = true;

    steam = {
      enable = true;
      extraPackages = with pkgs; [
        fontconfig
        freetype
        libva
        libvdpau
      ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    dconf.enable = true;
    niri.enable = true;
    virt-manager.enable = true;

    kitty = {
      enable = true;
      settings = { paste_actions = "no-op"; };
    };

  };


  # // System Packages //
  environment.systemPackages = with pkgs; [

    vim
    wget
    pkgs.amnezia-vpn
    heroic
    gnupg
    mangohud
    htop
    fastfetch
    feh
    picom
    tint2
    rofi
    obconf
    lxappearance

    # // LFS Requirements //
    coreutils
    bash
    binutils
    bison
    diffutils
    findutils
    gawk
    gcc
    gpp
    gnugrep
    gzip
    m4
    gnumake
    patch
    perl
    python3
    gnused
    gnutar
    texinfo
    xz

    (heroic.override {
      extraPkgs = pkgs: with pkgs; [
        gamescope
        gamemode
        mangohud
        gnupg
        vulkan-loader
        vulkan-tools
        libkrb5
      ];
    })

  ];


  # // NixOS Version (DO NOT CHANGE!) //
  system.stateVersion = "25.11";

}

