{lib, ...}: {
  services.tailray.enable = false;
  systemd.user.services.tailray.Unit.After = lib.mkForce "graphical-session.target";
}
