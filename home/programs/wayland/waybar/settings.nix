{pkgs, ...}: {
  programs.waybar = {
    settings = [
      {
        layer = "top";
        spacing = 4;
        exclusive = true;
        margin-top = 5;
        margin-left = 7;
        margin-right = 7;
        modules-left = [
          "image"
          "group/left"
          "custom/sep"
          "niri/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "group/info"
          "custom/sep"
          "wireplumber"
          "network"
          "battery"
        ];

        "image" = {
          path = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
          size = 24;
          tooltip = false;
        };

        "niri/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          format-icons = {
            "default" = "";
            "urgent" = "";
            "focused" = "";
          };
        };

        "group/left" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "niri/workspaces"
            "idle_inhibitor"
          ];
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        "niri/window" = {
          format = "󰣆  {title}";
          max-length = 40;
          separate-outputs = true;
          rewrite = {
            "^.*( — Zen Browser|Zen Browser)$" = "󰈹 Zen";
            "^.*( — Firefox|Firefox)$" = "󰈹 Firefox";
            "^.*( — Chromium|Chromium)$" = "󰈹 Chromium";
            "^.*v( .*|$)" = " Neovim";
            "^.*~$" = "󰄛 Kitty";
            "^.*(- Spotify|Spotify)$" = "󰏤 Spotify";
            "^.*(- Code|Code)$" = "󰈹 VSCode";
            "(.*) " = " Empty";
          };
        };

        "group/info" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-right-to-left = true;
          };
          modules = ["tray" "custom/notifications"];
        };

        network = {
          format-disconnected = "󰤮";
          format-ethernet = "󰈀";
          format-wifi = "󰤨";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        wireplumber = {
          format = "{icon}";
          format-muted = "󰖁";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &> /dev/null";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%- &> /dev/null";
          tooltip-format = "Volume: {volume}%";
        };

        "group/backlight-modules" = {
          modules = [
            "backlight#icon"
            "backlight#percent"
          ];
          orientation = "inherit";
        };
        "backlight#icon" = {
          format = "{icon}";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%- &> /dev/null";
          tooltip-format = "Backlight: {percent}%";
        };
        "backlight#percent" = {
          format = "{percent}%";
          tooltip-format = "Backlight: {percent}%";
        };

        battery = {
          format = "{icon}";
          format-time = "{H}h {M}min left";
          format-charging = "󱐋";
          format-icons = ["" "" "" "" ""];
          format-plugged = "󰚥";
          states = {
            warning = 20;
            critical = 15;
          };
          tooltip-format = "{capacity}% ({time})";
          tooltip-format-charging = "{capacity}% (charging)";
        };

        tray = {
          icon-size = 10;
          spacing = 8;
          show-passive-items = false;
        };

        clock = {
          actions = {
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
            on-click-right = "mode";
          };
          calendar = {
            format = {
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              months = "<span color='#ff6699'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              weekdays = "<span color='#ff6699'><b>{}</b></span>";
            };
            mode = "month";
            on-scroll = 1;
          };
          format = "{:%I:%M %p}";
          tooltip-format = "{calendar}";
        };

        "custom-sep" = {
          format = "|";
          tooltip = false;
        };

        mpris = {
          player-icons = {
            firefox = "";
            spotify = "";
          };
          status-icons = {
            playing = "▶";
            paused = "⏸";
          };
          format-playing = "<span font-family=\"Font Awesome 6 Free\">{player_icon} </span> {artist} - {title}";
          format-paused = "<span font-family=\"Font Awesome 6 Free\">{status_icon} </span> {artist} - {title}";
          format-stopped = "";
          tooltip-format = "{dynamic}";
          dynamic-len = 50;
        };

        "group/powers" = {
          drawer = {
            children-class = "not-power";
            transition-duration = 500;
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/lock"
            "custom/suspend"
            "custom/exit"
            "custom/reboot"
          ];
          orientation = "inherit";
        };
        "custom/power" = {
          format = "󰐥";
          on-double-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          on-click = "${pkgs.systemd}/bin/loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "󰤄";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
          tooltip = false;
        };
        "custom/exit" = {
          format = "󰍃";
          on-click = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };
        "custom/notifications" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󱅫";
            none = "󰂚";
            dnd-notification = "󰂛";
            dnd-none = "󰂛";
            inhibited-notification = "󰂚";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "${pkgs.swaynotificationcenter}/bin/swaync-client";
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          escape = true;
        };
      }
    ];

    style = ''
      * {
          font-family: "Adwaita Sans", "Font Awesome 6 Free", sans-serif;
          font-size: 9pt;
          min-height: 27px;
      }

      window#waybar {
      	all:unset;
      	background-color: rgba(0, 0, 0, 0);
      	border: none;
      	border-radius: 18;
      	transition-property: background-color;
      	transition-duration: 0.5s;
      }

      button {
      	/* Use box-shadow instead of border so the text isn't offset */
      	box-shadow: inset 0 0 transparent;
      	color: #DCD7BA;
      	border: none;
      	border-radius: 0;
      }

      /* Idle Inhibitor */
      #idle_inhibitor {
        background: #1f1f28;
        color: #ffffff;
        padding: 0 0.75em;
        border-radius: 18px;
      }

      #idle_inhibitor.deactivated {
        color: #ffffff;
        background: #1f1f28;
      }

      #window {
        background: #1f1f29;
        margin: 0rem 0.25rem;
        border-radius: 8px;
      }
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
      	background: transparent;
      }

      tooltip {
      	background-color: #1F1F28;
      	border-radius: 8px;
      }

      #workspaces,
      #clock,
      #mpris,
      .modules-left {
      	background-color: #1F1F28;
      	border-radius: 8pt;
      	color: #DCD7BA;
      }

      .modules-left {
      	padding: 0 0.5em;
      }
      .modules-right {
      	background-color: #1F1F28;
      	border-radius: 8pt;
      	color: #DCD7BA;
      }

      .modules-right {
      	padding: 0 0.5em;
      }

      #workspaces {
      	font-weight: bold;
      	font-size: 8pt;
      }

      #workspaces button {
      	padding: 0 0.25em;
      	margin: 0.5 0em
      }

      #workspaces button.visible {
      	color: #DCD7BA;
      }

      #workspaces button.empty {
      	color: #727169;
      }

      #workspaces button.active {
      	background: transparent;
      	color: #DCD7BA;
      }

      #clock {
      	padding: 0 0.5em;
      	font-weight: bold;
      	font-size: 8pt;
      	color: #DCD7BA;
      }

      #mpris {
      	padding: 0 1em;
      	font-weight: bold;
      	font-size: 8pt;
      	color: #DCD7BA;
      }

      /* #battery.charging { */
      /* 	color: green; */
      /* } */

      #tray {
      	font-size: 8pt;
      	padding: 0 0.5em;
      }

      #custom-notifications {
      	font-size: 8pt;
      	padding: 0 0.5em;
      }

      #battery,
      #network {
      	font-size: 8pt;
      	padding: 0 0.10em;
      	margin: 0 0.5em;
      	background: #1F1F28;
      }
      #wireplumber {
      	font-size: 8pt;
      	padding: 0 0em;
      	background: #1F1F28;
      }

      #battery.warning {
      	color: yellow;
      }

      #battery.critical {
      	color: red;
      }
    '';
  };
}
