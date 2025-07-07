{lib, ...}: {
  services.gammastep = {
    enable = true;
    tray = true;

    # stopgap until geoclue's wifi location is fixed
    provider = lib.mkDefault "manual";
    latitude = -7.0;
    longitude = 112.0;

    enableVerboseLogging = true;

    settings.general.adjustment-method = "wayland";
  };
}
