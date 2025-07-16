{
  imports = [
    ./fonts.nix
    # ./qt.nix
    ./xdg.nix
    ./hyprland
    ./gnome.nix
    ./uwsm.nix
    ./games.nix
    ./niri.nix
    ./package.nix
  ];

  programs = {
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };
}
