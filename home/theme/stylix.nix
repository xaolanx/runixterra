{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  aporetic-nerd = inputs.aporetic-nerd-patch.packages.${pkgs.system}.default;
in {
  imports = [inputs.stylix.homeModules.stylix];

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = config.theme.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    polarity = "dark";

    iconTheme = {
      enable = false;
      package = pkgs.gruvbox-plus-icons;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
    };

    fonts = {
      sizes.applications = lib.mkDefault 10;
      sizes.terminal = lib.mkDefault 11;
      sizes.desktop = lib.mkDefault 10;
      serif = {
        package = pkgs.aporetic;
        name = lib.mkDefault "Aporetic Serif";
      };
      sansSerif = {
        package = lib.mkDefault pkgs.aporetic;
        name = lib.mkDefault "Aporetic Sans";
      };
      monospace = {
        package = aporetic-nerd;
        name = "AporeticSerifMono Nerd Font";
      };
      emoji = {
        package = lib.mkDefault pkgs.noto-fonts-emoji;
        name = lib.mkDefault "Noto Color Emoji";
      };
    };

    cursor = {
      package = lib.mkDefault pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Modern-Ice";
      size = lib.mkDefault 18;
    };

    opacity = {
      terminal = 0.8;
      desktop = 1;
      applications = 0.85;
      popups = 0.9;
    };

    targets = {
      floorp.profileNames = ["xaolan"];
      firefox.profileNames = ["xaolan"];
      gnome-text-editor.enable = lib.mkDefault false;
      hyprland.enable = false;
      hyprlock.enable = false;
      zed.enable = false;
      waybar.enable = false;
      zathura.enable = false;
      kde.enable = false;
      gnome.enable = false;
    };
  };
}
