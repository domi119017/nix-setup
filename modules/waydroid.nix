{ config, lib, pkgs, inputs, ... }:

{
  # Waydroid
  virtualisation.waydroid.enable = true;
  virtualisation.lxc.enable = true;
}