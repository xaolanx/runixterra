{
  lib,
  pkgs,
  config,
  ...
}: let
  isGnomeEnabled = config.services.desktopManager.gnome.enable;
in {
  # GDM
  services.displayManager.gdm.enable = lib.mkDefault true;
  services.desktopManager.gnome.enable = lib.mkDefault false;

  # Exclude packages from the gnome.
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-maps
    geary
    gnome-tour
    # gnome-software
    gnome-contacts
    gnome-tour
    gnome-music
    rhythmbox
    totem
  ];

  # Override default Dconf settings.
  services.desktopManager.gnome = {
    extraGSettingsOverridePackages = with pkgs; [
      gsettings-desktop-schemas # for org.gnome.desktop
      gnome-shell # for org.gnome.shell
    ];
  };

  # packages
  environment.systemPackages =
    (with pkgs;
      [
      ]
      ++ lib.optionals isGnomeEnabled [
        dconf-editor
        gnome-tweaks
        evolution
        # gdm-settings
        gnome-extension-manager
      ])
    ++ lib.optionals isGnomeEnabled (with pkgs.gnomeExtensions; [
      paperwm
      appindicator
      clipboard-indicator
      blur-my-shell
      # net-speed
      emoji-copy
      cloudflare-warp-toggle
      system-monitor
      weather-oclock
      dash2dock-lite
      just-perfection
    ]);

  # add gsconnect connection configuration
  programs.kdeconnect.package = lib.mkIf isGnomeEnabled pkgs.gnomeExtensions.gsconnect;
  programs.gnome-disks.enable = true;
  programs.file-roller.enable = true;
}
