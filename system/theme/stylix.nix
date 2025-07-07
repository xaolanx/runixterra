{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  aporetic-nerd = inputs.aporetic-nerd-patch.packages.${pkgs.system}.default;
in {
  imports = [inputs.stylix.nixosModules.stylix];

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = config.theme.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    polarity = "dark";

    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = true;

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
      console.enable = true;
      gnome.enable = lib.mkForce false;
      gtk.enable = true;
      nixos-icons.enable = true;
      qt.enable = true;
    };
  };
}
