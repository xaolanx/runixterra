{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      jaq
      xwayland-satellite
      brightnessctl
    ];
  };
}
