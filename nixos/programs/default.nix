{
  imports = [
    ./fonts.nix
    # ./qt.nix
    ./xdg.nix
    ./hyprland
    ./fish.nix
    ./gnome.nix
    ./uwsm.nix
    ./games.nix
    ./niri.nix
  ];

  programs = {
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };
}
