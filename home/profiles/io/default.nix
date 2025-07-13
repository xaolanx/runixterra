{
  imports = [
    # editors
    ../../editors/nvf.nix
    ../../editors/micro.nix

    # programs
    ../../programs
    ../../programs/games
    ../../programs/wayland

    # services
    # ../../services/ags
    ../../services/quickshell
    # ../../services/cinny.nix

    # media services
    ../../services/media/playerctl.nix
    # ../../services/media/spotifyd.nix

    # system services
    ../../services/system/kdeconnect.nix
    ../../services/system/polkit-agent.nix
    ../../services/system/power-monitor.nix
    ../../services/system/syncthing.nix
    ../../services/system/tailray.nix
    # ../../services/system/theme.nix
    ../../services/system/udiskie.nix

    # wayland-specific
    ../../services/wayland/gammastep.nix
    ../../services/wayland/hyprpaper.nix
    ../../services/wayland/hypridle.nix
    # ../../services/wayland/wluma.nix

    # terminal emulators
    # ../../terminal/emulators/kitty.nix
    ../../terminal/emulators/foot.nix
    ../../terminal/emulators/wezterm.nix
  ];
}
