{lib, ...}: {
  services.udiskie = {
    enable = true;
    tray = "never";
  };
  systemd.user.services.udiskie.Unit.After = lib.mkForce "graphical-session.target";
}
