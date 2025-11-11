{ config, pkgs, lib, inputs', ... }:

let
  cfg = config.programs.dankMaterialShell;
  jsonFormat = pkgs.formats.json { };
in {
  options.programs.dankMaterialShell = with lib.types; {
    enable = lib.mkEnableOption "DankMaterialShell";

    enableSystemd = lib.mkEnableOption "DankMaterialShell systemd startup";
    enableSystemMonitoring = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to use system monitoring widgets";
    };
    enableClipboard = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to use the clipboard widget";
    };
    enableVPN = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to use the VPN widget";
    };
    enableBrightnessControl = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to have brightness/backlight support";
    };
    enableColorPicker = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to have color picking support";
    };
    enableDynamicTheming = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to have dynamic theming support";
    };
    enableAudioWavelength = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to have audio wavelength support";
    };
    enableCalendarEvents = lib.mkOption {
      type = bool;
      default = true;
      description = "Add calendar events support via khal";
    };
    enableSystemSound = lib.mkOption {
      type = bool;
      default = true;
      description = "Add needed dependencies to have system sound support";
    };

    quickshell = {
      package = lib.mkPackageOption pkgs "quickshell" { };
    };

    default = {
      settings = lib.mkOption {
        type = jsonFormat.type;
        default = { };
        description = "The default settings are only read if the settings.json file doesn't exist";
      };
      session = lib.mkOption {
        type = jsonFormat.type;
        default = { };
        description = "The default session is only read if the session.json file doesn't exist";
      };
    };

    plugins = lib.mkOption {
      type = attrsOf (submodule ({ config, ... }: {
        options = {
          enable = lib.mkOption {
            type = bool;
            default = true;
            description = "Whether to link this plugin";
          };
          src = lib.mkOption {
            type = path;
            description = "Source to link to DMS plugins directory";
          };
        };
      }));
      default = { };
      description = "DMS Plugins to install";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.dms = lib.mkIf cfg.enableSystemd {
      description = "DankMaterialShell";
      partOf = [ config.wayland.systemd.target ];
      after = [ config.wayland.systemd.target ];

      serviceConfig = {
        ExecStart = "${lib.getExe inputs'.dms-cli.packages.dms-cli} run";
        Restart = "on-failure";
      };

      wantedBy = [ config.wayland.systemd.target ];
    };

    hj.xdg.config.files = lib.mkMerge [
      (lib.mapAttrs' (name: plugin: {
        name = "DankMaterialShell/plugins/${name}";
        value.source = plugin.src;
      }) (lib.filterAttrs (_: v: v.enable) cfg.plugins))
      {
        "DankMaterialShell/default-settings.json" = lib.mkIf (cfg.default.settings != { }) {
          source = jsonFormat.generate "default-settings.json" cfg.default.settings;
        };
        "DankMaterialShell/default-session.json" = lib.mkIf (cfg.default.session != { }) {
          source = jsonFormat.generate "default-session.json" cfg.default.session;
        };
      }
    ];

    hj.packages =
      [
        pkgs.material-symbols
        pkgs.inter
        pkgs.fira-code
        pkgs.ddcutil
        pkgs.libsForQt5.qt5ct
        pkgs.kdePackages.qt6ct
        inputs'.dms-cli.packages.dms-cli
        inputs'.dankMaterialShell.packages.default
      ]
      ++ lib.optional cfg.enableSystemMonitoring inputs'.dgop.packages.default
      ++ lib.optionals cfg.enableClipboard [ pkgs.cliphist pkgs.wl-clipboard ]
      ++ lib.optionals cfg.enableVPN [ pkgs.glib pkgs.networkmanager ]
      ++ lib.optional cfg.enableBrightnessControl pkgs.brightnessctl
      ++ lib.optional cfg.enableColorPicker pkgs.hyprpicker
      ++ lib.optional cfg.enableDynamicTheming pkgs.matugen
      ++ lib.optional cfg.enableAudioWavelength pkgs.cava
      ++ lib.optional cfg.enableCalendarEvents pkgs.khal
      ++ lib.optional cfg.enableSystemSound pkgs.kdePackages.qtmultimedia;
  };
}
