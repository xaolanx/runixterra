{ pkgs, config, lib }:

let
  wallpaperPath = config.theme.wallpaper;

  hyprlockConfig = ''
    background {
      monitor=
      blur_passes=3
      blur_size=10
      brightness=0.800000
      path=${wallpaperPath}
    }

    general {
      disable_loading_bar=true
      hide_cursor=false
      immediate_render=true
      no_fade_in=true
    }

    input-field {
      monitor=eDP-1
      size=300, 50
      check_color=rgb(31748f)
      dots_center=true
      dots_fade_time=100
      dots_spacing=0.200000
      fade_on_empty=false
      fail_color=rgb(eb6f92)
      font_color=rgb(191724)
      inner_color=rgb(e0def4)
      outer_color=rgb(e0def4)
      outline_thickness=1
      placeholder_text=Enter Password
      position=0%, 10%
      shadow_color=rgb(191724)
      shadow_passes=2
      shadow_size=7
      valign=bottom
    }

    label {
      monitor=
      color=rgb(e0def4)
      font_family=Scientifica
      font_size=150
      halign=center
      position=0%, 30%
      shadow_boost=0.300000
      shadow_color=rgb(191724)
      shadow_passes=2
      shadow_size=20
      text=$TIME
      valign=center
    }

    label {
      monitor=
      color=rgb(e0def4)
      font_size=20
      halign=center
      position=0%, 15%
      shadow_boost=0.300000
      shadow_color=rgb(191724)
      shadow_passes=2
      shadow_size=20
      text=cmd[update:3600000] date +'%a %b %d'
      valign=center
    }
  '';
in
pkgs.symlinkJoin {
  name = "hyprlock-with-config";
  paths = [ pkgs.hyprlock ];
  buildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    mkdir -p $out/share/hyprlock
    echo '${hyprlockConfig}' > $out/share/hyprlock/hyprlock.conf

    wrapProgram $out/bin/hyprlock \
      --add-flags "-c $out/share/hyprlock/hyprlock.conf"
  '';
}
