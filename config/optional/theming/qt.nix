{
  pkgs,
  config,
  self,
  pins,
  ...
}: let
  kvantumTheme = pkgs.gruvbox-kvantum.overrideAttrs {
    pname = "gruvbox-kvantum";
    version = "0-unstable-${pins.gruvbox-kvantum.revision}";
    src = pins.gruvbox-kvantum;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/Kvantum
      cp -a Gruvbox* $out/share/Kvantum
      runHook postInstall
    '';
  };

  qtctConf = {
    Appearance = {
      custom_palette = true;
      icon_theme = config.local.style.gtk.iconTheme.name;
      standard_dialogs = "xdgdesktopportal";
      style = "kvantum-dark";
    };

    Fonts = {
      fixed = ''"monospace,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      general = ''"sans-serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
    };

    Interface = {
      activate_item_on_single_click = 1;
      underline_shortcut = 1;
      wheel_scroll_lines = 3;
      menus_have_icons = true;
    };
  };
in {
  hjem.extraModules = [
    self.hjemModules.kvantum
    self.hjemModules.qtct
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  hj = {
    local.misc = {
      qtct = {
        enable = true;
        qt5.settings = qtctConf;
        qt6.settings = qtctConf;
      };
      kvantum = {
        enable = true;
        theme = {
          name = "Gruvbox-Dark-Green";
          package = kvantumTheme;
        };
      };
    };
  };
}
