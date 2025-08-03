{
  lib,
  pkgs,
  config,
  pins,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;

  # styleCfg = config.local.style;
  c = config.programs.matugen.theme.colors.dark;

  # footTheme = styleCfg.colors.scheme {
  #   templateRepo = pins.tinted-terminal;
  #   target = "foot-${styleCfg.colors.scheme.system}";
  #   use-ifd = "always";
  # };

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
          };

          colors = {
            alpha = 1.0;
            cursor = "${c.surface_variant} ${c.on_surface}";
            background = c.surface;
            foreground = c.on_surface;
            regular0 = c.surface;
            regular1 = c.error;
            regular2 = c.tertiary_fixed_dim;
            regular3 = c.secondary_fixed_dim;
            regular4 = c.blue;
            regular5 = c.magenta;
            regular6 = c.primary_fixed_dim;
            regular7 = c.on_surface;
            bright0 = c.surface_bright;
            bright1 = c.on_error_container;
            bright2 = c.tertiary;
            bright3 = c.secondary;
            bright4 = c.brighter-blue;
            bright5 = c.brighter-magenta;
            bright6 = c.primary;
            bright7 = c.on_surface;
            selection-foreground = c.primary;
            selection-background = c.on_primary;
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
