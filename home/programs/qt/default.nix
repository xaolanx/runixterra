{
  lib,
  pkgs,
  ...
}: let
  KvLibadwaita = pkgs.fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "87c1ef9f44ec48855fd09ddab041007277e30e37";
    hash = "sha256-K/2FYOtX0RzwdcGyeurLXAh3j8ohxMrH2OWldqVoLwo=";
    sparseCheckout = ["src"];
  };

  qtctConf = {
    Appearance = {
      custom_palette = false;
      icon_theme = "Colloid-Pink-Rosepine-Dark";
      standard_dialogs = "xdgdesktopportal";
      style = "kvantum";
    };
  };

  defaultFont = "Aporetic Sans,10";
in {
  qt = {
    enable = true;
    platformTheme.name = lib.mkDefault "qt5ct";
  };

  home.packages = [
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.qt6Packages.qt6ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
  ];

  xdg.configFile = {
    # Kvantum config
    "Kvantum" = {
      source = ./rose-pine-iris;
      recursive = true;
    };

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=rose-pine-iris
    '';

    # qtct config
    "qt5ct/qt5ct.conf".text = let
      default = ''"${defaultFont},-1,5,50,0,0,0,0,0"'';
    in
      lib.generators.toINI {} (
        qtctConf
        // {
          Fonts = {
            fixed = default;
            general = default;
          };
        }
      );

    "qt6ct/qt6ct.conf".text = let
      default = ''"${defaultFont},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
    in
      lib.generators.toINI {} (
        qtctConf
        // {
          Fonts = {
            fixed = default;
            general = default;
          };
        }
      );
  };
}
