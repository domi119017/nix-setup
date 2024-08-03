{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # - Graphical - #
    openscad
    # Notes #
    plantuml
    texliveFull 
    obsidian
  ];
}