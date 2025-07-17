{
  pkgs,
  lib,
  ...
}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["fast"];
    scripts = with pkgs.mpvScripts; [
      sponsorblock
      thumbnail
      # smartskip
      # modernz
      autosubsync-mpv
      autoload
      smart-copy-paste-2
      uosc
    ];

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

      vo = "gpu";
      profile = "fast";
      hwdec = "auto-safe";
      hwdec-codecs = "all";
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

      "ctrl+1" = "set tone-mapping reinhard";
      "ctrl+2" = "set tone-mapping mobius";
      "ctrl+3" = "set tone-mapping hable";
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
