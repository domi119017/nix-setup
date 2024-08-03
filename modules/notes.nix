{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Notes #
    plantuml
    texliveFull 
    obsidian
  ];
}