{
  myLib,
  inputs',
  ...
}: let
  inherit (myLib.generators) toHyprConf;

  inherit (inputs'.hypridle.packages) hypridle;
in {
  hj = {
    packages = [hypridle];
    files = {
      ".config/hypr/hypridle.conf".text = toHyprConf {
        attrs = {
          general = {
            lock_cmd = "noctalia ipc call globalIPC toggleLock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "niri msg action power-on-monitors";
          };

          listener = [
            {
              timeout = 300; # 5m
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 330; # 5.5m
              on-timeout = "niri msg action power-off-monitors";
              on-resume = "niri msg action power-on-monitors";
            }
            {
              timeout = 500; # 10m
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
  };

  systemd.user.services.hypridle = {
    name = "hypridle";
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
}
