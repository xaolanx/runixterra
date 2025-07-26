{pkgs, lib, ...}: let
  shaderFolder = ./shaders;
in {
  hj = {
    packages = [
      (pkgs.mpv.override {
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
    files = {
      ".config/mpv/mpv.conf".text = ''
        profile=fast

        alang=ind,id,jpn,jp,ko,eng,en,enUS,en-US
        audio-file-auto=fuzzy
        audio-pitch-correction=yes
        autocreate-playlist=filter
        border=no
        brightness=2.000000
        contrast=1.000000
        correct-downscaling=no
        directory-filter-types=video,audio
        directory-mode=ignore
        dither=no
        dscale=bilinear
        gamut-mapping-mode=desaturate
        hdr-compute-peak=yes
        hdr-contrast-recovery=0.300000
        hdr-peak-percentile=99.995000
        hls-bitrate=max
        hwdec=vulkan
        hwdec-codecs=all
        gpu-context=waylandvk
        keep-open=yes
        msg-color=yes
        msg-module=yes
        osc=no
        osd-bar=no
        osd-duration=2000
        osd-font=Aporetic Serif
        osd-font-size=30
        osd-outline-size=2
        profile=fast
        pulse-buffer=50
        save-position-on-quit=yes
        scale=bilinear
        secondary-sub-pos=6
        slang=ind,id,eng,en
        sub-ass-override=force
        sub-auto=fuzzy
        sub-back-color=000000
        sub-border-size=2
        sub-font=Aporetic Sans
        sub-font-size=32
        sub-shadow-offset=1
        sub-use-margins=no
        target-peak=300
        title-bar=no
        tone-mapping=st2094-40
        video-sync=display-resample
        vo=gpu-next
        volume-max=150
        ytdl-format=bestvideo[height<=?1080][vcodec!*=av01][vcodec^=avc1]+bestaudio/best

        [2K rendering]
        hwdec=auto-safe
        profile-cond=height >= 1440  and not (audio_codec and (container_fps == nil or container_fps == 1))
        profile-desc=2K rendering

        [audio]
        profile-cond=audio_codec and (container_fps == nil or container_fps == 1)
        sub-font=Aporetic Sans
      '';

      ".config/mpv/input.conf".text = ''
        CTRL+1 no-osd change-list glsl-shaders set "${lib.concatStringsSep ":" [
          "${shaderFolder}/Anime4K_AutoDownscalePre_x2.glsl"
          "${shaderFolder}/Anime4K_AutoDownscalePre_x4.glsl"
          "${shaderFolder}/Anime4K_Clamp_Highlights.glsl"
          "${shaderFolder}/Anime4K_Restore_CNN_M.glsl"
          "${shaderFolder}/Anime4K_Restore_CNN_VL.glsl"
          "${shaderFolder}/Anime4K_Upscale_CNN_x2_M.glsl"
          "${shaderFolder}/Anime4K_Upscale_CNN_x2_VL.glsl"
        ]}"; show-text "Anime4K: Mode A+A (HQ)"

        - add sub-font-size -1
        = add sub-font-size +1
        G script-binding sponsorblock/submit_segment
        H script-binding sponsorblock/downvote_segment
        WHEEL_DOWN add volume -5
        WHEEL_UP add volume 5
        ctrl+2 set tone-mapping reinhard
        ctrl+3 set tone-mapping mobius
        ctrl+4 set tone-mapping hable
        ctrl+5 set tone-mapping bt.2390
        ctrl+6 set tone-mapping spline
        ctrl+7 set tone-mapping bt.2446a
        ctrl+8 set tone-mapping st2094-40
        ctrl+9 set tone-mapping st2094-10
        ctrl+b script-binding detectdualsubs/key_bind_check_for_dual_subs
        ctrl+f script-binding selectformat/menu
        ctrl+j add sub-delay -0.010
        ctrl+k add sub-delay 0.010
        ctrl+n script-binding smartskip/add-chapter
        ctrl+s playlist-shuffle ; show-text "Shuffled playlist"
        g script-binding sponsorblock/set_segment
        h script-binding sponsorblock/upvote_segment
        s script-binding screenshotfolder/screenshot_done

        CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
      '';
    };
  };
}
