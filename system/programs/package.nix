{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    anyrun

    # Socmed
    telegram-desktop

    # Browsers
    brave
    # zen-browser

    # Media
    youtube-music
    playerctl
    audacious
    (mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        thumbfast
        sponsorblock
        autoload
      ];
    })

    # Terminal
    micro
    git
  ];
}
