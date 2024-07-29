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
    libgcc
    gdb
    # Rust
    rustup
  ];
}