{
  pkgs,
  lib,
  ...
}: let
  shaderFolder = ./shaders;
  shaderList = [
    "Anime4K_AutoDownscalePre_x2.glsl"
    "Anime4K_AutoDownscalePre_x4.glsl"
    "Anime4K_Clamp_Highlights.glsl"
    "Anime4K_Restore_CNN_M.glsl"
    "Anime4K_Restore_CNN_VL.glsl"
    "Anime4K_Upscale_CNN_x2_M.glsl"
    "Anime4K_Upscale_CNN_x2_VL.glsl"
  ];

  shaderPaths = map (name: "${shaderFolder}/${name}") shaderList;
  anime4kBinding = "no-osd change-list glsl-shaders set \"${builtins.concatStringsSep ":" shaderPaths}\"; show-text \"Anime4K: Mode A+A (HQ)\"";
  clearShaders = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
in {
  config.hm.programs.mpv = {
    enable = true;
    defaultProfiles = ["fast"];
    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        thumbfast
        sponsorblock
        autoload
        smart-copy-paste-2
      ];
    };

    scriptOpts = {
      autosubsync = {
        "ffmpeg_path" = "${lib.getExe pkgs.ffmpeg-full}";
        "ffsubsync_path" = "${lib.getExe pkgs.ffsubsync}";
        "audio_subsync_tool" = "ask";
        "altsub_subsync_tool" = "ask";
      };
    };
    config = {
      osc = "no";
      osd-bar = "no";
      osd-duration = 2000;
      osd-font = "Aporetic Serif";
      osd-font-size = 30;
      osd-outline-size = 2;
      border = "no";

      save-position-on-quit = "yes";
      watch-later-options = "start, sid";

      keep-open = "yes";
      title-bar = "no";

      msg-color = "yes";
      msg-module = "yes";

      directory-mode = "ignore";
      autocreate-playlist = "filter";
      directory-filter-types = "video,audio";

      ytdl-format = "bestvideo[height<=?1080][vcodec!*=av01][vcodec^=avc1]+bestaudio/best";
      hls-bitrate = "max";

      vo = "gpu-next";
      profile = "fast";
      hwdec = "vulkan";
      hwdec-codecs = "all";
      gpu-context = "waylandvk";
      hdr-compute-peak = "yes";
      target-peak = 300;
      tone-mapping = "st2094-40";
      gamut-mapping-mode = "desaturate";
      hdr-peak-percentile = 99.995;
      hdr-contrast-recovery = 0.30;
      scale = "bilinear";
      dscale = "bilinear";
      correct-downscaling = "no";
      dither = "no";
      brightness = 2.0;
      contrast = 1.0;
      video-sync = "display-resample";

      audio-file-auto = "fuzzy";
      volume-max = 150;
      pulse-buffer = 50;
      audio-pitch-correction = "yes";
      alang = "ind,id,jpn,jp,ko,eng,en,enUS,en-US";
      slang = "ind,id,eng,en";

      sub-auto = "fuzzy";
      sub-ass-override = "force";
      sub-use-margins = "no";
      sub-font = "Aporetic Sans";
      sub-font-size = 32;
      sub-border-size = 2;
      sub-back-color = "000000";
      sub-shadow-offset = 1;
      secondary-sub-pos = 6;
    };

    profiles = {
      "2K rendering" = {
        profile-desc = "2K rendering";
        profile-cond = "height >= 1440  and not (audio_codec and (container_fps == nil or container_fps == 1))";
        hwdec = "auto-safe";
      };

      audio = {
        sub-font = "Aporetic Sans";
        profile-cond = "audio_codec and (container_fps == nil or container_fps == 1)";
      };
    };

    bindings = {
      "=" = "add sub-font-size +1";
      "-" = "add sub-font-size -1";

      "WHEEL_UP" = "add volume 5";
      "WHEEL_DOWN" = "add volume -5";

      "ctrl+s" = ''playlist-shuffle ; show-text "Shuffled playlist"'';

      "ctrl+b" = "script-binding detectdualsubs/key_bind_check_for_dual_subs";

      "s" = "script-binding screenshotfolder/screenshot_done";

      "ctrl+f" = "script-binding selectformat/menu";
      "ctrl+n" = "script-binding smartskip/add-chapter";

      "g" = "script-binding sponsorblock/set_segment";
      "G" = "script-binding sponsorblock/submit_segment";
      "h" = "script-binding sponsorblock/upvote_segment";
      "H" = "script-binding sponsorblock/downvote_segment";

      # Anime4K shaders
      "ctrl+1" = anime4kBinding;
      "ctrl+0" = clearShaders;

      # Tone-mapping profiles
      "ctrl+2" = "set tone-mapping mobius";
      "ctrl+3" = "set tone-mapping reinhard";
      "ctrl+4" = "set tone-mapping bt.2390";
      "ctrl+5" = "set tone-mapping clip";
      "ctrl+6" = "set tone-mapping spline";
      "ctrl+7" = "set tone-mapping bt.2446a";
      "ctrl+8" = "set tone-mapping st2094-40";
      "ctrl+9" = "set tone-mapping st2094-10";

      "ctrl+j" = "add sub-delay -0.010";
      "ctrl+k" = "add sub-delay 0.010";
    };
  };
}
