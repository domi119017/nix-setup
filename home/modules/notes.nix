{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # - Graphical - #
    openscad
    # Notes #
    plantuml
    texliveFull 
    obsidian
  ];
}