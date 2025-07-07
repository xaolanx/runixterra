{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = lib.mkDefault true;
    accent = "mauve";
    gtk = {
      enable = true;
      accent = "mauve";
      flavor = "mocha";
      size = "compact";
      icon = {
        enable = true;
        accent = "mauve";
        flavor = "mocha";
      };
    };
    fish.enable = true;
    yazi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
  };
}
