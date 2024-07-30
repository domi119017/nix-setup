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
      ../../../modules/gui.nix
      ../../../modules/waydroid.nix

      # Sops
      inputs.sops-nix.nixosModules.sops
    ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
# 
  sops.age.keyFile = "/home/delta/.config/sops/age/keys.txt";
# 
  sops.secrets = {
    ssh_key = {};
    delta_passwd = {};
    admin_passwd = {};
    hawking_st_id = {};
    st_passwd = {};
    st_username = {};
  };
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
    libcamera
    pulseaudio
  ];

  # Enable sound.
  # Enable EITHER:
  # hardware.pulseaudio.enable = true;
  # OR:
  services.pipewire = {
    enable = true;
    pulse.enable = false;
    wireplumber.enable = true;
  };

    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz2K48kEMofcyCnG7eNPacgZ2abxtMKUfPVY19lvCpxNnMCibKSv/IirLukw1YJ/EZC3Z5RizjM+AdHXWuTnaD2VZ0DiHbJwsCfE1M14bj/SMOzv99N4dKefMrO3jCDNcSy+3kBYJBOHhvfujv3nF80uOj64zhXPXDgqSnFc2mfUgnXWR6Q5D3cOirVPytocP41iCjST2DQnlJrC/dy05hfX59H6jxlUcRIdEzdmomrCQG2VphBOHmUuwjocaXJ8Iu+/1JRznfFfkKr6hUluNdffDkSZc3EiPPzkXOo7I+9XcMvzZDAAdyKe5KZzgkCutcwE+t4LWACbMAz9pIbPK1RLpR8f8S0gW9bqK+shNCCTak0t47FtRZGYYTK/QW3pVe5GwQs6jZLF67fcVCcuXMvPvSLrsi9KqZbSP2dU8QMZD2/PcOYt17TpXBt7zr/62eVgCFcQL2P/CNzUmfsF1tyYEqqClgVBoz4TYILPCgEcLvgwKARB/cwbaokPAiisM= domi@Domi-PC"
    ];
  };

  system.stateVersion = "24.05"; 
}

