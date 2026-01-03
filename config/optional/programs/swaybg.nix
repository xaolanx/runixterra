{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs) swaybg;

  swaybgStart = pkgs.writeShellScript "swaybg-start" ''
    ${swaybg}/bin/swaybg -i "${config.local.style.wallpaper}"
  '';
in {
  systemd.user.services = {
    swaybg = {
      enable = true;
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
