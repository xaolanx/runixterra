{pkgs, ...}: {
  hj = {
    packages = [
      pkgs.mangohud
      pkgs.qbittorrent
    ];
  };

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
    coolercontrol.enable = true;
  };

  # services.hardware.openrgb.enable = true;
}
