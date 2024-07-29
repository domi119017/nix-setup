{ config, pkgs, ... }:

{
  # HOME PACKAGES
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.tiling-assistant
    gnomeExtensions.caffeine
    posy-cursors
    candy-icons
    dracula-theme
  ];

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
      font-name="Sans 11";
      document-font-name="Sans 11";
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
    "org/gnome/desktop/wm/preferences"={
      button-layout="appmenu:minimize,maximize,close";
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
        "tiling-assistant@leleat-on-github"
        "caffeine@patapon.info"
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
    "org/gnome/shell/extensions/vitals"={
      position-in-panel= 0;
    };
    "org/gnome/shell/extensions/caffeine"={
      indicator-position=0;
      show-indicator="always";
      show-timer=true;
      show-notifications=false;
    };
    "org/gnome/Console"={
      use-system-font=false;
      custom-font="JetBrainsMonoNL Nerd Font Mono 10";
      audible-bell=false;
    };
  };
}
