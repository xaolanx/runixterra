{
  pkgs,
  self,
  lib,
  ...
}:
# Wayland config
{
  imports = [
    # ./hyprland
    ./niri
    ./hyprlock.nix
    # ./swayosd.nix
    # ./waybar
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp

    # utils
    self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    # wl-screenrec
    wlr-randr
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  systemd.user.targets.tray.Unit.Requires = lib.mkForce ["graphical-session.target"];
}
