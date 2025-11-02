{
  pkgs,
  self',
  ...
}: {
  fonts = {
    enableDefaultPackages = false;
    packages = [
      pkgs._0xproto
      pkgs.noto-fonts-color-emoji
      pkgs.nerd-fonts.symbols-only

      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans

      pkgs.inter
      pkgs.aporetic
      pkgs.material-symbols
      self'.packages.librebarcode
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Aporetic Serif"];
        sansSerif = ["Aporetic Sans"];
        monospace = ["Aporetic Serif Mono" "Symbols Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
