{
  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 4d";
    };
  };
  # nh default flake
  environment.variables.NH_FLAKE = "/home/xaolan/Code/rum";
}
