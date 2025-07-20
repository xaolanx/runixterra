{
  lib,
  config,
  pkgs,
  ...
}: {
  options.ionia.programs.firefox.enable = lib.mkEnableOption "firefox";
  config = lib.mkIf config.ionia.programs.firefox.enable {
    environment.systemPackages = [pkgs.firefoxpwa];
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = [
        pkgs.firefoxpwa
      ];
    };
  };
}
