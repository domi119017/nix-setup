# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.sops-nix.nixosModules.sops
      ../../../modules/common.nix
      ../../../modules/coding.nix
      ../../../modules/gnome.nix
      ../../../modules/openssh.nix
      ../../../modules/syncthing.nix
      ../../../modules/tty.nix
      ../../../modules/waydroid.nix
    ];

  # sops.defaultSopsFile = ../secrets/secrets.yaml;
  # sops.defaultSopsFormat = "yaml";
# 
  # sops.age.keyFile = "/home/delta/.config/sops/age/keys.txt";
# 
  # sops.secrets = {
    # ssh_key = {};
    # delta_passwd = {};
    # admin_passwd = {};
    # hawking_st_id = {};
    # st_passwd = {};
    # st_username = {};
  # };
# 
  # sops.templates = {
    # "ssh_key".content = ''${config.sops.placeholder.ssh_key}'';
    # "hawking_st_id".content = ''${config.sops.placeholder.hawking_st_id}'';
    # "st_passwd".content = ''${config.sops.placeholder.st_passwd}'';
    # "st_username".content = ''${config.sops.placeholder.st_username}'';
  # };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # luks
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/6c83772c-4904-42f7-951b-449f6068befb";
      preLVM = true;
    };
  };

  networking.hostName = "surfacego2"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # - Microsoft surface - #
    surface-control
    libinput
  ];

}

