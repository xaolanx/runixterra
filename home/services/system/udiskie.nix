{lib, ...}: {
  services.udiskie = {
    enable = false;
    tray = "never";
  };
  systemd.user.services.udiskie.Unit.After = lib.mkForce "graphical-session.target";
}
