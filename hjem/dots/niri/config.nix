{
  ".config/niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us"
                model ""
                rules ""
                variant ""
            }
            repeat-delay 600
            repeat-rate 25
            track-layout "global"
        }
        touchpad {
            tap
            dwt
            dwtp
            natural-scroll
            accel-profile "adaptive"
            scroll-method "two-finger"
            click-method "clickfinger"
            tap-button-map "left-right-middle"
        }
        warp-mouse-to-focus
        focus-follows-mouse
        workspace-auto-back-and-forth
    }
    output "eDP-1" {
        scale 1
        transform "normal"
        position x=0 y=0
        mode "1920x1080"
    }
    screenshot-path "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png"
    prefer-no-csd
    layout {
        gaps 5
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
        focus-ring { off; }
        border {
            width 2
            active-color "#c4a7e7"
            inactive-color "#6e6a86"
        }
        default-column-width { proportion 0.500000; }
        preset-column-widths {
            proportion 0.333333
            proportion 0.500000
            proportion 0.666667
            proportion 1.000000
        }
        center-focused-column "never"
    }
    cursor {
        xcursor-theme "Bibata-Modern-Ice"
        xcursor-size 18
    }
    hotkey-overlay { skip-at-startup; }
    environment {
        "CLUTTER_BACKEND" "wayland"
        DISPLAY ":0"
        "GDK_BACKEND" "wayland,x11"
        "MOZ_ENABLE_WAYLAND" "1"
        "NIXOS_OZONE_WL" "1"
        "QT_QPA_PLATFORM" "wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"
        "SDL_VIDEODRIVER" "wayland"
        TERM "foot"
        TERMINAL "foot"
    }
    binds {
        Ctrl+Alt+L { spawn "uwsm" "app" "--" "sh -c pgrep hyprlock || hyprlock"; }
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+B { spawn "uwsm" "app" "--" "google-chrome-stable"; }
        Mod+BracketLeft { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+C { center-window; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+D { spawn "uwsm" "app" "--" "anyrun"; }
        Mod+Down { focus-workspace-down; }
        Mod+E { spawn "uwsm" "app" "--" "nautilus"; }
        Mod+End { focus-column-last; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+F { maximize-column; }
        Mod+H { focus-column-left; }
        Mod+Home { focus-column-first; }
        Mod+I { spawn "XDG_CURRENT_DESKTOP=gnome" "uwsm" "app" "--" "gnome-control-center"; }
        Mod+J { focus-window-or-workspace-down; }
        Mod+K { focus-window-or-workspace-up; }
        Mod+L { focus-column-right; }
        Mod+Left { focus-column-left; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+Print { screenshot-window; }
        Mod+Q { close-window; }
        Mod+R { switch-preset-column-width; }
        Mod+Return { spawn "uwsm" "app" "--" "foot"; }
        Mod+Right { focus-column-right; }
        Mod+Shift+BracketLeft { consume-window-into-column; }
        Mod+Shift+BracketRight { expel-window-from-column; }
        Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
        Mod+Shift+Down { move-column-to-workspace-down; }
        Mod+Shift+End { move-column-to-last; }
        Mod+Shift+Equal { set-window-height "+10%"; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+Home { move-column-to-first; }
        Mod+Shift+J { move-column-to-workspace-down; }
        Mod+Shift+K { move-column-to-workspace-up; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Shift+Return { spawn "uwsm" "app" "--" "wezterm"; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+S { screenshot; }
        Mod+Shift+Up { move-column-to-workspace-up; }
        Mod+Space { toggle-window-floating; }
        Mod+Tab { switch-focus-between-floating-and-tiling; }
        Mod+Up { focus-workspace-up; }
        Print { screenshot; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioStop { spawn "playerctl" "pause"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "s" "5%-"; }
        XF86MonBrightnessUp { spawn "brightnessctl" "s" "5%+"; }
    }
    spawn-at-startup "uwsm finalize"
    spawn-at-startup "quickshell -c noctalia"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "telegram-desktop"
    spawn-at-startup "wl-paste --type image --watch cliphist store"
    spawn-at-startup "wl-paste --type text --watch cliphist store"
    window-rule {
        draw-border-with-background false
        geometry-corner-radius 15.000000 15.000000 15.000000 15.000000
        clip-to-geometry true
    }
    window-rule {
        match app-id="google-chrome"
        open-maximized true
    }
    window-rule {
        match app-id="zen"
        open-maximized true
    }
    window-rule {
        match app-id="org.telegram.desktop"
        block-out-from "screencast"
    }
    window-rule {
        match app-id="app.drey.PaperPlane"
        block-out-from "screencast"
    }
    window-rule {
        match app-id="firefox$" title="^Picture-in-Picture$"
        match title="^Picture in picture$"
        match title="^Discord Popout$"
        open-floating true
        default-floating-position relative-to="top-right" x=32 y=32
    }
    window-rule {
        match app-id="^(pwvucontrol)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(Volume Control)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(dialog)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(file_progress)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(confirm)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(download)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(error)" title=""
        open-floating true
    }
    window-rule {
        match app-id="^(notification)" title=""
        open-floating true
    }
    animations { window-resize { custom-shader "vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {\n  vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;\n\n  vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;\n  vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;\n\n  // We can crop if the current window size is smaller than the next window\n  // size. One way to tell is by comparing to 1.0 the X and Y scaling\n  // coefficients in the current-to-next transformation matrix.\n  bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;\n  bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;\n\n  vec3 coords = coords_stretch;\n  if (can_crop_by_x)\n      coords.x = coords_crop.x;\n  if (can_crop_by_y)\n      coords.y = coords_crop.y;\n\n  vec4 color = texture2D(niri_tex_next, coords.st);\n\n  // However, when we crop, we also want to crop out anything outside the\n  // current geometry. This is because the area of the shader is unspecified\n  // and usually bigger than the current geometry, so if we don't fill pixels\n  // outside with transparency, the texture will leak out.\n  //\n  // When stretching, this is not an issue because the area outside will\n  // correspond to client-side decoration shadows, which are already supposed\n  // to be outside.\n  if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))\n      color = vec4(0.0);\n  if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))\n      color = vec4(0.0);\n\n  return color;\n}\n"; }; }
  '';
}
