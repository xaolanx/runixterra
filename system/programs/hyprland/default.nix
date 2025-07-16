{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default

    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./smartgaps.nix
  ];

  environment.systemPackages =
    [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      inputs.quickshell.packages.${pkgs.system}.default
      inputs.self.packages.${pkgs.system}.bibata-hyprcursor
    ]
    ++ (with pkgs; [
      foot
      wezterm
      libnotify
      ripgrep
      ripdrag
      cliphist
      wl-clipboard
      grimblast
      kitty
    ]);

  environment.pathsToLink = ["/share/icons"];

  # Enable Hyprland and required options
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
      # hyprexpo
    ];
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
  };

  # Tell Electron/Chromium to run on Wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
