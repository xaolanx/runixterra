{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  # home.pointerCursor = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };

  gtk = {
    enable = true;

    # font = {
    #   name = "Inter";
    #   package = pkgs.google-fonts.override {fonts = ["Inter"];};
    #   size = 9;
    # };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = lib.mkDefault {
      name = "Colloid-Purple-Rosepine-Dark";
      package = inputs.colloid-icon.packages.${pkgs.system}.rosepinepurple;
    };

    # theme = {
    #   name = "adw-gtk3-dark";
    #   package = pkgs.adw-gtk3;
    # };
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce true;
}
