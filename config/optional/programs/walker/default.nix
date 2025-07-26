{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.writers) writeTOML;
  inherit (config.local.style.gtk) iconTheme;
in {
  # FIXME: seems to stop when another instance is launched
  # hm.systemd.user.services.walker = {
  #   Unit.Description = "Walker - Application Runner";
  #   Install.WantedBy = ["graphical-session.target"];
  #   Service = {
  #     ExecStart = "${pkgs.walker}/bin/walker --gapplication-service";
  #     Restart = "on-failure";
  #   };
  # };

  hj = {
    packages = [pkgs.walker];
    files = {
      ".config/walker/config.toml".source = writeTOML "walker-config.toml" {
        app_launch_prefix = "uwsm app -- ";
        theme = "gtk";
      };
      ".config/walker/themes/gtk.css".source = ./gtk.css;
      ".config/walker/themes/gtk.toml".source = writeTOML "walker-gtk-config.toml" {
        ui.anchors = {
          bottom = true;
          left = true;
          right = true;
          top = true;
        };

        ui.window = {
          h_align = "fill";
          v_align = "fill";
        };

        ui.window.box = {
          h_align = "center";
          width = 450;

          bar = {
            orientation = "horizontal";
            position = "end";

            entry = {
              h_align = "fill";
              h_expand = true;
            };

            entry.icon = {
              h_align = "center";
              h_expand = true;
              pixel_size = 24;
              theme = iconTheme.name;
            };
          };

          margins = {
            top = 200;
          };

          ai_scroll = {
            name = "aiScroll";
            h_align = "fill";
            v_align = "fill";
            max_height = 300;
            min_width = 400;
            height = 300;
            width = 400;

            margins = {
              top = 8;
            };

            list = {
              name = "aiList";
              orientation = "vertical";
              width = 400;
              spacing = 10;

              item = {
                name = "aiItem";
                wrap = true;
                h_align = "fill";
                v_align = "fill";
                x_align = 0;
                y_align = 0;
              };
            };
          };

          scroll.list = {
            max_height = 300;
            max_width = 400;
            min_width = 400;
            width = 400;
          };

          item.activation_label = {
            h_align = "fill";
            v_align = "fill";
            width = 20;
            x_align = 0.5;
            y_align = 0.5;
          };

          item.icon = {
            pixel_size = 26;
          };

          margins = {
            top = 8;
          };

          search = {
            prompt = {
              name = "prompt";
              icon = "edit-find";
              pixel_size = 16;
              h_align = "center";
              v_align = "center";
            };

            clear = {
              name = "clear";
              icon = "edit-clear";
              pixel_size = 16;
              h_align = "center";
              v_align = "center";
            };

            input = {
              icons = true;
              h_align = "fill";
              h_expand = true;
            };

            spinner = {
              hide = true;
            };
          };
        };
      };
    };
  };
}
