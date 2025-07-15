{
  pkgs,
  config,
}: let
  wallpaperPath = config.theme.wallpaper;

  hyprpaperConfig = ''
    preload=${wallpaperPath}
    preload=${wallpaperPath}
    wallpaper=,${wallpaperPath}
    wallpaper=, ${wallpaperPath}
  '';
in
  pkgs.symlinkJoin {
    name = "hyprpaper-with-config";
    paths = [pkgs.hyprpaper];
    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      mkdir -p $out/share/hyprpaper
      echo '${hyprpaperConfig}' > $out/share/hyprpaper/hyprpaper.conf

      wrapProgram $out/bin/hyprpaper \
        --add-flags "-c $out/share/hyprpaper/hyprpaper.conf"
    '';
  }
