{
  lib,
  config,
  ...
}: {
  options.ionia.services.immich.enable = lib.mkEnableOption "immich service";

  config = lib.mkIf (config.ionia.services.immich.enable && config.ionia.services.enable) {
    services.immich = {
      enable = true;
      openFirewall = true;
    };

    users.users.immich.extraGroups = ["video" "render"];
  };
}
