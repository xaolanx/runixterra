{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  security = {
    polkit = {
      enable = true;
    };

    # userland niceness
    rtkit.enable = true;

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";

    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = getExe pkgs.kdePackages.polkit-kde-agent-1;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
