{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Gaming --- #
    steam
	discord
  ];
}