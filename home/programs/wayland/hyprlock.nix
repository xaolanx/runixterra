{
  config,
  lib,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = lib.mkForce {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = lib.mkForce [
        {
          monitor = "";
          path = lib.mkDefault config.theme.wallpaper;
          blur_passes = 3;
          blur_size = 10;
          brightness = 0.8;
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "eDP-1";

          size = "300, 50";
          valign = "bottom";
          position = "0%, 10%";

          outline_thickness = 1;

          check_color = "rgb(31748f)";
          fail_color = "rgb(eb6f92)";
          font_color = "rgb(191724)";
          inner_color = "rgb(e0def4)";
          outer_color = "rgb(e0def4)";

          fade_on_empty = false;
          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = "rgb(191724)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = lib.mkForce [
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          font_family = "Scientifica";
          color = "rgb(e0def4)";

          position = "0%, 30%";

          valign = "center";
          halign = "center";

          shadow_color = "rgb(191724)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(e0def4)";

          position = "0%, 15%";

          valign = "center";
          halign = "center";

          shadow_color = "rgb(191724)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
