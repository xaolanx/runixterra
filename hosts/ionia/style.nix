{...}: {
  local.style = {
    enable = true;
    wallpaper = let
      url = "https://images.unsplash.com/photo-1509838174235-432f709c7bfd?ixlib=rb-4.1.0&q=85&fm=jpg&crop=entropy&cs=srgb&dl=chad-madden-cPa-7yByq3o-unsplash.jpg";
      sha256 = "sha256-rJ5nc2mB08OcE8xg7Kv+SgowWNyOEtYHeFNwCEizSRY=";
      ext = "jpg";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
    colors.schemeName = "catppuccin-mocha";
    colors.system = "base24";
  };
}
