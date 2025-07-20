{
  pkgs,
  lib,
  config,
  ...
}: {
  options.ionia.programs.steam.enable = lib.mkEnableOption "steam";
  config = lib.mkIf config.ionia.programs.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: [
          pkgs.mangohud
        ];
      };
    };
  };
}
