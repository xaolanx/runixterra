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
      pkgs.noto-fonts-extra

      pkgs.inter
      pkgs.aporetic
      pkgs.material-symbols
      self'.packages.librebarcode
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Inter Variable"];
        monospace = ["0xProto" "Symbols Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
