{
  config,
  lib,
  pkgs,
  ...
}: {
  # greetd display manager
  services.greetd = let
    session-niri = {
      command = "${lib.getExe config.programs.uwsm.package} start ${pkgs.niri}/share/wayland-sessions/niri.desktop";
      user = "xaolan";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session-niri;
      initial_session = session-niri;
    };
  };

  # unlock GPG keyring on login
  # disabled as it doesn't work with autologin
  # security.pam.services.greetd.enableGnomeKeyring = true;
}
