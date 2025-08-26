{
  self,
  self',
  config,
  ...
}: let
  kvantumTheme = self'.packages.kvlibadwaita;
  qtctConf = {
    Appearance = {
      custom_palette = true;
      icon_theme = config.local.style.gtk.iconTheme.name;
      standard_dialogs = "xdgdesktopportal";
      style = "Darkly";
      color_scheme_path = "~/.config/qt5ct/colors/caelestia.conf";
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
    # style = "kvantum";
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
          name = "KvLibadwaita";
          package = kvantumTheme;
        };
      };
    };
  };
}
