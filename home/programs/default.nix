{
  self,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./anyrun
    ./browsers/chromium
    ./browsers/firefox
    ./browsers/zen
    ./media
    ./games
    ./gtk.nix
    ./office
    ./wayland
    ./qt
  ];

  home.packages = with pkgs; [
    halloy
    tdesktop

    gnome-calculator
    gnome-control-center
    nautilus

    # Download Manager
    inputs.self.packages.${pkgs.system}.fdm

    overskride
    resources
    wineWowPackages.wayland

    zotero

    # Quickshell stuff
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia

    #media
    youtube-music
    inputs.tidaluna.packages.${pkgs.system}.default
    amberol
    audacious
  ];
}
