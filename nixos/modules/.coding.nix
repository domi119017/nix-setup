{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
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
  ];
}