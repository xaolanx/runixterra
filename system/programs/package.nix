{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs) callPackage;

  wrappedPackages = {
    hyprlock = callPackage ./wrapped/hyprlock {inherit pkgs config;};
    hyprpaper = callPackage ./wrapped/hyprpaper {inherit pkgs config;};
  };
in {
  config = {
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
      kdePackages.elisa
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
    _module.args.wrappedPkgs = wrappedPackages;
  };
}
