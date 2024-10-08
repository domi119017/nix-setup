{ config, lib, pkgs, inputs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;
  # Browser connector
  services.gnome.gnome-browser-connector.enable = true;

  # Exclude some junk
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

  environment.systemPackages = with pkgs; [
    # - Gnome - #
    gnome3.gnome-tweaks
    gnome-browser-connector
  ];


  fonts.packages = with pkgs; [
    # Jet Brains Mono NF
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.firefox.enable = true;
}