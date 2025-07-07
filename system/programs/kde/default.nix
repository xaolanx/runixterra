{
  pkgs,
  config,
  ...
}: let
  wallpaper = config.theme.wallpaper;
in {
  # Enable KDE
  services.displayManager.sddm = {
    enable = false;
    settings.Theme.CursorTheme = "Bibata Modern Ice";
    wayland.enable = false;
  };
  services.desktopManager.plasma6.enable = false;

  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${wallpaper};
      type=image
    '')
  ];

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    ark
    baloo-widgets
    elisa
    ffmpegthumbs
    kate
    khelpcenter
    konsole
    krdp
    plasma-browser-integration
    xwaylandvideobridge
  ];

  # Disabled redundant services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
