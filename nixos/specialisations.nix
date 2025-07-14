{
  theme = {
    wallpaper = let
      url = "https://github.com/rose-pine/wallpapers/blob/main/bay.JPG?raw=true";
      sha256 = "YLHsj9SKuJNwiYxCQ5zFDrdEfTSEH89ue95yBvQZ+MI=";
      ext = "jpg";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
