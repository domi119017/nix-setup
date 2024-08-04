{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Include gnome stuff
    ./modules/gnome.nix
    ./modules/coding.nix
    ./modules/notes.nix
    ./modules/gaming.nix
  ];

  # USER
  home.username = "delta";
  home.homeDirectory = "/home/delta";

  # DO NOT CHANGE, READ DOCS
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # HOME PACKAGES
  home.packages = with pkgs; [
    # - Delta - #
    cowsay
    fortune
    lolcat
  ];

  # DOTFILES
  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "../nix-dotfiles/.zshrc";
    };
    ".oh-my-zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "../nix-dotfiles/.oh-my-zsh";
    };
    ".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "../nix-dotfiles/.p10k.zsh";
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "../nix-dotfiles/.gitconfig";
    };
  };

  # SESSION VARIABLES
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
