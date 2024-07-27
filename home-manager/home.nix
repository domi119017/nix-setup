{ config, pkgs, ... }:

{
  # USER
  home.username = "delta";
  home.homeDirectory = "/home/delta";

  # DO NOT CHANGE, READ DOCS
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # HOME PACKAGES
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    posy-cursors
    candy-icons
    dracula-theme
  ];

  # DOTFILES
  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.zshrc";
    };
    ".oh-my-zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.oh-my-zsh";
    };
    ".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.p10k.zsh";
    };
    "Pictures/Wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/Pictures/Wallpapers";
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/delta/nix-setup/nix-dotfiles/.gitconfig";
    };
  };

  # SESSION VARIABLES
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # POSYS CURSOR
  home.pointerCursor = {
    name = "Posy_Cursor_Black";
    package = pkgs.posy-cursors;
    size = 32;
    gtk.enable = true;
  };

  # GNOME/GTK
  gtk = {
    enable = true;

    # THEME
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };

    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    # DARKMODE
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # DCONF
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      color-shading-type ="solid";
      picture-options ="zoom";
      picture-uri ="file:///home/delta/Pictures/Wallpapers/dracula-mnt-282a36.png";
      picture-uri-dark ="file:///home/delta/Pictures/Wallpapers/dracula-mnt-282a36.png";
      primary-color ="#000000000000";
      secondary-color ="#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      color-shading-type ="solid";
      picture-options ="zoom";
      picture-uri ="file:///home/delta/Pictures/Wallpapers/dracula-mnt-282a36.png";
      primary-color ="#000000000000";
      secondary-color ="#000000000000";
    };
    "org/gnome/desktop/notifications" = {
      show-banners = false;
    };
    "org/gnome/desktop/session" = {
      idle-delay = 600;
    };
    "system/locale" = {
      region = "de_DE.UTF-8";
    };
    "org/gnome/desktop/privacy" = {
      old-files-age = 30;
      recent-files-max-age = 7;
      remove-old-trash-files = true;
      remove-old-temp-files = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ 
        "user-theme@gnome-shell-extensions.gcampax.github.com" 
        "Vitals@CoreCoding.com"
      ];
      favorite-apps = [ 
        "org.gnome.Nautilus.desktop" 
        "org.gnome.Console.desktop" 
        "code.desktop" 
        "firefox.desktop" 
        "obsidian.desktop"
      ];
    };
    "org/gnome/shell/extensions/user-theme"={
      name="Dracula";
    };
    "org/gnome/Console"={
      use-system-font=false;
      custom-font="JetBrainsMonoNL Nerd Font Mono 10";
      audible-bell=false;
    };
  };

  # # ZSH config
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #   shellAliases = {
  #     ll = "ls -l";
  #     la = "ls -la";
  #     update = "sudo nixos-rebuild switch --flake ~/nix-setup#delta-surface";
  #     update-home = "home-manager switch --flake ~/nix-setup#delta@delta-surface";
  #     upnix = "cd ~/nix-setup; git pull && update && update-home && gnome-session-quit --logout --force --no-prompt;";
  #     zrc = "nano ~/.zshrc";
  #     hwk = "ssh pi@192.168.178.130";
  #     opn = "ssh pi@192.168.178.81";
  #     e = "exit";
  #   };
  
  #   history = {
  #     size = 10000;
  #     path = "${config.xdg.dataHome}/zsh/history";
  #   };
  
  #   oh-my-zsh = {
  #     enable = true;
  #     theme = "agnoster";
  #     plugins = [ "git" ];
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
