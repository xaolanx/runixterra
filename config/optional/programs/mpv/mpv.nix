{
  pkgs,
  lib,
  myLib,
  ...
}: let
  inherit (myLib.generators) toMpvConf;
  shaderFolder = ./shaders;
in {
  environment.systemPackages = [
    (pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg.override {
          ffmpegVariant = "full";
          withMfx = true;
          withVpl = false;
          withCuda = false;
          withCudaLLVM = false;
          withUnfree = true;
        };
      };
      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        thumbfast
        sponsorblock
        autoload
        smart-copy-paste-2
      ];
    })
  ];

  hj = {
    files = {
      ".config/mpv/mpv.conf".text = toMpvConf {
        profile = "fast";
        alang = ["ind" "id" "jpn" "jp" "ko" "eng" "en" "enUS" "en-US"];
        audio-file-auto = "fuzzy";
        audio-pitch-correction = true;
        autocreate-playlist = "filter";
        border = false;
        brightness = 2.0;
        contrast = 1.0;
        correct-downscaling = false;
        directory-filter-types = ["video" "audio"];
        directory-mode = "ignore";
        dither = false;
        dscale = "bilinear";
        gamut-mapping-mode = "desaturate";
        hdr-compute-peak = true;
        hdr-contrast-recovery = 0.3;
        hdr-peak-percentile = 99.995;
        hls-bitrate = "max";
        hwdec = "vaapi";
        gpu-context = "wayland";
        gpu-api = "opengl";
        hwdec-codecs = "all";
        keep-open = true;
        msg-color = true;
        msg-module = true;
        osc = false;
        osd-bar = false;
        osd-duration = 2000;
        osd-font = "Aporetic Serif";
        osd-font-size = 30;
        osd-outline-size = 2;
        pulse-buffer = 50;
        save-position-on-quit = true;
        scale = "bilinear";
        secondary-sub-pos = 6;
        slang = ["ind" "id" "eng" "en"];
        sub-ass-override = "force";
        sub-auto = "fuzzy";
        sub-back-color = "000000";
        sub-border-size = 2;
        sub-font = "Aporetic Sans";
        sub-font-size = 32;
        sub-shadow-offset = 1;
        sub-use-margins = false;
        target-peak = 300;
        title-bar = false;
        tone-mapping = "st2094-40";
        video-sync = "display-resample";
        vo = "gpu-next";
        volume-max = 150;
        ytdl-format = "bestvideo[height<=?1080][vcodec!*=av01][vcodec^=avc1]+bestaudio/best";

        # Sections
        __section_2K_rendering = {
          hwdec = "auto-safe";
          "profile-cond" = "height >= 1440  and not (audio_codec and (container_fps == nil or container_fps == 1))";
          "profile-desc" = "2K rendering";
        };

        __section_audio = {
          "profile-cond" = "audio_codec and (container_fps == nil or container_fps == 1)";
          "sub-font" = "Aporetic Sans";
        };
      };

      ".config/mpv/input.conf".text = toMpvConf {
        # Keybindings utama
        "CTRL+1" = ''no-osd change-list glsl-shaders set "${lib.concatStringsSep ":" [
            "${shaderFolder}/Anime4K_AutoDownscalePre_x2.glsl"
            "${shaderFolder}/Anime4K_AutoDownscalePre_x4.glsl"
            "${shaderFolder}/Anime4K_Clamp_Highlights.glsl"
            "${shaderFolder}/Anime4K_Restore_CNN_M.glsl"
            "${shaderFolder}/Anime4K_Restore_CNN_VL.glsl"
            "${shaderFolder}/Anime4K_Upscale_CNN_x2_M.glsl"
            "${shaderFolder}/Anime4K_Upscale_CNN_x2_VL.glsl"
          ]}"; show-text "Anime4K: Mode A+A (HQ)"'';

        # Keybindings dengan modifier
        "-" = "add sub-font-size -1";
        "=" = "add sub-font-size +1";
        "G" = "script-binding sponsorblock/submit_segment";
        "H" = "script-binding sponsorblock/downvote_segment";
        "WHEEL_DOWN" = "add volume -5";
        "WHEEL_UP" = "add volume 5";

        # Tone mapping presets
        "ctrl+2" = "set tone-mapping reinhard";
        "ctrl+3" = "set tone-mapping mobius";
        "ctrl+4" = "set tone-mapping hable";
        "ctrl+5" = "set tone-mapping bt.2390";
        "ctrl+6" = "set tone-mapping spline";
        "ctrl+7" = "set tone-mapping bt.2446a";
        "ctrl+8" = "set tone-mapping st2094-40";
        "ctrl+9" = "set tone-mapping st2094-10";

        # Script bindings
        "ctrl+b" = "script-binding detectdualsubs/key_bind_check_for_dual_subs";
        "ctrl+f" = "script-binding selectformat/menu";
        "ctrl+j" = "add sub-delay -0.010";
        "ctrl+k" = "add sub-delay 0.010";
        "ctrl+n" = "script-binding smartskip/add-chapter";
        "ctrl+s" = "playlist-shuffle ; show-text \"Shuffled playlist\"";
        "g" = "script-binding sponsorblock/set_segment";
        "h" = "script-binding sponsorblock/upvote_segment";
        "s" = "script-binding screenshotfolder/screenshot_done";

        # Shader clear
        "CTRL+0" = ''no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"'';
      };

      ".config/mpv/script-opts/SmartCopyPaste_II.conf".text = toMpvConf {
        linux_copy = "wl-copy";
        linux_paste = "wl-paste";
      };
    };
  };
}
