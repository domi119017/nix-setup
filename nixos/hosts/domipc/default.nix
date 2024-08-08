# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common.nix
      # ../../modules/coding.nix
      ../../modules/gnome.nix
      ../../modules/openssh.nix
      ../../modules/syncthing.nix
      ../../modules/tty.nix
      ../../modules/gaming.nix
      # ../../modules/notes.nix

      # Sops
      # inputs.sops-nix.nixosModules.sops
    ];

  # sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  # sops.defaultSopsFormat = "yaml";

  # sops.age.keyFile = "/home/delta/.config/sops/age/keys.txt";

  # sops.secrets = {
  #   ssh_key = {};
  #   delta_passwd = {};
  #   admin_passwd = {};
  #   hawking_st_id = {};
  #   st_passwd = {};
  #   st_username = {};
  # };

  # sops.templates = {
    # "ssh_key".content = ''${config.sops.placeholder.ssh_key}'';
    # "hawking_st_id".content = ''${config.sops.placeholder.hawking_st_id}'';
    # "st_passwd".content = ''${config.sops.placeholder.st_passwd}'';
    # "st_username".content = ''${config.sops.placeholder.st_username}'';
  # };

  hardware.opengl = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "domipc"; # Define your hostname.

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # - Microsoft surface - #
    # pulseaudio
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITQESNC4zlSNaAVfwELko0C4pfsEHgMzS9m0NqEyPeY delta@surfacego2"
    ];
  };

  system.stateVersion = "24.05"; 
}

