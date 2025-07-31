{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      binPath = pkgs.writeShellScript "niri" ''
        ${lib.getExe config.programs.niri.package} --session
      '';
      prettyName = lib.mkForce "Niri";
      comment = lib.mkForce "Niri managed by UWSM";
    };
  };
}
