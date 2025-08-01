{
  config,
  lib,
  myLib,
  inputs',
  self',
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (myLib.generators) toHyprConf;
  inherit (inputs'.hypridle.packages) hypridle;
  inherit (lib.meta) getExe getExe';

  noctalia = getExe self'.packages.noctalia;
  loginctl = getExe' pkgs.systemd "loginctl";
  systemctl = getExe' pkgs.systemd "systemctl";
  hyprctl = getExe' config.programs.hyprland.package "hyprctl";
  niri = getExe config.programs.niri.package;

  # Shared listener definitions
  commonListeners = [
    {
      timeout = 300;
      on-timeout = "${loginctl} lock-session";
    }
    {
      timeout = 330;
      on-timeout =
        if config.programs.niri.enable
        then "${niri} msg action power-off-monitors"
        else "${hyprctl} dispatch dpms off";
      on-resume =
        if config.programs.niri.enable
        then "${niri} msg action power-on-monitors"
        else "${hyprctl} dispatch dpms on";
    }
    {
      timeout = 500;
      on-timeout = "${systemctl} suspend";
    }
  ];

  # Conditional general config
  generalSettings =
    if config.programs.niri.enable
    then {
      lock_cmd = "${noctalia} ipc call globalIPC toggleLock";
      before_sleep_cmd = "${loginctl} lock-session";
      after_sleep_cmd = "${niri} msg action power-on-monitors";
    }
    else {
      lock_cmd = "${noctalia} ipc call globalIPC toggleLock";
      before_sleep_cmd = "${loginctl} lock-session";
      after_sleep_cmd = "${hyprctl} dispatch dpms on";
    };

  # Final Hypridle config
  hypridleConf = toHyprConf {
    attrs = {
      general = generalSettings;
      listener = commonListeners;
    };
  };
in {
  options.idle.services.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable idle service (Hypridle) with settings based on compositor.";
  };

  config = mkIf config.idle.services.enable {
    hj.packages = [hypridle];

    hj.files.".config/hypr/hypridle.conf".text = hypridleConf;

    systemd.user.services.hypridle = {
      enable = true;
      after = ["graphical-session.target"];
      description = "Hyprland's Idle Daemon";

      serviceConfig = {
        Type = "simple";
        ExecStart = "${hypridle}/bin/hypridle";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };

      wantedBy = ["graphical-session.target"];
    };
  };
}
