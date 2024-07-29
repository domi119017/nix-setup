# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hosts
      # inputs.sops-nix.nixosModules.sops
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz2K48kEMofcyCnG7eNPacgZ2abxtMKUfPVY19lvCpxNnMCibKSv/IirLukw1YJ/EZC3Z5RizjM+AdHXWuTnaD2VZ0DiHbJwsCfE1M14bj/SMOzv99N4dKefMrO3jCDNcSy+3kBYJBOHhvfujv3nF80uOj64zhXPXDgqSnFc2mfUgnXWR6Q5D3cOirVPytocP41iCjST2DQnlJrC/dy05hfX59H6jxlUcRIdEzdmomrCQG2VphBOHmUuwjocaXJ8Iu+/1JRznfFfkKr6hUluNdffDkSZc3EiPPzkXOo7I+9XcMvzZDAAdyKe5KZzgkCutcwE+t4LWACbMAz9pIbPK1RLpR8f8S0gW9bqK+shNCCTak0t47FtRZGYYTK/QW3pVe5GwQs6jZLF67fcVCcuXMvPvSLrsi9KqZbSP2dU8QMZD2/PcOYt17TpXBt7zr/62eVgCFcQL2P/CNzUmfsF1tyYEqqClgVBoz4TYILPCgEcLvgwKARB/cwbaokPAiisM= domi@Domi-PC"
    ];
  };

  system.stateVersion = "24.05"; 
}

