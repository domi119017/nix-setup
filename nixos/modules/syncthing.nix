{ config, lib, pkgs, inputs, ... }:

{
  # Syncthing
  services.syncthing = {
    enable = true;
    user = "delta";
    dataDir = "/home/delta/Sync";
    configDir = "/home/delta/Documents/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    settings = {
      devices = {
        "hawking" = { id = "BONLP32-SGBSCTK-7U4N2IN-NRX6CCN-76ZXZ6P-4M2GFBM-T4RYG4X-PZY47AZ"; };
      };
      folders = {
        "code" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/delta/Sync/Code";    # Which folder to add to Syncthing
          devices = [ "hawking" ];      # Which devices to share the folder with
        };
        "dokumente" = {
          path = "/home/delta/Sync/Dokumente";
          devices = [ "hawking" ];
        };
        "obsidian-vault" = {
          path = "/home/delta/Sync/Obsidian-Vault";
          devices = [ "hawking" ];
        };
        "mindustry" = {
          path = "/home/delta/Sync/Mindustry";
          devices = [ "hawking" ];
        };
      };
      gui = {
        user = "domi";
        password = "domi";
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    # - Syncthing - #
    syncthing
  ];

  systemd.services.syncthing.serviceConfig.ExecStartPre =
    let
      cfg = config.services.syncthing;
      syncthing-set-password = pkgs.writeShellScriptBin "syncthing-set-password" ''
        PASSWORD="$(cat ${config.sops.secrets.st_passwd.path})"
        ${cfg.package}/bin/syncthing generate \
          --config=${cfg.configDir} \
          --gui-user=${cfg.user} \
          --gui-password="$PASSWORD" \
          ${lib.escapeShellArgs cfg.extraFlags}
      '';
    in
    if (cfg.cert != null || cfg.key != null) then
      abort "Cert or key manually set for syncthing, so overriding execstart pre is not safe! Compare with ExecStartPre in nixpkgs to see what needs to be done."
    else
      lib.mkForce "${syncthing-set-password}/bin/syncthing-set-password";
}