{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # - Terminal - #
    tree
    zoxide
    bat
    thefuck
  ];

  fonts.packages = with pkgs; [
    # Jet Brains Mono NF
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}