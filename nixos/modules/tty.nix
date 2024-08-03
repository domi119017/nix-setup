{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # - Terminal - #
    tree
    zoxide
    bat
    thefuck
    fzf
  ];
}