{lib, ...}: {
  programs.waybar = {
    enable = lib.mkDefault false;
  };
}
