{
  lib,
  pkgs,
  ...
}: let
  toINI = lib.generators.toINI {};
in {
  config = {
    hj = {
      packages = [pkgs.gammastep];
      files = {
        ".config/gammastep/config.ini".text = toINI {
          general = {
            location-provider = "geoclue2";
            temp-day = 5500;
            temp-night = 3700;
          };
        };
      };
    };

    systemd.user.services.gammastep = {
      enable = true;
      description = "Gammastep colour temperature adjuster";
      after = ["graphical-session.target"];
      wants = ["geoclue-agent.service"];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.gammastep}/bin/gammastep-indicator";
        Restart = "on-failure";
        RestartSec = 3;
        Slice = "background-graphical.slice";
      };

      wantedBy = ["graphical-session.target"];
    };
  };
}
