{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # - Graphical - #
    openscad
    # Notes #
    plantuml
    texliveFull # Download is really slow, disable for now. todo: enable later to install overnight
    obsidian
  ];
}