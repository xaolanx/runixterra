{
  programs.hyprland.settings = {
    monitor = [
      # "DP-1, preferred, auto-left, auto"
      # "DP-2, preferred, auto-left, auto"
      "eDP-1, 1600x900, 0x0, 1"
    ];

    "device[etps/2-elantech-touchpad]" = {
      natural_scroll = true;
    };
  };
}
