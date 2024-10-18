{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Coding --- #
    # General
    gnumake
    # Python
    python3
    pipx
    virtualenv
    # C/C++
    gcc
    libgcc
    gdb
    # Rust
    rustup
    # - Graphical - #
    openscad
    vscode
    ghidra
    # Gamedev
    aseprite
    godot_4
    blender
  ];
}