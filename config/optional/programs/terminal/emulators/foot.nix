{
  lib,
  pkgs,
  config,
  pins,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) concatStringsSep;

  styleCfg = config.local.style;

  footTheme = styleCfg.colors.scheme {
    templateRepo = pins.tinted-terminal;
    target = "foot-${styleCfg.colors.scheme.system}";
    use-ifd = "always";
  };

  foot = pkgs.foot.overrideAttrs {
    pname = "foot";
    version = "0-unstable-${pins.foot.revision}";
    src = pins.foot;
  };
in {
  config = {
    hj = {
      rum.programs.foot = {
        enable = true;
        package = foot;
        settings = {
          main = {
            term = "xterm-256color";
            font = concatStringsSep "," ["monospace:size=12"];
            bold-text-in-bright = "no";
            horizontal-letter-offset = 0;
            vertical-letter-offset = 0;
            pad = "4x4 center";
            include = mkIf styleCfg.enable "${footTheme}";
          };

          colors = {
            alpha = 0.8;
            alpha-mode = "matching";
          };

          cursor = {
            style = "beam";
            blink = true;
          };

          desktop-notifications = {
            command = "${getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
          };

          url = {
            launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
          };
        };
      };
    };

    systemd.user.services.foot-server = {
      enable = true;
      name = "foot-server";
      description = "foot terminal service";
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      # Path = lib.mkForce [];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${foot}/bin/foot --server";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };

      wantedBy = ["graphical-session.target"];
    };
  };
}
