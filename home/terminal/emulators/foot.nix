{
  pkgs,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "Aporetic Serif Mono:size=12";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        pad = "4x4 center";
        selection-target = "clipboard";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      desktop-notifications = {
        command = "${lib.getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };

      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      };

      cursor = {
        style = "beam";
        beam-thickness = 1;
        color = "191724 e0def4";
      };

      colors = {
        alpha = 0.9;
        background = "191724";
        foreground = "e0def4";

        regular0 = "26233a"; # black
        regular1 = "eb6f92"; # red
        regular2 = "9ccfd8"; # green
        regular3 = "f6c177"; # yellow
        regular4 = "31748f"; # blue
        regular5 = "c4a7e7"; # magenta
        regular6 = "ebbcba"; # cyan
        regular7 = "e0def4"; # white

        bright0 = "47435d"; # bright black
        bright1 = "ff98ba"; # bright red
        bright2 = "c5f9ff"; # bright green
        bright3 = "ffeb9e"; # bright yellow
        bright4 = "5b9ab7"; # bright blue
        bright5 = "eed0ff"; # bright magenta
        bright6 = "ffe5e3"; # bright cyan
        bright7 = "fefcff"; # bright white

        flash = "f6c177"; # visual bell (yellow / Gold)
      };
    };
  };
}
