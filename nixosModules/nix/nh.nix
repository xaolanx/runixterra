{
  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
  # environment.sessionVariables = rec {
  #   NH_FILE = "/home/xaolan/freljord";
  # };
}
