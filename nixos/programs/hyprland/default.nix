{
  pkgs,
  sources,
  ...
}: {
  imports = [
    ./smartgaps.nix
  ];

  environment.systemPackages = with pkgs; [
    grimblast
    foot
    wezterm
    wl-clipboard
    cliphist
    libnotify
    kdePackages.qt6ct
    ripgrep
    ripdrag
    colloid-icon-rosepink
    quickshell
    wezterm
    kitty
  ];

  environment.pathsToLink = ["/share/icons"];

  # enable hyprland and required options
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  services.hypridle.enable = true;
  qt.enable = true;

  # tell Electron/Chromium to run on Wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
