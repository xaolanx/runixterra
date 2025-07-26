{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.strings) concatStringsSep;

  inherit (pkgs) swaybg;

  swaybgStart = pkgs.writeShellScript "swaybg-start" ''
    ${swaybg}/bin/swaybg -i "$(${pkgs.uutils-coreutils-noprefix}/bin/shuf -e ${concatStringsSep " " config.local.style.wallpapers} -n 1)"
  '';
in {
  systemd.user.services = {
    swaybg = {
      description = "swaybg service";
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      requires = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${swaybgStart}";
      };
      wantedBy = ["graphical-session.target"];
    };
  };
}
