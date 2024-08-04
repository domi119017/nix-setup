{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Include gnome stuff
    ./modules/gnome.nix
    ./modules/gaming.nix
  ];

  # USER
  home.username = "yannic";
  home.homeDirectory = "/home/yannic";

  # DO NOT CHANGE, READ DOCS
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # HOME PACKAGES
  home.packages = with pkgs; [
    cowsay
    fortune
    lolcat
  ];

  # DOTFILES
  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.zshrc-minimal";
    };
    ".oh-my-zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.oh-my-zsh";
    };
    ".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.p10k.zsh";
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.gitconfig";
    };
  };

  # SESSION VARIABLES
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
