{ pkgs, inputs, ... }:
{
  imports = [
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/zen.nix
    ./browsers/helium.nix
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
    ./vicinae
  ];

  home.packages = with pkgs; [
    halloy
    signal-desktop
    telegram-desktop

    gnome-calculator
    gnome-control-center

    overskride
    resources
    wineWowPackages.wayland

    zotero
  ];
}
