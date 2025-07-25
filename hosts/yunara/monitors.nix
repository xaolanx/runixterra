_: {
  local.monitors = [
    {
      name = "eDP-1";
      refreshRate = 60;
      resolution = {
        width = 1366;
        height = 736;
      };
      primary = true;
      position = {
        x = 0;
        y = 0;
      };
    }
    # {
    #   name = "HDMI-A-1";
    #   resolution = {
    #     width = 1920;
    #     height = 1080;
    #   };
    #   position = {
    #     x = 0;
    #     y = 0;
    #   };
    # }
  ];
}
