{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Gamedev
    aseprite
    godot_4
    blender
  ];
}