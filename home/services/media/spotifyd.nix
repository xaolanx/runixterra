{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    spotify-tui
  ];

  services.spotifyd = {
    enable = true;
    package = pkgs.spotifyd.override {withMpris = true;};
    settings.global = {
      autoplay = true;
      backend = "pulseaudio";
      bitrate = 320;
      cache_path = "${config.xdg.cacheHome}/spotifyd";
      device_type = "computer";
      initial_volume = "100";
      use_mpris = true;
      volume_normalisation = false;
    };
  };
}
