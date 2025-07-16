{
  imports = [
    ./fonts.nix
    ./games.nix
    ./gamemode.nix
    ./gnome.nix
    ./home-manager.nix
    ./hyprland
    # ./qt.nix
    ./uwsm.nix
    ./xdg.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };
}
