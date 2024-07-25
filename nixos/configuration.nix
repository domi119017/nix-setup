# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


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


  ##
  # ...
  ##
  networking.hostName = "delta-surface"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "de_DE.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "de";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;
  environment.gnome.excludePackages = with pkgs; [ 
    gedit
    gnome.geary
    gnome.epiphany
    gnome.totem
    gnome.yelp
    gnome.evince
    gnome.seahorse
    gnome-tour
  ];

  # All possible excludes:
  # environment.gnome.excludePackages = with pkgs.gnome; [
  #   baobab      # disk usage analyzer
  #   cheese      # photo booth
  #   eog         # image viewer
  #   epiphany    # web browser
  #   gedit       # text editor
  #   simple-scan # document scanner
  #   totem       # video player
  #   yelp        # help viewer
  #   evince      # document viewer
  #   file-roller # archive manager
  #   geary       # email client
  #   seahorse    # password manager

  #   # these should be self explanatory
  #   gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
  #   gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-photos gnome-screenshot
  #   gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  # ];


  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  #  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      vscode
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz2K48kEMofcyCnG7eNPacgZ2abxtMKUfPVY19lvCpxNnMCibKSv/IirLukw1YJ/EZC3Z5RizjM+AdHXWuTnaD2VZ0DiHbJwsCfE1M14bj/SMOzv99N4dKefMrO3jCDNcSy+3kBYJBOHhvfujv3nF80uOj64zhXPXDgqSnFc2mfUgnXWR6Q5D3cOirVPytocP41iCjST2DQnlJrC/dy05hfX59H6jxlUcRIdEzdmomrCQG2VphBOHmUuwjocaXJ8Iu+/1JRznfFfkKr6hUluNdffDkSZc3EiPPzkXOo7I+9XcMvzZDAAdyKe5KZzgkCutcwE+t4LWACbMAz9pIbPK1RLpR8f8S0gW9bqK+shNCCTak0t47FtRZGYYTK/QW3pVe5GwQs6jZLF67fcVCcuXMvPvSLrsi9KqZbSP2dU8QMZD2/PcOYt17TpXBt7zr/62eVgCFcQL2P/CNzUmfsF1tyYEqqClgVBoz4TYILPCgEcLvgwKARB/cwbaokPAiisM= domi@Domi-PC"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    firefox
    tree
    home-manager
    zsh
    zsh-powerlevel10k
    gnome3.gnome-tweaks
    obsidian
  ];
  programs.zsh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
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

