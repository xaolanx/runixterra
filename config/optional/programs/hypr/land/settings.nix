{
  lib,
  inputs',
  pkgs,
  config,
  ...
}: let
  inherit (builtins) concatStringsSep toString;
  inherit (lib.attrsets) optionalAttrs;

  toMonitorConf = m: let
    toResolutionString = res: rr: "${toString res.width}x${toString res.height}@${toString rr}";
    toPositionString = pos:
      if pos != null
      then "${toString pos.x}x${toString pos.y}"
      else "0x0";
  in
    concatStringsSep ", " [
      m.name
      (toResolutionString m.resolution m.refreshRate)
      (toPositionString m.position)
      (toString m.scale)
    ];

  styleCfg = config.local.style;
in {
  programs.hyprland = {
    enable = true;
    package = inputs'.hyprland.packages.hyprland;
    portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
    withUWSM = true;
    systemd.setPath.enable = true;
  };

  /*
  needed so that loginctl can cleanup the session correctly with uwsm
  (see https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#universal-wayland-session-manager)
  */
  services.dbus.implementation = "broker";

  hj = {
    packages = [
      inputs'.hyprwm-contrib.packages.grimblast
    ];

    rum.desktops.hyprland = {
      enable = true;
      plugins = [
        inputs'.split-monitor-workspaces.packages.default
      ];
      settings =
        {
          xwayland = {
            force_zero_scaling = true;
          };

          exec-once = [
            "${pkgs.xorg.xrandr}/bin/xrandr --output 'DP-1' --primary"
            "qs -c kurukurubar"
          ];

          cursor = {
            no_hardware_cursors = 1;
          };

          monitor = map toMonitorConf config.local.monitors;

          workspace = [
            "special:terminal, on-created-empty:ghostty"
            "special:file_manager_gui, on-created-empty:pcmanfm"
            "special:file_manager_tui, on-created-empty:ghostty -e yazi"

            "special:calculator_gui, on-created-empty:qalculate-gtk"
            "special:mixer_gui, on-created-empty:pavucontrol"
          ];

          windowrule =
            [
              # fixes fullscreen windows (mostly games)
              "stayfocused, initialtitle:^()$, initialclass:^(steam)$"
              "minsize 1 1, initialtitle:^()$, initialclass:^(steam)$"
              "maximize, initialtitle:^(\S+)$, initialclass:^(steamwebhelper)$"

              "immediate, initialclass:^(steam_app_)(.*)$"
              "fullscreen, initialclass:^(steam_app_)(.*)$"

              # inhibit idle on fullscreen apps (avoids going idle on games when playing with gamepad)
              "idleinhibit always, fullscreen:1"

              "float, title:^(Picture-in-Picture)$"
              "pin, title:^(Picture-in-Picture)$"
            ]
            # make polkit-kde-authentication-agent-1 a centered floating window
            ++ (map (rule: rule + ", class:^(org.kde.polkit-kde-authentication-agent-1)$") [
              "float"
              "center 1"
              "stayfocused"
              "size 30% 25%"
              "focusonactivate"
            ]);
          windowrulev2 = [
            # telegram media viewer
            "float, title:^(Media viewer)$"

            # Bitwarden extension
            "float, title:^(.*Bitwarden Password Manager.*)$"

            # gnome calculator
            "float, class:^(org.gnome.Calculator)$"
            "size 360 490, class:^(org.gnome.Calculator)$"

            # allow tearing in games
            "immediate, class:^(osu\!|cs2)$"

            # make Firefox/Zen PiP window floating and sticky
            "float, title:^(Picture-in-Picture)$"
            "pin, title:^(Picture-in-Picture)$"

            # throw sharing indicators away
            "workspace special silent, title:^(Firefox — Sharing Indicator)$"
            "workspace special silent, title:^(Zen — Sharing Indicator)$"
            "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

            # start Spotify and YouTube Music in ws9
            "workspace 9 silent, title:^(Spotify( Premium)?)$"
            "workspace 9 silent, title:^(YouTube Music)$"

            # idle inhibit while watching videos
            "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
            "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
            "idleinhibit fullscreen, class:^(zen)$"

            "dimaround, class:^(gcr-prompter)$"
            "dimaround, class:^(xdg-desktop-portal-gtk)$"
            "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
            "dimaround, class:^(zen)$, title:^(File Upload)$"

            # fix xwayland apps
            "rounding 0, xwayland:1"
            "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
            "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

            # Matlab
            "tile, title:MATLAB"
            "noanim on, class:MATLAB, title:DefaultOverlayManager.JWindow"
            "noblur on, class:MATLAB, title:DefaultOverlayManager.JWindow"
            "noborder on, class:MATLAB, title:DefaultOverlayManager.JWindow"
            "noshadow on, class:MATLAB, title:DefaultOverlayManager.JWindow"
            "plugin:hyprbars:nobar, class:MATLAB, title:DefaultOverlayManager.JWindow"

            # don't render hyprbars on tiling windows
            "plugin:hyprbars:nobar, floating:0"

            # less sensitive scroll for some windows
            # browser(-based)
            "scrolltouchpad 0.1, class:^(zen|firefox|chromium-browser|chrome-.*)$"
            "scrolltouchpad 0.1, class:^(obsidian)$"
            "scrolltouchpad 0.1, class:^(steam)$"
            "scrolltouchpad 0.1, class:^(Zotero)$"
            # GTK3
            "scrolltouchpad 0.1, class:^(com.github.xournalpp.xournalpp)$"
            "scrolltouchpad 0.1, class:^(libreoffice.*)$"
            "scrolltouchpad 0.1, class:^(.virt-manager-wrapped)$"
            "scrolltouchpad 0.1, class:^(xdg-desktop-portal-gtk)$"
            # Qt5
            "scrolltouchpad 0.1, class:^(org.prismlauncher.PrismLauncher)$"
            "scrolltouchpad 0.1, class:^(org.kde.kdeconnect.app)$"
            # Others
            "scrolltouchpad 0.1, class:^(org.pwmt.zathura)$"
          ];

          layerrule = let
            toRegex = list: let
              elements = lib.concatStringsSep "|" list;
            in "^(${elements})$";

            lowopacity = [
              "bar"
              "calendar"
              "notifications"
              "system-menu"
            ];

            highopacity = [
              "anyrun"
              "osd"
              "logout_dialog"
            ];

            blurred = lib.concatLists [
              lowopacity
              highopacity
            ];
          in [
            "blur, ${toRegex blurred}"
            "xray 1, ${toRegex ["bar"]}"
            "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
            "ignorealpha 0.2, ${toRegex lowopacity}"
          ];

          render = {
            expand_undersized_textures = false;
          };

          bezier = "overshot, 0.05, 0.9, 0.1, 1.1";

          animations = {
            enabled = true;
            animation = [
              "windows, 1, 5, overshot"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          input = {
            kb_options = "compose:ralt";
            touchpad = {
              natural_scroll = true;
              scroll_factor = 0.8;
              tap-to-click = true;
              clickfinger_behavior = true;
            };
          };

          gestures = {
            workspace_swipe = true;
            workspace_swipe_direction_lock = false;
            workspace_swipe_cancel_ratio = 0.15;
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            middle_click_paste = false;
          };
          plugin = {
            split-monitor-workspaces = {
              count = 4;
            };
          };
        }
        // (optionalAttrs styleCfg.enable {
          general = {
            gaps_in = 4;
            gaps_out = 8;
            border_size = 4;
            "col.active_border" = "rgb(${styleCfg.colors.scheme.base0D})";
            "col.inactive_border" = "rgb(${styleCfg.colors.scheme.base03})";
          };
          decoration = {
            rounding = 10;
            rounding_power = 3;
            blur = {
              enabled = true;
              size = 5;
              passes = 3;
              ignore_opacity = true;
              new_optimizations = 1;
              xray = true;
              contrast = 0.7;
              brightness = 0.8;
              vibrancy = 0.2;
              special = true;
            };

            shadow = {
              enabled = true;
              range = 32;
              render_power = 3;
              ignore_window = true;
              scale = 1;
              color = "rgba(00000048)";
              color_inactive = "rgba(00000028)";
            };
          };
        });
    };
  };
}
