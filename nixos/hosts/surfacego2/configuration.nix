# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.sops-nix.nixosModules.sops
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
  # Enable GNOME shell extensions management from Firefox.
  # nixpkgs.config.firefox.enableGnomeExtensions = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

