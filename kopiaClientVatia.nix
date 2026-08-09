{
  lib,
  config,
  pkgs,
  systemSettings,
  ...
}: {
  options.kopiaClientVatia.enable = lib.mkEnableOption "kopia client for trouv's backup server";

  config = lib.mkIf config.kopiaClientVatia.enable {
    environment.systemPackages = [
      pkgs.kopia
      (pkgs.writeShellScriptBin "kopia-connect-vatia" ''
        kopia repository connect server \
          --url https://192.168.0.4:51515/ \
          --server-cert-fingerprint 73fa21b188d22957ed2a6635e1fb994ff6fd9546d02e0e14f2469cf5a0eb175a
      '')
    ];

    # kopia snapshot frequency
    systemd.timers."kopia-snapshot-home" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "kopia-snapshot-home.service";
      };
    };
    systemd.services."kopia-snapshot-home" = {
      path = [pkgs.kopia];
      script = ''
        kopia snapshot create /home/${systemSettings.primaryUser.username}
      '';
      serviceConfig = {
        Type = "oneshot";
        User = systemSettings.primaryUser.username;
      };
    };
  };
}
