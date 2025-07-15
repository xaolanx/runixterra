{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs) callPackage;

  wrappedPackages = {
    hyprlock = callPackage ./wrapped/hyprlock.nix {inherit pkgs config;};
    hyprpaper = callPackage ./wrapped/hyprpaper.nix {inherit pkgs config;};
  };
in {
  config = {
    environment.systemPackages = with pkgs; [
      anyrun

      # Socmed
      telegram-desktop

      # Browsers
      brave
      zen-browser

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
      npins
      nvd
      nix-output-monitor
    ];

    _module.args.wrappedPkgs = wrappedPackages;
  };
}
