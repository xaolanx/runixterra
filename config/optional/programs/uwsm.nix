{
  lib,
  pkgs,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      binPath = lib.mkForce "${pkgs.niri}/bin/niri-session";
      prettyName = lib.mkForce "Niri";
      comment = lib.mkForce "Niri managed by UWSM";
    };
  };
}
