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
  programs.matugen = {
    enable = true;
    custom_colors = {
      red.color = "#F07178";
      green.color = "#C3E88D";
      yellow.color = "#FFCB6B";
      blue.color = "#82AAFF";
      magenta.color = "#C792EA";
      cyan.color = "#89DDFF";
      brighter-red.color = "#FF5370";
      brighter-green.color = "#91B859";
      brighter-yellow.color = "#FFB62C";
      brighter-blue.color = "#6182B8";
      brighter-magenta.color = "#7C4DFF";
      brighter-cyan.color = "#39ADB5";
    };
  };
}
