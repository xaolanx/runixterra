{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Aporetic Sans";
      package = pkgs.aporetic;
      size = 10;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = lib.mkDefault {
      name = "Colloid-Purple-Rosepine-Dark";
      package = inputs.colloid-icon.packages.${pkgs.system}.rosepinepurple;
    };

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce true;
}
