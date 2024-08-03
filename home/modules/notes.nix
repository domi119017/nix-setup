{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Notes #
    plantuml
    texliveFull 
    obsidian
  ];
}