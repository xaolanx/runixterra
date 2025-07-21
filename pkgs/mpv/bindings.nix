# why is this a nix file?
# well writing this in .conf looks ugly so yeah .w.
{writeText}: let
  shaderFolder = ./shaders;
in
  writeText "input.conf" ''
       CTRL+1 no-osd change-list glsl-shaders set "${builtins.concatStringsSep ":" [
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
  ''
# CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A (HQ)"

